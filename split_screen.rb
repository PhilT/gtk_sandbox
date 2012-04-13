# Split screen window management with keyboard shortcuts
# Quit with CTRL+Q

def to_shortcut event
  keys = []
  keys << "CTRL" if event.state.control_mask?
  keys << "ALT" if event.state.mod1_mask?
  keys << "SHIFT" if event.state.shift_mask?
  unmodified_keyval = Gdk::Keymap.default.lookup_key(event.hardware_keycode, 0, 0)
  keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
  keys.join('+')
end

require 'gtk2'
window = Gtk::Window.new 'Split Screen test'
window.signal_connect("destroy") { |w| Gtk.main_quit }
window.signal_connect('key_press_event') { |w, e| Gtk.main_quit if to_shortcut(e) == 'CTRL+Q' }
window.fullscreen

vbox = Gtk::VBox.new
window.add vbox
hbox1 = Gtk::HBox.new
hbox2 = Gtk::HBox.new
vbox.pack_start hbox1, true, true
vbox.pack_start hbox2, true, true

def framed_editor
  scrollbars = Gtk::ScrolledWindow.new
  scrollbars.set_policy(Gtk::POLICY_ALWAYS, Gtk::POLICY_ALWAYS)
  scrollbars.add(Gtk::TextView.new)
  scrollbars
end

hbox1.pack_start framed_editor, true, true, 0
hbox1.pack_start framed_editor, true, true, 0
hbox2.pack_start framed_editor, true, true, 0
hbox2.pack_start framed_editor, true, true, 0

window.show_all
Gtk.main

