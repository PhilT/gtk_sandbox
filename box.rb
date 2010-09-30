require 'gtk2'
require 'gtksourceview2'

window = Gtk::Window.new "Box"
window.set_default_size(300, 100)
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

# Gtk::Box#pack_start(child, expand, fill, padding)
box = Gtk::VBox.new
window.add(box)

button2 = Gtk::Button.new('Adds padding to the box')
box.pack_start(button2, true, false, 10)

button3 = Gtk::Button.new('Adds neither')
box.pack_start(button3, false, false, 10)

button1 = Gtk::Button.new('Both padding to the widget')
box.pack_start(button1, true, true)

window.show_all

Gtk.main

