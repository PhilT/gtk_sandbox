require 'gtk2'
require 'gtksourceview2'

window = Gtk::Window.new 'Source View'

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

view = Gtk::SourceView.new
view.set_size_request 300, 100

view.auto_indent = true
view.highlight_current_line = true
view.indent_on_tab = true
view.insert_spaces_instead_of_tabs = true
view.show_line_numbers = true
SMART_HOME_END = {:before => 1, :after => 2, :both => 3}
view.smart_home_end = SMART_HOME_END[:before]
view.tab_width = 2
view.buffer.language = Gtk::SourceLanguageManager.new.get_language 'rubyonrails'
view.modify_font(Pango::FontDescription.new("monospace 9"))
scheme = Gtk::SourceStyleSchemeManager.new.prepend_search_path('/home/phil/.gnome2/gedit/styles').get_scheme('railscasts')
view.buffer.style_scheme = scheme

scrollbars = Gtk::ScrolledWindow.new
scrollbars.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
scrollbars.add(view)
window.add(scrollbars)
window.show_all

Gtk.main

