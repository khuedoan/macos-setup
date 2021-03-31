-- Post Escape if Control is tapped, Control if held

send_escape = false
last_mods = {}

control_handler = function(evt)
  local new_mods = evt:getFlags()
  if last_mods["ctrl"] == new_mods["ctrl"] then
    return false
  end
  if not last_mods["ctrl"] then
    last_mods = new_mods
    send_escape = true
  else
    if send_escape then
      hs.eventtap.event.newKeyEvent({}, "escape", true):post()
      hs.eventtap.event.newKeyEvent({}, "escape", false):post()
    end
    last_mods = new_mods
  end
  return false
end

other_handler = function(evt)
  send_escape = false
  return false
end

hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_handler):start()
hs.eventtap.new({hs.eventtap.event.types.keyDown}, other_handler):start()
