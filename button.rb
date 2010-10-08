require 'gtk2'

window = Gtk::Window.new 'Button'
window.border_width = 10
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

button = Gtk::Button.new "_Click Me!\nI'm cool!", true
button.signal_connect('clicked') {puts 'button clicked'}
window.add(button)

window.show_all
Gtk.main

