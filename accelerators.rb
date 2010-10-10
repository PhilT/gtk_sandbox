# I was currious as to whether menus were required for accelerators and what the whole point of accelerator groups were so knocked up this test app

require 'gtk2'

window = Gtk::Window.new "Accelerators"
window.set_default_size(300, 200)
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

Gtk::AccelMap.add_entry('<bla>/bla', Gdk::Keyval::GDK_O, Gdk::Window::CONTROL_MASK)
Gtk::AccelMap.add_entry('<bla>/cut', Gdk::Keyval::GDK_X, Gdk::Window::CONTROL_MASK)
ag = Gtk::AccelGroup.new
ag.connect('<bla>/bla') { puts "CTRL+O was pressed!"}
ag.connect('<bla>/cut') { puts "CTRL+X was pressed!"}
window.add_accel_group(ag)

window.show_all
Gtk.main

