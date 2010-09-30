require 'gtk2'

window = Gtk::Window.new 'Toggle Button'
window.border_width = 10
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

button = Gtk::CheckButton.new '_Click Me!', true
button.signal_connect('clicked') {puts "button checked? #{button.active?}"}
#button.set_size_request(100, 20)
window.add(button)

window.show_all
Gtk.main

