Social_svgs = require "templates.social-svgs"
-- write a lot of codes to convert settings.json to a table
local json = require 'pandoc.json'
local inspect = require 'inspect'
local file = io.open("settings.json", "r")
local settings = json.decode(file:read("*all"))
Html = function(code)
  return pandoc.RawInline('html', code)
end
local link = pandoc.Link

function renderSocial(platform)
  if settings.social[platform.name] ~= nil and settings.social[platform.name] ~= "" then
    -- alt = pandoc.Span({})
    -- alt.attributes = {classes = {'platform_alt'}}
    -- table.insert(alt.content, settings.name .. ' on ' .. platform.name)
    local social = pandoc.Link(
      {
        Html(SVGs[platform.name]),
        Html('<li class="platform_alt">'..platform.name..'</li>')
      },
      settings.social[platform.name],
      '',
      ''
    )
    social.attributes = {
      ['aria-label'] = settings.name .. ' on ' .. platform.name,
      tabindex = "1",
      rel = platform.rel,
      alt = settings.name .. ' on ' .. platform.name
    }
    return social
  end
end

function renderEmail()
  if settings.social.email then
    local link = pandoc.Link(
      Html(SVGs.email),                   -- content
      'mailto:' .. settings.social.email, -- target
      '',                                 -- title
      ''                                  -- id
    )
    link.attributes = { ['aria-label'] = settings.name .. ' on email' }
  end
end

socials = {
  { name = "glitch",        altText = "Glitch" },
  { name = "arena",         altText = "Arena" },
  { name = "bandcamp",      altText = "Bandcamp" },
  { name = "cohost",        altText = "Cohost" },
  { name = "devTo",         altText = "DevTo" },
  { name = "facebook",      altText = "Facebook" },
  { name = "github",        altText = "GitHub" },
  { name = "gitlab",        altText = "GitLab" },
  { name = "hasnode",       altText = "Hasnode" },
  { name = "instagram",     altText = "Instagram" },
  { name = "keybase",       altText = "Keybase" },
  { name = "kofi",          altText = "Ko-fi" },
  { name = "letterboxd",    altText = "Letterboxd" },
  { name = "linkedin",      altText = "LinkedIn" },
  { name = "mastodon",      altText = "Mastodon",      rel = "me" },
  { name = "medium",        altText = "Medium" },
  { name = "patreon",       altText = "Patreon" },
  { name = "pinboard",      altText = "Pinboard" },
  { name = "pinterest",     altText = "Pinterest" },
  { name = "podcast",       altText = "Podcast" },
  { name = "onlyfans",      altText = "OnlyFans" },
  { name = "spotify",       altText = "Spotify" },
  { name = "soundcloud",    altText = "SoundCloud" },
  { name = "stackOverflow", altText = "Stack Overflow" },
  { name = "substack",      altText = "Substack" },
  { name = "tiktok",        altText = "TikTok" },
  { name = "twitch",        altText = "Twitch" },
  { name = "twitter",       altText = "Twitter" },
  { name = "tumblr",        altText = "Tumblr" },
  { name = "telegram",      altText = "Telegram" },
  { name = "youtube",       altText = "YouTube" }
};

SocialIcons = function()
  print(socials == nil and 'social is nil' or 'social is not nil')
  result = pandoc.Div(
    {}, --content is now empty
    { class = 'social-icons' }
  )
  -- result.classes = {'social-icons'}
  for _, platform in pairs(socials) do
    print(platform)
    print(renderSocial(platform) == nil and "rendered result is nil" or "rendered result is not nil")
    if renderSocial(platform) ~= nil then
      table.insert(result.content, renderSocial(platform))
    end
  end

  print(renderEmail() == nil and "rendered email is nil" or "rendered email is not nil")
  if renderEmail() ~= nil then
    table.insert(result.content, renderEmail())
  end
  return result
end

renderSocialIcons = SocialIcons()
