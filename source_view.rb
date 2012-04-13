require 'gtk2'
require 'gtksourceview2'

window = Gtk::Window.new 'Source View with Markdown highlighting'

window.signal_connect("destroy") { |w| Gtk.main_quit }

view = Gtk::SourceView.new
view.set_size_request 600, 400

view.auto_indent = true
view.highlight_current_line = true
view.indent_on_tab = true
view.insert_spaces_instead_of_tabs = true
view.show_line_numbers = true
SMART_HOME_END = {:before => 1, :after => 2, :both => 3}
view.smart_home_end = SMART_HOME_END[:before]
view.tab_width = 2
view.buffer.language = Gtk::SourceLanguageManager.new.get_language 'markdown'
view.modify_font(Pango::FontDescription.new("monospace 10"))
scheme = Gtk::SourceStyleSchemeManager.new.get_scheme('twilight')
view.buffer.style_scheme = scheme

scrollbars = Gtk::ScrolledWindow.new
scrollbars.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
scrollbars.add(view)
window.add(scrollbars)
window.show_all

Gtk.main

