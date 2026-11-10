local config = assert(hs.json.read(hs.configdir .. "/kvm-config.json"))
local aspacePath = os.getenv("HOME") .. "/.local/bin/aspace"
local paused = hs.settings.get("kvmPaused") == true
local timer, task, pendingState, appliedState, lastError
local runtime = {menu = hs.menubar.new()}
local menu = runtime.menu

local iconCanvas = hs.canvas.new({x = 0, y = 0, w = 18, h = 18})
iconCanvas:appendElements(
    {type = "rectangle", action = "stroke",
        frame = {x = 1.5, y = 2.5, w = 15, h = 10},
        strokeColor = {white = 0}, strokeWidth = 1.3},
    {type = "segments", action = "stroke",
        coordinates = {{x = 9, y = 12.5}, {x = 9, y = 15.5}},
        strokeColor = {white = 0}, strokeWidth = 1.3},
    {type = "segments", action = "stroke",
        coordinates = {{x = 5.5, y = 15.5}, {x = 12.5, y = 15.5}},
        strokeColor = {white = 0}, strokeWidth = 1.3}
)
menu:setIcon(iconCanvas:imageFromCanvas(), true)
iconCanvas:delete()

local function present()
    local devices = hs.usb.attachedDevices()
    if not devices then return nil end
    for _, device in ipairs(devices) do
        if device.vendorID == config.vendorID
            and device.productID == config.productID then
            return true
        end
    end
    return false
end

local updateMenu
local function changeDisplay(connected)
    if task and task:isRunning() then
        pendingState = connected
        return
    end
    local active = false
    for _, screen in ipairs(hs.screen.allScreens()) do
        if screen:getUUID() == config.displayUUID then active = true; break end
    end
    if active == connected then
        appliedState = connected
        lastError = nil
        updateMenu()
        return
    end
    task = hs.task.new(aspacePath, function(code, out, err)
        task = nil
        lastError = nil
        if code == 0 then
            appliedState = connected
        else
            lastError = (err or "") .. (out or "")
            if lastError == "" then lastError = "aspace exited with status " .. code end
        end
        updateMenu()
        if pendingState ~= nil then
            local nextState = pendingState
            pendingState = nil
            if nextState ~= appliedState then changeDisplay(nextState) end
        end
    end, {connected and "enable" or "disable", config.displayUUID})
    if not task or not task:start() then
        task = nil
        lastError = "Unable to start aspace"
        updateMenu()
    end
end

local function reconcile(force)
    if paused then return end
    local connected = present()
    if connected == nil then return end
    if force or connected ~= appliedState then changeDisplay(connected) end
    updateMenu()
end

local function schedule(force, delay)
    if timer then timer:stop() end
    timer = hs.timer.doAfter(delay or 0.8, function()
        timer = nil
        reconcile(force)
    end)
end

updateMenu = function()
    menu:setTitle(lastError and "!" or "")
    menu:setTooltip(lastError or ("Automatic " .. config.displayName .. " connection"))
    local state = paused and "Automatic switching paused"
        or (present() and "KVM connected to this Mac" or "KVM switched away")
    menu:setMenu({
        {title = state, disabled = true},
        {title = "-"},
        {title = paused and "Resume automatic switching" or "Pause automatic switching",
            fn = function()
                paused = not paused
                hs.settings.set("kvmPaused", paused)
                pendingState = nil
                if timer then timer:stop(); timer = nil end
                if not paused then schedule(true) end
                updateMenu()
            end},
        {title = "-"},
        {title = "Connect LG display", fn = function() changeDisplay(true) end},
        {title = "Disconnect LG display", fn = function() changeDisplay(false) end},
    })
end

runtime.usbWatcher = hs.usb.watcher.new(function()
    schedule(false)
end):start()

runtime.wakeWatcher = hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.systemDidWake then schedule(true, 3) end
end):start()

updateMenu()
schedule(true)
return runtime
