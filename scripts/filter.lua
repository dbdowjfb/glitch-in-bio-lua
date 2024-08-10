-- for each section, append the suitable content
local pandoc = require "pandoc"
require('templates.social')
require 'templates.footer'
require('templates.links')
require'templates.header'
local inspect = require 'inspect'

local function insert_all(a, b)
    print('the type is '.. type(b))
    if type(b) == 'table' then
        for i = 1, #b do
            table.insert(a, b[i])
        end
    else
        table.insert(a, b)
    end
end

local sections = {
    renderHeader,
    renderLinks,
    renderSocialIcons,
    renderFooter
}



Div = function(div)
    -- if the div id is `content`, then append each section to this div
    if div.identifier == "content" then
        print("id is " .. div.identifier)
        print(sections == nil and 'section nil' or 'section not nil')
        contTable = div.content
        for _, section in pairs(sections) do
            print("??")
            print(inspect(section))
            insert_all(contTable,
                section
            )
        end
 
        -- insert_all(
        --     contTable,
        --     {aaaaaaaaaaaaaaaaaa = 'ffffffffffffffffffffffffff'}
        -- )
        -- table.insert(contTable,
        --     pandoc.RawInline('html', '<ul class="link-list"><li>' .. renderLinks(twitter) .. '</li></ul>')
        -- -- pandoc.Link( { ["aria-label"] =  ' dbdo on email' }, "1@1.com", 'mailto:', "" )
        -- )
        -- local link = pandoc.Link("my name",
        --     "mailto:1@1.com",
        --     '', --title
        --     "description",
        --     {},
        --     { test = 'test' },
        --     '1@1.COM'
        -- )
        -- link.attributes = { ['aria-label'] = 'something' }
        -- table.insert(contTable, link)

        div.content = contTable
        -- insert _each_ section within this division
        return div
    end
end
