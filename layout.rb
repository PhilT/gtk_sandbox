#TODO: Change all files to set title in new method

require 'gtk2'
require 'gtksourceview2'

window = Gtk::Window.new 'Layout'
window.resize 1000, 800
window.signal_connect("destroy") {|w| Gtk.main_quit}
box = Gtk::VBox.new
window.add(box)

info = Gtk::HBox.new
progressbar = Gtk::ProgressBar.new
progressbar.width_request = 150
progressbar.fraction = 0.3
info.pack_start(progressbar, false, true, 4)

path_label = Gtk::Label.new('some_path/with/some/file_at_the_end.txt')
info.pack_start(path_label, false, true, 4)

position_label = Gtk::Label.new('Line 14, Col 12')
position_label.width_request = 150
info.pack_end(position_label, false, false, 4)
box.pack_start(info, false, true, 4)

doc = Gtk::SourceView.new
scrollbars = Gtk::ScrolledWindow.new
scrollbars.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
scrollbars.add(doc)
box.pack_start(scrollbars, true, true)

panel = Gtk::VBox.new
box.pack_start(panel, true, true)

hbox = Gtk::HBox.new
panel.pack_start(hbox, false, true, 4)

title = Gtk::Label.new("New File:")
title.width_request = 100
hbox.pack_start(title, false, true)

field = Gtk::Entry.new
hbox.pack_start(field, true, true, 4)

filelist = Gtk::TreeView.new
panel.pack_start(filelist, true, true)

window.signal_connect("key_press_event") do |w, e|
  keys = []
  keys << "CTRL" if e.state.control_mask?
  keys << "ALT" if e.state.mod1_mask?
  keys << "SHIFT" if e.state.shift_mask?
  unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
  keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
  if keys.join('+') == 'CTRL+F'
    panel.hide
    true
  else
    false
  end
end


window.show_all
Gtk.main

