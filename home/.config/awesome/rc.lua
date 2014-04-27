-- {{{ Required modules.

local awful     = require("awful")
awful.rules     = require("awful.rules")
awful.autofocus = require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local gears     = require("gears")
local obvious   = require("obvious")
local layouts   = require("layouts")
local vain      = require("vain")

-- }}}

-- {{{ Error Handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
                   title = "Oops, there were errors during startup!",
                   text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, an error happened!",
                     text = err })
    in_error = false
  end)
end

-- }}}
-- {{{ Variable Definitions

modifier = "Mod4"                     -- The modifier key.
home     = os.getenv("HOME")          -- The users home directory.
config   = home .. "/.config/awesome" -- The users awesome directory.
themes   = config .. "/themes"        -- The users themes directory.
terminal = "urxvt"
editor   = "vim"

commands = {
  editor = terminal .. " -title vim -e " .. editor
}

-- Load our theme.
beautiful.init(themes .. "/paradoks/theme.lua")
beautiful.useless_gap_width = 35

-- }}}
-- {{{ Layouts & Tags

if beautiful.wallpaper then
  for s = 1, screen.count() do
      gears.wallpaper.maximized(beautiful.wallpaper, s, true)
  end
end

local layouts =
{
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.magnifier,
  vain.layout.cascade,
  vain.layout.cascadebrowse,
  vain.layout.browse,
  vain.layout.termfair,
  vain.layout.uselesstile
}

local tags = {
  -- Tag labels.
  labels = { "\xE2\x8C\x98", -- “main” / ⌘
             "\xE2\x9A\x98", -- “chat” / ⚛
             "\xE2\x98\xB1", -- “code” / ☱
             "\xE2\x99\xAC", -- “media” / ♬
             "\xE2\x8C\xAC"  -- "games" / ⌬
           },

  layout = { layouts[9], layouts[11], layouts[4], layouts[6], layouts[1] }
}

for s = 1, screen.count() do
  tags[s] = awful.tag(tags.labels, s, tags.layout)
end

-- }}}
-- {{{ Widgets
-- {{{ Clock

-- Create a textclock widget
mytextclock = awful.widget.textclock("%I:%M %p")

-- }}}

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modifier }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modifier }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
  local panels = {}
  local geometry = screen[s].geometry
  local screen_width = geometry.width
  local screen_height = geometry.height

  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
                         awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                         awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                         awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                         awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)


  -- Create the wibox
  panels["top"] = awful.wibox({ position = "top", screen = s })

  -- Widgets that are aligned to the left
  local left_layout = wibox.layout.fixed.horizontal()
  left_layout:add(mytaglist[s])
  left_layout:add(mypromptbox[s])

  -- Widgets that are aligned to the right
  local right_layout = wibox.layout.fixed.horizontal()
  if s == 1 then right_layout:add(wibox.widget.systray()) end
  right_layout:add(mytextclock)

  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  --layout:set_middle(tasklayout)
  layout:set_right(right_layout)

  panels["top"]:set_widget(layout)

  -- Create the bottom panel
  panels["bottom"] = awful.wibox({ position = "bottom", screen = s })
  
  -- Create a tasklist widget
  local tasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
  local task_layout = wibox.layout.constraint(tasklist, "exact", screen_width * .8)
  local panel_layout = wibox.layout.align.horizontal()

  panel_layout:set_middle(task_layout)
  panels["bottom"]:set_widget(panel_layout)
end

-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key Bindings
globalkeys = awful.util.table.join(
  awful.key({ modifier, "Control" }, "Left",   awful.tag.viewprev       ),
  awful.key({ modifier, "Control" }, "Right",  awful.tag.viewnext       ),
  awful.key({ modifier,           }, "Escape", awful.tag.history.restore),

  awful.key({ modifier,           }, "Left",
      function ()
          awful.client.focus.byidx( 1)
          if client.focus then client.focus:raise() end
      end),
  awful.key({ modifier,           }, "Right",
      function ()
          awful.client.focus.byidx(-1)
          if client.focus then client.focus:raise() end
      end),

  -- Capture screenshot
  awful.key({ "Mod1", "Shift"  }, "3", function() awful.util.spawn(".bin/screencap desktop") end),
  awful.key({ "Mod1", "Shift"  }, "4", function() awful.util.spawn(".bin/screencap selection") end),

  -- Layout manipulation
  awful.key({ modifier, "Shift"   }, "Left", function () awful.client.swap.byidx(  1)    end),
  awful.key({ modifier, "Shift"   }, "Right", function () awful.client.swap.byidx( -1)    end),
  awful.key({ modifier, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
  awful.key({ modifier, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
  awful.key({ modifier,           }, "u", awful.client.urgent.jumpto),

  awful.key({ modifier,           }, "Return", function () awful.util.spawn(terminal) end),
  awful.key({ modifier, "Control" }, "r", awesome.restart),
  awful.key({ modifier, "Shift"   }, "q", awesome.quit),

  awful.key({ modifier,           }, "equal", function () awful.tag.incmwfact( 0.05)    end),
  awful.key({ modifier,           }, "minus", function () awful.tag.incmwfact(-0.05)    end),

  awful.key({ modifier, "Control" }, "n", awful.client.restore),
  awful.key({ modifier,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end),

  -- Prompt
  awful.key({ modifier },            "r",     function () mypromptbox[mouse.screen]:run() end),

  awful.key({ modifier }, "x",
            function ()
                awful.prompt.run({ prompt = "Run Lua code: " },
                mypromptbox[mouse.screen].widget,
                awful.util.eval, nil,
                awful.util.getdir("cache") .. "/history_eval")
            end),

  awful.key({ modifier },            "e", function () awful.util.spawn_with_shell(commands.editor) end)
)

clientkeys = awful.util.table.join(
  awful.key({ modifier,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
  awful.key({ modifier, "Shift"   }, "c",      function (c) c:kill()                         end),
  awful.key({ modifier,           }, "space",  awful.layout.inc(layouts, 1)                     ),
  awful.key({ modifier, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
  awful.key({ modifier,           }, "o",      awful.client.movetoscreen                        ),
  awful.key({ modifier,           }, "t",      function (c) c.ontop = not c.ontop            end),
  awful.key({ modifier,           }, "n",
      function (c)
          -- The client currently has the input focus, so it cannot be
          -- minimized, since minimized clients can't have the focus.
          c.minimized = true
      end),
  awful.key({ modifier,           }, "m",
      function (c)
          c.maximized_horizontal = not c.maximized_horizontal
          c.maximized_vertical   = not c.maximized_vertical
      end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
      awful.key({ modifier }, "#" .. i + 9,
                function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewonly(tag)
                      end
                end),
      awful.key({ modifier, "Control" }, "#" .. i + 9,
                function ()
                    local screen = mouse.screen
                    local tag = awful.tag.gettags(screen)[i]
                    if tag then
                       awful.tag.viewtoggle(tag)
                    end
                end),
      awful.key({ modifier, "Shift" }, "#" .. i + 9,
                function ()
                    local tag = awful.tag.gettags(client.focus.screen)[i]
                    if client.focus and tag then
                        awful.client.movetotag(tag)
                   end
                end),
      awful.key({ modifier, "Control", "Shift" }, "#" .. i + 9,
                function ()
                    local tag = awful.tag.gettags(client.focus.screen)[i]
                    if client.focus and tag then
                        awful.client.toggletag(tag)
                    end
                end))
end

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modifier }, 1, awful.mouse.client.move),
  awful.button({ modifier }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
  -- Enable sloppy focus
  c:connect_signal("mouse::enter", function(c)
      if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
          and awful.client.focus.filter(c) then
          client.focus = c
      end
  end)

  if not startup then
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      -- awful.client.setslave(c)

      -- Put windows in a smart way, only if they does not set an initial position.
      if not c.size_hints.user_position and not c.size_hints.program_position then
          awful.placement.no_overlap(c)
          awful.placement.no_offscreen(c)
      end
  end

  local titlebars_enabled = false
  if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
      -- buttons for the titlebar
      local buttons = awful.util.table.join(
              awful.button({ }, 1, function()
                  client.focus = c
                  c:raise()
                  awful.mouse.client.move(c)
              end),
              awful.button({ }, 3, function()
                  client.focus = c
                  c:raise()
                  awful.mouse.client.resize(c)
              end)
              )

      -- Widgets that are aligned to the left
      local left_layout = wibox.layout.fixed.horizontal()
      left_layout:add(awful.titlebar.widget.iconwidget(c))
      left_layout:buttons(buttons)

      -- Widgets that are aligned to the right
      local right_layout = wibox.layout.fixed.horizontal()
      right_layout:add(awful.titlebar.widget.floatingbutton(c))
      right_layout:add(awful.titlebar.widget.maximizedbutton(c))
      right_layout:add(awful.titlebar.widget.stickybutton(c))
      right_layout:add(awful.titlebar.widget.ontopbutton(c))
      right_layout:add(awful.titlebar.widget.closebutton(c))

      -- The title goes in the middle
      local middle_layout = wibox.layout.flex.horizontal()
      local title = awful.titlebar.widget.titlewidget(c)
      title:set_align("center")
      middle_layout:add(title)
      middle_layout:buttons(buttons)

      -- Now bring it all together
      local layout = wibox.layout.align.horizontal()
      layout:set_left(left_layout)
      layout:set_right(right_layout)
      layout:set_middle(middle_layout)

      awful.titlebar(c):set_widget(layout)
  end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

local move_to_coding_tag = function(_client)
  local coding_tag = tags[mouse.screen][3]

  awful.client.movetotag(coding_tag, _client)
  awful.tag.viewonly(coding_tag)
end

-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = awful.client.focus.filter,
                   keys = clientkeys,
                   buttons = clientbuttons }
  },
  {
    rule = { class = "URxvt", name = "vim" },
    callback = move_to_coding_tag
  },
  {
    -- Move chromium windows to the first tag on the active screen.
    rule = { class = "Chromium" },
    callback = function(c)
      awful.client.movetotag(tags[mouse.screen][1], c)
    end
  },
  {
    rule = { class = "MPlayer" },
    properties = { floating = true }
  },
  {
    rule = { class = "pinentry" },
    properties = { floating = true }
  },
  {
    rule = { class = "gimp" },
    properties = { floating = true }
  },
  {
    rule = { class = "qemu-system-i386" },
    properties = { floating = true }
  },
  {
    rule = { class = "RemoteMessages" },
    properties = { floating = true },
    callback = function(c)
      awful.placement.centered(c, nil)
    end 
  },
  {
    rule = { class = "Eupnea" },
    properties = { floating = true },
    callback = function(c)
      awful.placement.centered(c, nil)
    end 
  },
  {
    rule = { class = "Steam" },
    properties = { floating = true, tag = tags[1][5], switchtotag = true }
  }
}
-- }}}
-- {{{ Run Applications
-- Start the composite manager.
awful.util.spawn_with_shell("compton -cCGfF -o 0.38 -O 200 -I 200 -r 12 -D2 -m 0.88")
-- }}}
