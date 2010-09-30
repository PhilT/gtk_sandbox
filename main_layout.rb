#TODO: Change all files to set title in new method

require 'gtk2'
require 'gtksourceview2'

window = Gtk::Window.new 'Main Layout'
window.maximize
window.signal_connect("destroy") {|w| Gtk.main_quit}

box = Gtk::VBox.new
window.add(box)

info = Gtk::HBox.new
info.height_request = 20
info.pack_start(Gtk::Label.new('some_path/with/some/file_at_the_end.txt'), true, true)
box.pack_start(info, false, false)

doc = Gtk::SourceView.new
box.pack_start(doc, false, true)

panel = Gtk::VBox.new
box.pack_end(panel, false, true)

title = Gtk::Label.new("NEW")
field = Gtk::Entry.new
hbox = Gtk::HBox.new
hbox.pack_start(title, false, false)
hbox.pack_start(field, true, true)
panel.pack_end(hbox, false, false)

filelist = Gtk::TreeView.new
panel.pack_start(filelist, true, true)

window.show_all
Gtk.main

