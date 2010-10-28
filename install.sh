# These libraries should be installed:
#   glib, gdkpixbuf, pango, atk, gtk, gtksourceview2

# These should be ignored:
#   gstreamer, gnomeprint, gnomecanvas, gtkglext, goocanvas, gtksourceview, poppler, bonobo, vte, gnomeprintui, gnome, libglade, libart, gtkmozembed, panel-applet, rsvg, gnomevfs, gconf, gtkhtml2, bonoboui

# Some errors will occur due to missing libraries but they are not required

set VERSION=0.90.4

sudo apt-get install libglib2.0-dev libatk1.0-dev libpango1.0-dev libgtk2.0-dev libgtksourceview2.0-dev
gem install pkg-config
wget http://downloads.sourceforge.net/ruby-gnome2/ruby-gnome2-all-$VERSION.tar.gz

tar xf ruby-gnome2-all-$VERSION.tar.gz
cd ruby-gnome2-all-$VERSION
ruby extconf.rb
sudo make
sudo make install

#gem install rspec-rails --pre

