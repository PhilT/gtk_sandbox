require 'gtk2'

window = Gtk::Window.new 'Toggle Button'
window.border_width = 10
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

button = Gtk::ToggleButton.new '_Click Me!', true
button.signal_connect('clicked') {puts 'button clicked'}
button.set_size_request(100, 30)
window.add(button)

window.show_all
Gtk.main

