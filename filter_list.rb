require 'gtk2'

window = Gtk::Window.new 'Completion'
window.set_default_size(300, 200)
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

panel = Gtk::VBox.new
window.add(panel)

entry = Gtk::Entry.new
panel.pack_start(entry, false, true)

view = Gtk::TreeView.new
view.headers_visible = false
view.append_column(Gtk::TreeViewColumn.new('Name', Gtk::CellRendererText.new, "text" => 0))
full_list = Dir['**/**'].reject{|file|File.directory?(file)}.sort
initial_list = Dir['*'].sort do |a,b|
  if File.directory?(b) && !File.directory?(a)
    1
  elsif File.directory?(a) && !File.directory?(b)
    -1
  else
    a.downcase <=> b.downcase
  end
end.map{|file|File.directory?(file) ? file + '/' : file }
store = Gtk::ListStore.new(String)
initial_list.each do |item|
  iter = store.append
  store.set_value(iter, 0, item)
end
view.model = store
scrollbars = Gtk::ScrolledWindow.new
scrollbars.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
scrollbars.add(view)
panel.add(scrollbars)

entry.signal_connect("key_release_event") do
  if entry.text.length >= 3
    store = Gtk::ListStore.new(String)
    full_list.select{|item| item.match entry.text.gsub(' ', '.*')}.each do |item|
      iter = store.append
      store.set_value(iter, 0, item)
    end
    view.model = store
  end
end

view.selection.mode = Gtk::SELECTION_MULTIPLE
view.signal_connect('key_press_event') do |w, e|
  if Gdk::Keyval.to_name(e.keyval) == 'Return'
    view.selection.selected_each do |model, path, iter|
      puts iter[0]
    end
  end
end


window.show_all
Gtk.main

