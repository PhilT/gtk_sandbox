require 'gtk2'

window = Gtk::Window.new
window.title = 'Progress Bar'
window.border_width = 10

window.signal_connect("delete_event") do
  false
end

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

progress = Gtk::ProgressBar.new
window.add(progress)
current_progress = 0
GLib::Timeout.add(500) do
  current_progress += 0.1
  progress.fraction = current_progress
  progress.pulse if current_progress >= 0.9
  true
end

window.show_all
Gtk.main

