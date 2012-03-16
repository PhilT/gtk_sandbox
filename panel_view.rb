# Press CTRL+F to display a text box at the bottom of the window.
# Press ESC to hide it again

require 'gtk2'

window = Gtk::Window.new 'Panel View'
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end
window.set_default_size(300, 100)

box = Gtk::VBox.new
frame1 = Gtk::Frame.new
frame2 = Gtk::Frame.new
frame1.shadow_type = Gtk::SHADOW_IN
frame2.shadow_type = Gtk::SHADOW_IN

box.pack_start(frame1, true, true)
box.pack_end(frame2, false, false)
window.add(box)

view = Gtk::TextView.new
frame1.add(view)

field = Gtk::Entry.new
frame2.add(field)

window.show_all
frame2.hide

window.signal_connect("key_press_event") do |w,e|
  keymap = Gdk::Keymap.default
  keyval = keymap.lookup_key(e.hardware_keycode, 0, 0)
  shortcut = build_shortcut(Gdk::Keyval.to_name(keyval), e.state)
  puts shortcut
  if shortcut == "CTRL+F"
    frame2.show
    field.grab_focus
  elsif shortcut == "ESCAPE"
    frame2.hide
    view.grab_focus
  end
end

def build_shortcut(key, state)
  keys = []
  keys << "CTRL" if state.control_mask?
  keys << "ALT" if state.mod1_mask?
  keys << "SHIFT" if state.shift_mask?
  keys << key.upcase
  keys.join('+')
end

Gtk.main

