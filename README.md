GTK Sandbox
--------------------

Now it's pretty easy to install Ruby Gnome2:

    sudo apt-get -y install ruby1.9.3       # Install Ruby if not already installed
    sudo apt-get -y install libgtk2.0-dev   # Install GTK development package
    sudo gem install gtk2                   # Install gtk

For source_view example additional packages:

    sudo apt-get -y install libgtksourceview2.0-dev
    sudo gem install gtksourceview2


A suite of single file apps that exercise the various aspects of GTK.
Some of the apps do not have a visible close button. Pressing CTRL+Q should exit the app.

* **box**            - Virtically packed frames with Gtk::VBox
* **button**         - Displays a button. Handler for clicking
* **checkbox**       - Checkbox handling
* **filter_list**    - Use a textbox to filter a list
* **forward_events** - Forwards key events to another widget
* **fullscreen**	 - Creates a fullscreen window (any key quits)
* **hello**          - Simple Hello World
* **keyboard**       - Uses layout and buttons to display a keyboard
* **key_constants**  - Logs the Gdk::Keyval when pressing keys
* **keys**           - Keyboard shortcut handling
* **label**          - Displays a simple label
* **layout**         - GTK widgets loaded from YAML. (CTRL+F hides)
* **list_view**      - A Gtk::TreeView used as a list box
* **pane**           - A Gtk::VPaned with the dragable divider
* **panel_view**     - Show/hide a Gtk::Frame with keyboard shortcuts
* **progress**       - Progresses to 100% then indeterminate one
* **source_view**    - With highlighting and theme support
* **specing**        - Shows how GTK can be tested with MiniTest
* **text_tags**      - Snippets with Gtk::TextTag
* **toggle_button**  - Looks like a button but behaves like a checkbox
* **version**        - Displays GTK and Ruby binding version

