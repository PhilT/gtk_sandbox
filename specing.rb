# Ensure GUI events can be speced
# Also, sets Gtk::Widget.name for later retreival from event handlers as well as tests
#

require 'gtk2'
require 'minitest/autorun'

# Build the GUI
window = Gtk::Window.new 'Specing'

#Useful when adding Gtk.main to a failing spec - allows the app to be exited cleanly
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end
panel = Gtk::VBox.new
panel.name = 'open'

entry = Gtk::Entry.new
entry.name = 'search'
entry.signal_connect('key_press_event') do |w, e|
  key = Gdk::Keyval.to_name(e.keyval)
  if key == 'Return'
    entry.text = ''
    true
  else
    false
  end
end

panel.add(entry)
window.add(panel)

# Setup the key press handler
window.signal_connect("key_press_event") do |w, e|
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

# Show the GUI but hide the initial panel to be tested
def process_events
  while Gtk.events_pending?
    Gtk.main_iteration
  end
end

window.show_all
panel.hide
process_events

# Webrat style interaction testing
def press key, options = {}
  key = 'Return' if key == 'ENTER'
  widget = options[:in] || Gtk::Window.toplevels.first
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.window = widget
  event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
  event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
  event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
  event.keyval = Gdk::Keyval.from_name(key.split('+').last)
  widget.grab_focus
  event.send_event = true
  entry = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = entry[0]
  widget.signal_emit('key_press_event', event)
  process_events
end

def fill_in widget, options
  widget.insert_text options[:with], widget.position
  process_events
end

# And finally the spec

def widget_named path
  widget = Gtk::Window.toplevels.first
  path.split('.').each do |name|
    widget = widget.children.select{|child| child.name == name}.first
  end
  widget
rescue
  puts "Cannot find widget: #{path}. Failed on children of #{name}"
end

describe 'Open Panel' do
  it 'opens a file' do
    press 'CTRL+O'
    panel.visible?.must_equal true
    field = widget_named 'open.search'
    fill_in field, :with => 'filename'
    field.text.must_equal 'filename'
    press 'Return', :in => field
    field.text.must_equal ''
  end
end

