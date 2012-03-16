require 'gtk2'

window = Gtk::Window.new
window.add_events(Gdk::Event::KEY_PRESS)
window.add(Gtk::Label.new("Press Key!"))

window.signal_connect("destroy") { |w| Gtk.main_quit }

window.signal_connect("key-press-event") do |w, e|
 p "#{e.keyval}, Gdk::Keyval::GDK_#{Gdk::Keyval.to_name(e.keyval)}"
end

window.set_default_size(100, 100).show_all


Gtk.main

