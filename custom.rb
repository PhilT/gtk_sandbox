require 'gtk2'

MIN_HEIGHT = 10

window = Gtk::Window.new "Custom widget - Scrollbar"
window.set_default_size(400, 250)
window.signal_connect("destroy") { |w| Gtk.main_quit }

view = Gtk::TextView.new

scroller = Gtk::ScrolledWindow.new
scroller.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
vscroller = scroller.vscrollbar
vscroller.signal_connect "expose-event" do
  vscroller.set_width_request 5
  context = vscroller.window.create_cairo_context
  adjustment = vscroller.adjustment
  allocation = vscroller.allocation

  height = adjustment.page_size / adjustment.upper * allocation.height
  height = MIN_HEIGHT if height < MIN_HEIGHT
  y = adjustment.value / adjustment.upper * allocation.height
  y = allocation.height - MIN_HEIGHT if (y + height).round > allocation.height

  context.set_source_rgb 0.8, 0.8, 0.8
  context.rectangle allocation.x, allocation.y, allocation.width, allocation.height
  context.fill

  context.set_source_rgb 0.5, 0.5, 0.5
  context.rectangle allocation.x, y, allocation.width, height
  context.fill
  true
end

scroller.add(view)
window.add(scroller)
window.show_all
Gtk.main

