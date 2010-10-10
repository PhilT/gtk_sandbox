# Inserts and applies tags to text. Makes the marks visible to demonstrate the effect

require 'gtk2'

view = Gtk::TextView.new
view.set_size_request 300, 100

buffer = view.buffer
buffer.create_tag('snippet', {:background => '#bbbbbb'})
start_iter = buffer.get_iter_at_mark(buffer.selection_bound)
start_mark = buffer.create_mark(nil, start_iter, true)
start_mark.visible = true
buffer.insert_at_cursor("def method\n")
buffer.insert_at_cursor("  ")
iter = buffer.get_iter_at_mark(buffer.selection_bound)
insertion_mark = buffer.create_mark(nil, iter, true)
buffer.insert_at_cursor("\nend")

end_iter = buffer.get_iter_at_mark(buffer.selection_bound)
end_mark = buffer.create_mark(nil, end_iter, true)
end_mark.visible = true
buffer.apply_tag('snippet', buffer.get_iter_at_mark(start_mark), end_iter)
buffer.place_cursor(buffer.get_iter_at_mark(insertion_mark))

window = Gtk::Window.new
window.add(view)
window.title = "Text Tags"

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

window.show_all

Gtk.main

