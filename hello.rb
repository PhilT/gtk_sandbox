require 'gtk2'

window = Gtk::Window.new
window.title = 'Hello!'
window.border_width = 10

window.signal_connect("delete_event") do
  false
end

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

field = Gtk::Entry.new
field.text = 'Hello World'
window.add(field)

window.show_all
Gtk.main

