require 'gtk2'

window = Gtk::Window.new "Place one widget over another"
window.set_default_size(400, 200)
window.signal_connect("destroy") { |w| Gtk.main_quit }

fixed = Gtk::Fixed.new
window.add(fixed)

editor = Gtk::TextView.new
editor.set_size_request 400, 200

label = Gtk::Label.new('~/project/lib/module/filename.rb')
label.modify_font Pango::FontDescription.new('Sans 10')
label.set_size_request 299, 20
label.xalign = 1
box = Gtk::EventBox.new
box.add label

fixed.put(box, 100, 180)
fixed.put(editor, 0, 0)

editor.signal_connect "expose-event" do |w|
  label.window.raise
  false
end

window.show_all
Gtk.main

