require 'gtk2'

window = Gtk::Window.new
window.title = 'Hello World!'

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

window.show
Gtk.main

