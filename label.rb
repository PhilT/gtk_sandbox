require 'gtk2'

window = Gtk::Window.new
window.title = 'Label'
window.border_width = 10

window.signal_connect("delete_event") do
  false
end

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

label = Gtk::Label.new 'This is a label'
window.add(label)

window.show_all
Gtk.main

