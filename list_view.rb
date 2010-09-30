require 'gtk2'

window = Gtk::Window.new 'ListView with a TreeView'
window.set_default_size(300, 200)

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

view = Gtk::TreeView.new
view.headers_visible = false
view.append_column(Gtk::TreeViewColumn.new('Name', Gtk::CellRendererText.new, "text" => 0))
list = %w(magic makes the world go round)
store = Gtk::ListStore.new(String)
list.each do |item|
  iter = store.append
  store.set_value(iter, 0, item)
end
view.model = store
scrollbars = Gtk::ScrolledWindow.new
scrollbars.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
scrollbars.add(view)
window.add(scrollbars)

window.show_all
Gtk.main

