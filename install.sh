# These libraries should be installed:
#   glib, gdkpixbuf, pango, atk, gtk, gtksourceview2

# These should be ignored:
#   gstreamer, gnomeprint, gnomecanvas, gtkglext, goocanvas, gtksourceview, poppler, bonobo, vte, gnomeprintui, gnome, libglade, libart, gtkmozembed, panel-applet, rsvg, gnomevfs, gconf, gtkhtml2, bonoboui

# Some errors will occur due to missing libraries but they are not required

sudo apt-get install libglib2.0-dev libatk1.0-dev libpango1.0-dev libgtk2.0-dev libgtksourceview2.0-dev
gem install pkg-config
wget http://sourceforge.net/projects/ruby-gnome2/files/ruby-gnome2/ruby-gnome2-0.90.2/ruby-gnome2-all-0.90.2.tar.gz

tar xf ruby-gnome2-all-0.90.2.tar.gz
cd ruby-gnome2-all-0.90.2
ruby extconf.rb
sudo make
sudo make install

#gem install rspec-rails --pre

