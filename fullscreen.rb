require 'gtk2'

window = Gtk::Window.new 'Fullscreen Test'
window.signal_connect("destroy") { |w| Gtk.main_quit }
window.signal_connect('key_press_event') { |w, e| Gtk.main_quit }
window.fullscreen
window.show_all
Gtk.main
