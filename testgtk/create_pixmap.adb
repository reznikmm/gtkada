with Glib; use Glib;
with Gdk.Bitmap; use Gdk.Bitmap;
with Gdk.Pixmap; use Gdk.Pixmap;
with Gdk.Window; use Gdk.Window;
with Gtk.Box; use Gtk.Box;
with Gtk.Button; use Gtk.Button;
with Gtk.Container; use Gtk.Container;
with Gtk.Enums; use Gtk.Enums;
with Gtk.Hbox; use Gtk.Hbox;
with Gtk.Hseparator; use Gtk.Hseparator;
with Gtk.Label; use Gtk.Label;
with Gtk.Signal; use Gtk.Signal;
with Gtk.Object; use Gtk.Object;
with Gtk.Pixmap; use Gtk.Pixmap;
with Gtk.Style; use Gtk.Style;
with Gtk.Vbox; use Gtk.Vbox;
with Gtk.Widget; use Gtk.Widget;
with Gtk.Window; use Gtk.Window;
with Gtk; use Gtk;

package body Create_Pixmap is

   package Widget_Cb is new Signal.Object_Callback (Gtk_Widget);

   Window : Gtk.Window.Gtk_Window;

   procedure Run (Widget : in out Gtk.Button.Gtk_Button'Class) is
      Id        : Guint;
      Box1      : Gtk_Vbox;
      Box2      : Gtk_Vbox;
      Box3      : Gtk_Hbox;
      Button    : Gtk_Button;
      Style     : Gtk_Style;
      Pixmap    : Gdk_Pixmap;
      Mask      : Gdk_Bitmap;
      PixmapWid : Gtk_Pixmap;
      Label     : Gtk_Label;
      Separator : Gtk_Hseparator;
   begin
      if not Is_Created (Window) then
         Gtk_New (Window, Window_Toplevel);
         Id := Widget_Cb.Connect (Window, "destroy", Destroy'Access, Window);
         Set_Title (Window, "pixmap");
         Border_Width (Window, Border_Width => 0);
         Realize (Window);

         Gtk_New (Box1, False, 0);
         Add (Window, Box1);
         Show (Box1);

         Gtk_New (Box2, False, 10);
         Border_Width (Box2, 10);
         Pack_Start (Box1, Box2, True, True, 0);
         Show (Box2);

         Gtk_New (Button);
         Pack_Start (Box2, Button, False, False, 0);
         Show (Button);

         Style := Get_Style (Button);
         Create_From_Xpm (Pixmap, Get_Window (Window), Mask,
                          Get_Bg (Style, State_Normal), "test.xpm");
         Gtk_New (PixmapWid, Pixmap, Mask);

         Gtk_New (Label, "Pixmap" & Ascii.LF & "test");
         Gtk_New (Box3, False, 0);
         Border_Width (Box3, 2);
         Add (Box3, PixmapWid);
         Add (Box3, Label);
         Add (Button, Box3);
         Show (PixmapWid);
         Show (Label);
         Show (Box3);

         Gtk_New (Separator);
         Pack_Start (Box3, Separator, False, True, 0);
         Show (Separator);

         Gtk_New (Box2, False, 10);
         Border_Width (Box2, 10);
         Pack_Start (Box1, Box2, False, True, 0);
         Show (Box2);

         Gtk_New (Button, "close");
         Id := Widget_Cb.Connect (Button, "clicked", Destroy'Access, Window);
         Pack_Start (Box2, Button, True, True, 0);
         Set_Flags (Button, Can_Default);
         Grab_Default (Button);
         Show (Button);
      end if;

      if not Gtk.Widget.Visible_Is_Set (Window) then
         Gtk.Widget.Show (Window);
      else
         Gtk.Widget.Destroy (Window);
      end if;

   end Run;

end Create_Pixmap;

