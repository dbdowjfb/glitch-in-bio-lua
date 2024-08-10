local json = require 'pandoc.json'
local file = io.open("settings.json", "r")
print(file == nil and 'file is nil' or 'file is not nil')
local settings = json.decode(file:read("*all"))
local html = function(code)
    return pandoc.RawInline('html', code)
end


local function renderLink(link)
    if link["img"] ~= nil then
        print("has image")
    end
    return '<li>'
        .. '<a href ="' .. link.url .. '"> <span>' .. link.text .. ' </span> </a>'
        .. '</li>'
end

links = settings.links
inner = ''
for _, link in pairs(settings.links) do
    print(type(renderLink(link)))
    inner = inner .. renderLink(link)
end
renderLinks = html ('<ul class="link-list">'
            .. inner
            .. '</ul>' )
