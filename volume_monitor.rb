require 'gtk2'
require 'gio2'

 vm = Gio::VolumeMonitor.get
 vm.signal_connect('drive-changed') do |_, drive|
   puts "Drive changed: #{drive.name}"
   puts "Device: #{drive.get_identifier('unix-device')}"
 end

 vm.signal_connect('drive-connected') do |_, drive|
   puts "Drive connected: #{drive.name}"
   puts "Device: #{drive.get_identifier('unix-device')}"
 end

 vm.signal_connect('volume-changed') do |_, vol|
   puts "Volume added: #{vol.name}"
   puts "Device: #{vol.get_identifier('unix-device')}"
 end

 vm.signal_connect('volume-added') do |_, vol|
   puts "Volume added: #{vol.name}"
   puts "Device: #{vol.get_identifier('unix-device')}"
 end

 vm.signal_connect('mount-added') do |_, mount|
   puts "Mount added: #{mount.name}"
 end

 Gtk.main
