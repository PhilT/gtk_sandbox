class Widget
  def initialize(gtk)
    @gtk = gtk
  end

  def enabled= enabled
    @gtk.sensitive = enabled
  end

  def enabled?
    @gtk.sensitive?
  end

  def focus
    @gtk.grab_focus
  end

  def minimum_size width, height
    @gtk.set_size_request width, height
  end

  def minimum_width= width
    @gtk.width_request = width
  end

  def minimum_height= height
    @gtk.height_request = height
  end

  def minimum_width
    @gtk.width_request
  end

  def minimum_height
    @gtk.height_request
  end
end

