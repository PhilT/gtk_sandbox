require 'gtk2'
require 'gtksourceview2'

view = Gtk::SourceView.new
view.set_size_request 300, 100

buffer = view.buffer
buffer.create_tag('snippet', {:background => '#555555'})
mark = buffer.selection_bound
i = buffer.get_iter_at_mark(mark)
buffer.insert_at_cursor("def method\n  \nend")
buffer.apply_tag('snippet', i, i )

window = Gtk::Window.new
window.add(view)
window.title = "Text Tags"

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

window.show_all

Gtk.main

