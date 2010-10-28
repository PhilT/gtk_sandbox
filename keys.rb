require 'gtk2'

window = Gtk::Window.new 'Keys'

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

window.signal_connect("key_press_event") do |w, e|
  puts 'pressing ' + handle_key_event(e)
  false
end

window.signal_connect('key_release_event') do |w, e|
  puts 'releasing ' + handle_key_event(e)
  false
end

def handle_key_event e
  unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
  shortcut = Gdk::Keyval.to_name(unmodified_keyval)
  shortcut.gsub!(/(_L|_R)$/, '')

  if !%w(CTRL ALT SHIFT).include? shortcut
    keys = []
    keys << "CTRL" if e.state.control_mask?
    keys << "ALT" if e.state.mod1_mask?
    keys << "SHIFT" if e.state.shift_mask?
    keys << shortcut
    shortcut = keys.join('+')
  end
  shortcut
end

def press key, window
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
  event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
  event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
  event.keyval = Gdk::Keyval.from_name(key.split('+').last)
  event.hardware_keycode = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first.first
  window.signal_emit('key_press_event', event)
end

box = Gtk::VBox.new
window.add(box)

button = Gtk::Button.new('Emit Key Press (or press a key)')
button.signal_connect('button_press_event') do
  press 'CTRL+S', window
  false
end
box.add(button)

entry = Gtk::Entry.new
box.add(entry)

window.show_all
Gtk.main

