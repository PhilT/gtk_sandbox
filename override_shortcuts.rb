# Tests built-in shortcuts can be overridden by reversing cut and paste (CTRL+X and CTRL+V)
# Also tests to see if Accelerators override key press events (Yes, they do)

require 'gtk2'

window = Gtk::Window.new 'Override Shortcuts and accelerators'

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

view = Gtk::Entry.new
Gtk::AccelMap.add_entry('<app>/undo', Gdk::Keyval::GDK_Z, Gdk::Window::CONTROL_MASK)
ag = Gtk::AccelGroup.new
ag.connect('<app>/undo') { puts "CTRL+Z was pressed, overridding real undo"; true}
window.add_accel_group(ag)

view.signal_connect('key_press_event') do |w, e|
  unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
  key = Gdk::Keyval.to_name(unmodified_keyval).upcase
  if e.state.control_mask? && key == 'X'
    w.paste_clipboard
    puts 'CTRL+X via key_press_event'
    true
  elsif e.state.control_mask? && key == 'V'
    puts 'CTRL+V via key_press_event'
    w.cut_clipboard
    true
  elsif e.state.control_mask? && key == 'Z'
    puts 'This should never happen!'
    true
  else
    false
  end
end

window.add(view)
window.show_all

Gtk.main

