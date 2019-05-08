/*
 * Copyright (c) 2019 Andrew Vojak (https://avojak.com)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: Andrew Vojak <andrew.vojak@gmail.com>
 */

public class Iridium.Widgets.ChannelJoinDialog : Gtk.Dialog {

    public unowned Iridium.MainWindow main_window { get; construct; }

    private Gtk.Spinner spinner;
    private Gtk.Label status_label;

    public ChannelJoinDialog (Iridium.MainWindow main_window) {
        Object (
            deletable: false,
            resizable: false,
            title: "Join a Channel",
            transient_for: main_window,
            main_window: main_window
        );
    }

    construct {
        var body = get_content_area ();

        // Create the header
        var header_grid = new Gtk.Grid ();
		header_grid.margin_start = 30;
		header_grid.margin_end = 30;
		header_grid.margin_bottom = 10;
        header_grid.column_spacing = 10;

        var header_image = new Gtk.Image.from_icon_name ("internet-chat", Gtk.IconSize.DIALOG);

        var header_title = new Gtk.Label ("Join a Server");
        header_title.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
        header_title.halign = Gtk.Align.START;
        header_title.hexpand = true;
        header_title.margin_end = 10;
        header_title.set_line_wrap (true);

        var favorite_image = new Gtk.Image.from_icon_name ("non-starred", Gtk.IconSize.DIALOG);

        header_grid.attach (header_image, 0, 0, 1, 1);
        header_grid.attach (header_title, 1, 0, 1, 1);
        header_grid.attach (favorite_image, 2, 0, 1, 1);

        body.add (header_grid);

        // Create the form
        var form_grid = new Gtk.Grid ();
        form_grid.margin = 30;
        form_grid.row_spacing = 12;
        form_grid.column_spacing = 20;

        var channel_label = new Gtk.Label ("Channel");
        channel_label.halign = Gtk.Align.END;

        var channel_entry = new Gtk.Entry ();
        channel_entry.hexpand = true;
        channel_entry.placeholder_text = "#";

        form_grid.attach (channel_label, 0, 0, 1, 1);
        form_grid.attach (channel_entry, 1, 0, 1, 1);

        body.add (form_grid);

        spinner = new Gtk.Spinner ();
        body.add (spinner);

        status_label = new Gtk.Label ("");
        status_label.get_style_context ().add_class ("h4");
        status_label.halign = Gtk.Align.CENTER;
        status_label.valign = Gtk.Align.CENTER;
        status_label.justify = Gtk.Justification.CENTER;
        status_label.set_line_wrap (true);
        status_label.margin_bottom = 10;
        body.add (status_label);

        // Add action buttons
        var not_now_button = new Gtk.Button.with_label ("Not Now");
        not_now_button.clicked.connect (() => {
            close ();
        });

        var join_button = new Gtk.Button.with_label ("Join");
        join_button.get_style_context ().add_class ("suggested-action");
        join_button.clicked.connect (() => {
            spinner.start ();
            status_label.label = "";
        });

        add_action_widget (not_now_button, 0);
        add_action_widget (join_button, 1);
    }

}