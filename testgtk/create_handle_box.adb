with Glib; use Glib;
with Gtk.Button; use Gtk.Button;
with Gtk.Container; use Gtk.Container;
with Gtk.Enums; use Gtk.Enums;
with Gtk.Handle_Box; use Gtk.Handle_Box;
with Gtk.Hbox; use Gtk.Hbox;
with Gtk.Hseparator; use Gtk.Hseparator;
with Gtk.Label; use Gtk.Label;
with Gtk.Signal; use Gtk.Signal;
with Gtk.Toolbar; use Gtk.Toolbar;
with Gtk.Vbox; use Gtk.Vbox;
with Gtk.Widget; use Gtk.Widget;
with Gtk.Window; use Gtk.Window;
with Gtk; use Gtk;

with Ada.Text_IO;
with Create_Toolbar;

package body Create_Handle_Box is

   package Widget_Cb is new Signal.Object_Callback (Gtk_Widget);
   package Handle_Cb is new Signal.Two_Callback (Gtk_Handle_Box,
                                                 String,
                                                 Gtk_Widget);
   Window : Gtk_Window;


   procedure Child_Signal (Handle : in out Gtk_Handle_Box'Class;
                           Child  : in out Gtk_Widget;
                           Data   : in out String) is
   begin
      Ada.Text_IO.Put_Line (Type_Name (Handle)
                            & ": child <"
                            & Type_Name (Child)
                            & "> "
                            & Data);
   end Child_Signal;


   procedure Run (Widget : in out Gtk.Button.Gtk_Button'Class) is
      Id        : Guint;
      Vbox      : Gtk_Vbox;
      Hbox      : Gtk_Hbox;
      Label     : Gtk_Label;
      Separator : Gtk_Hseparator;
      Handle    : Gtk_Handle_Box;
      Handle2   : Gtk_Handle_Box;
      Toolbar   : Gtk_Toolbar;
   begin
      if not Is_Created (Window) then
         Gtk_New (Window, Window_Toplevel);
         Set_Title (Window, "Handle Box Test");
         Set_Policy (Window, Allow_Shrink => True,
                     Allow_Grow => True, Auto_Shrink => False);
         Id := Widget_Cb.Connect (Window, "destroy", Destroy'Access, Window);
         Border_Width (Window, 20);

         Gtk_New (Vbox, False, 0);
         Add (Window, Vbox);
         Show (Vbox);

         Gtk_New (Label, "Above");
         Add (Vbox, Label);
         Show (Label);

         Gtk_New (Separator);
         Add (Vbox, Separator);
         Show (Separator);

         Gtk_New (Hbox, False, 10);
         Add (Vbox, Hbox);
         Show (Hbox);

         Gtk_New (Separator);
         Add (Vbox, Separator);
         Show (Separator);

         Gtk_New (Label, "Below");
         Add (Vbox, Label);
         Show (Label);

         Gtk_New (Handle);
         Add (Hbox, Handle);
         Id := Handle_Cb.Connect (Handle, "child_attached",
                                  Child_Signal'Access, "attached");
         Id := Handle_Cb.Connect (Handle, "child_detached",
                                  Child_Signal'Access, "detached");
         Show (Handle);

         Create_Toolbar.Make_Toolbar (Toolbar, Window);
         Add (Handle, Toolbar);
         Show (Toolbar);

         Gtk_New (Handle);
         Add (Hbox, Handle);
         Id := Handle_Cb.Connect (Handle, "child_attached",
                                  Child_Signal'Access, "attached");
         Id := Handle_Cb.Connect (Handle, "child_detached",
                                  Child_Signal'Access, "detached");
         Show (Handle);

         Gtk_New (Handle2);
         Add (Handle, Handle2);
         Id := Handle_Cb.Connect (Handle2, "child_attached",
                                  Child_Signal'Access, "attached");
         Id := Handle_Cb.Connect (Handle2, "child_detached",
                                  Child_Signal'Access, "detached");
         Show (Handle2);

         Gtk_New (Label, "Fooo!");
         Add (Handle2, Label);
         Show (Label);
      end if;

      if Visible_Is_Set (Window) then
         Gtk.Widget.Destroy (Window);
      else
         Show (Window);
      end if;
   end Run;

end Create_Handle_Box;
