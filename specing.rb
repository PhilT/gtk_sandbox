require 'gtk2'
require 'rspec'

$window = Gtk::Window.new
$window.title = 'Specing'
$window.set_size_request(300, 200)

$window.signal_connect("delete_event") do
  false
end

$window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

box = Gtk::VBox.new

panel = Gtk::Frame.new
label = Gtk::Label.new "Hello!"
panel.add(label)
$window.add(panel)

$window.signal_connect("key_press_event") do |w, e|
  keys = []
  keys << "CTRL" if e.state.control_mask?
  keys << "ALT" if e.state.mod1_mask?
  keys << "SHIFT" if e.state.shift_mask?
  unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
  keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
  shortcut = keys.join('+')
  if shortcut == "CTRL+O"
    panel.show
  end
end

def press(key)
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
  event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
  event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
  event.keyval = Gdk::Keyval.from_name(key.split('+').last)
  event.hardware_keycode = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first.first
  $window.signal_emit('key_press_event', event)
  while Gtk.events_pending?
    Gtk.main_iteration
  end
end

def fill_in(field, options)

end

$window.show_all
panel.hide

def run
  Gtk.main
end

describe 'Open Panel' do

  it 'opens a file' do
    press 'CTRL+O'
    panel.should be_visible
    fill_in 'main.open.search', :with => 'filename'
  end
end

def run
end

run

