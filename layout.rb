#TODO: Change all files to set title in new method

require 'gtk2'
require 'gtksourceview2'
require 'yaml'

def widget_named path
  widget = Gtk::Window.toplevels.first
  path.split('.').each do |name|
    widget = widget.children.select{|child| child.name == name}.first
  end
  widget
rescue
  puts "Cannot find widget: #{path}. Failed on children of #{name}"
end

def process_key event
  keys = []
  keys << "CTRL" if event.state.control_mask?
  keys << "ALT" if event.state.mod1_mask?
  keys << "SHIFT" if event.state.shift_mask?
  unmodified_keyval = Gdk::Keymap.default.lookup_key(event.hardware_keycode, 0, 0)
  keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
  if keys.join('+') == 'CTRL+F'
    widget_named('main.file').hide
    true
  else
    false
  end
end

def quit event
  Gtk.main_quit
end

def layout_for hash, name = nil, parent = nil
  widget = nil
  margin = 0
  pack = ''
  hash.each do |key, value|
    if value.is_a?(Hash)
      layout_for value, key, widget
    elsif key == 'type'
      widget = eval "Gtk::#{value}.new"
      widget.name = name
    elsif key == 'name'
      widget.title = value
    elsif key == 'size'
      dimensions = value.split('x')
      widget.set_default_size dimensions[0].to_i, dimensions[1].to_i
    elsif key =~ /_handler$|_event$/
      widget.signal_connect(key.gsub(/_handler$/, '')) {|w, e| eval "#{value} e"}
    elsif key == 'margin'
      margin = value
    elsif key == 'pack'
      pack = value
    elsif key == 'policy'
      policy = value.split(/, ?/)
      widget.set_policy eval(policy[0]), eval(policy[1])
    elsif key == 'width'
      widget.width_request = value.to_i
    else
      raise "Unknown key #{key}"
    end
  end
  if parent.is_a?(Gtk::Bin)
    parent.add widget
  else
    expand = pack.include?('expand') || pack.include?('both')
    fill = pack.include?('fill') || pack.include?('both')
    parent.pack_start widget, expand, fill, margin
  end unless parent.nil?
end

layout_for YAML.load(File.open('layout.yml'))

Gtk::Window.toplevels.first.show_all
Gtk.main

