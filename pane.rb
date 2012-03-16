require 'gtk2'
window = Gtk::Window.new 'Draggable pane'
window.signal_connect("destroy") { |w| Gtk.main_quit }

window.set_default_size(300, 200)

pane = Gtk::VPaned.new
frame1 = Gtk::Frame.new
frame2 = Gtk::Frame.new
frame1.shadow_type = Gtk::SHADOW_IN
frame2.shadow_type = Gtk::SHADOW_IN

pane.pack1(frame1, true, false)
pane.pack2(frame2, false, false)
frame1.set_size_request(-1, 100) # minimum width, height of widget

window.add(pane)

view = Gtk::TextView.new
frame1.add(view)

field = Gtk::Entry.new
frame2.add(field)

window.show_all
Gtk.main

