require 'gtk2'
require 'gtksourceview2'

box = Gtk::VBox.new
frame1 = Gtk::Frame.new
frame2 = Gtk::Frame.new
frame1.shadow_type = Gtk::SHADOW_IN
frame2.shadow_type = Gtk::SHADOW_IN

box.pack_start(frame1, true, true)
box.pack_end(frame2, false, false)

window = Gtk::Window.new
window.title = "Box"

window.add(box)

view = Gtk::SourceView.new
frame1.add(view)

field = Gtk::Entry.new
frame2.add(field)

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

window.set_default_size(300, 100)
window.show_all

Gtk.main

