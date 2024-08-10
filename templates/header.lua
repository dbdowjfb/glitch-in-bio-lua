local json = require 'pandoc.json'
local file = io.open("settings.json", "r")
print(file == nil and 'file is nil' or 'file is not nil')
local settings = json.decode(file:read("*all"))
local html = function(code)
  return pandoc.RawInline('html', code)
end

renderHeader = { pandoc.Div(
  pandoc.Image( settings.name, -- alt 
  settings.avatarImage, -- image url 
  settings.name, -- title 
  { class = 'avatar' } -- attributes like classes
),
  { class = 'avatar-container' }
), pandoc.Header(
  1,
  settings.name
) }
