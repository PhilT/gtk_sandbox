# Ensure GUI events can be speced
# Also, sets Gtk::Widget.name for later retreival from event handlers as well as tests
#

require 'gtk2'
require 'rspec'

# Build the GUI
window = Gtk::Window.new
window.title = 'Specing'

panel = Gtk::Frame.new
panel.name = 'open'

entry = Gtk::Entry.new
entry.name = 'search'
entry.signal_connect('activate') do
  entry.text = ''
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
window.show_all
panel.hide

# Webrat style interaction testing

def press key, options = {}
  key = 'Return' if key == 'ENTER'
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
  event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
  event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
  event.keyval = Gdk::Keyval.from_name(key.split('+').last)
  event.hardware_keycode = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first.first
  widget = options[:in] || Gtk::Window.toplevels.first
  widget.signal_emit('key_press_event', event)
  process_events
end

def fill_in widget, options
  widget.insert_text options[:with], widget.position
  process_events
end

def process_events
  while Gtk.events_pending?
    Gtk.main_iteration
  end
end

# And finally the spec

def widget options
  widget = Gtk::Window.toplevels.first
  options[:named].split('.').each do |name|
    widget = widget.children.select{|child| child.name == name}.first
  end
  widget
rescue
  puts "Cannot find widget: #{options[:named]}. Failed on children of #{name}"
end

describe 'Open Panel' do
  it 'opens a file' do
    press 'CTRL+O'
    panel.should be_visible
    field = widget(:named => 'open.search')
    fill_in field, :with => 'filename'
    field.text.should == 'filename'
    press 'ENTER', :in => field
    field.text.should == ''
  end
end

