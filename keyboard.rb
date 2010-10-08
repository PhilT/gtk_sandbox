require 'gtk2'
require 'gtksourceview2'

window = Gtk::Window.new "Keyboard"
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

keys = [
  %w(ESC F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12),
  %w(` 1 2 3 4 5 6 7 8 9 0 - = BACK),
  %w(TAB Q W E R T Y U I O P [ ] ENT),
  %w(CAPS A S D F G H J K L ; ' # ER),
  %w(SHIFT \\ Z X C V B N M , . / SHIFT),
  %w(CTRL WIN ALT SPACE ALT FN CTRL)
]

rows = Gtk::VBox.new
keys.each do |row|
  hbox = Gtk::HBox.new
  rows.pack_start(hbox, false, false, 1)
  row.each do |key|
    button = Gtk::Button.new
    label = Gtk::Label.new
    label.markup = "#{key}\n"
    button.add(label)
    button.width_request = key.length * 10 + 40
    button.width_request = 300 if key == 'SPACE'
    hbox.pack_start(button, true, true, 1)
  end
end
window.add(rows)

window.show_all

Gtk.main

