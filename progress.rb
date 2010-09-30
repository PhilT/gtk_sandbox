require 'gtk2'

window = Gtk::Window.new 'Progress Bar'
window.border_width = 10

window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

progress = Gtk::ProgressBar.new
window.add(progress)
current_progress = 0
GLib::Timeout.add(100) do
  current_progress += 0.05
  progress.fraction = current_progress if current_progress < 1.0
  progress.pulse if current_progress >= 1.0
  true
end

window.show_all
Gtk.main

