# Use cursor keys to move up and down the list from within the entry field

require 'gtk2'

window = Gtk::Window.new
box = Gtk::VBox.new
entry = Gtk::Entry.new

listview = Gtk::TreeView.new
listview.headers_visible = false
listview.append_column(Gtk::TreeViewColumn.new('Name', Gtk::CellRendererText.new, "text" => 0))
list = %w(magic makes the world go round)
store = Gtk::ListStore.new(String)
list.each do |item|
  iter = store.append
  store.set_value(iter, 0, item)
end
listview.model = store

box.add(entry)
box.add(listview)
window.add(box)

entry.signal_connect('key_press_event') do |w, e|
  key = Gdk::Keyval.to_name(e.keyval)
  if key == 'Down' || key == 'Up'
    press listview, key
    entry.grab_focus
    true
  else
    false
  end
end

listview.signal_connect('key_press_event') do |w, e|
  false
end

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

def press view, direction
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.keyval = Gdk::Keyval.from_name(direction)
  event.send_event = true
  event.window = view
  entry = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = entry[0]
  view.grab_focus
  view.signal_emit('key_press_event', event)
end

window.show_all
Gtk.main

