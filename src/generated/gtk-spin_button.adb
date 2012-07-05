------------------------------------------------------------------------------
--                                                                          --
--      Copyright (C) 1998-2000 E. Briot, J. Brobecker and A. Charlet       --
--                     Copyright (C) 2000-2012, AdaCore                     --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

pragma Style_Checks (Off);
pragma Warnings (Off, "*is already use-visible*");
with Glib.Type_Conversion_Hooks; use Glib.Type_Conversion_Hooks;
with Gtkada.Bindings;            use Gtkada.Bindings;
with Interfaces.C.Strings;       use Interfaces.C.Strings;

package body Gtk.Spin_Button is

   package Type_Conversion_Gtk_Spin_Button is new Glib.Type_Conversion_Hooks.Hook_Registrator
     (Get_Type'Access, Gtk_Spin_Button_Record);
   pragma Unreferenced (Type_Conversion_Gtk_Spin_Button);

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New
      (Spin_Button : out Gtk_Spin_Button;
       Adjustment  : access Gtk.Adjustment.Gtk_Adjustment_Record'Class;
       Climb_Rate  : Gdouble;
       The_Digits  : Guint := 0)
   is
   begin
      Spin_Button := new Gtk_Spin_Button_Record;
      Gtk.Spin_Button.Initialize (Spin_Button, Adjustment, Climb_Rate, The_Digits);
   end Gtk_New;

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New
      (Spin_Button : out Gtk_Spin_Button;
       Min         : Gdouble;
       Max         : Gdouble;
       Step        : Gdouble)
   is
   begin
      Spin_Button := new Gtk_Spin_Button_Record;
      Gtk.Spin_Button.Initialize (Spin_Button, Min, Max, Step);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
      (Spin_Button : not null access Gtk_Spin_Button_Record'Class;
       Adjustment  : access Gtk.Adjustment.Gtk_Adjustment_Record'Class;
       Climb_Rate  : Gdouble;
       The_Digits  : Guint := 0)
   is
      function Internal
         (Adjustment : System.Address;
          Climb_Rate : Gdouble;
          The_Digits : Guint) return System.Address;
      pragma Import (C, Internal, "gtk_spin_button_new");
   begin
      Set_Object (Spin_Button, Internal (Get_Object_Or_Null (GObject (Adjustment)), Climb_Rate, The_Digits));
   end Initialize;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
      (Spin_Button : not null access Gtk_Spin_Button_Record'Class;
       Min         : Gdouble;
       Max         : Gdouble;
       Step        : Gdouble)
   is
      function Internal
         (Min  : Gdouble;
          Max  : Gdouble;
          Step : Gdouble) return System.Address;
      pragma Import (C, Internal, "gtk_spin_button_new_with_range");
   begin
      Set_Object (Spin_Button, Internal (Min, Max, Step));
   end Initialize;

   ---------------
   -- Configure --
   ---------------

   procedure Configure
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Adjustment  : access Gtk.Adjustment.Gtk_Adjustment_Record'Class;
       Climb_Rate  : Gdouble;
       The_Digits  : Guint)
   is
      procedure Internal
         (Spin_Button : System.Address;
          Adjustment  : System.Address;
          Climb_Rate  : Gdouble;
          The_Digits  : Guint);
      pragma Import (C, Internal, "gtk_spin_button_configure");
   begin
      Internal (Get_Object (Spin_Button), Get_Object_Or_Null (GObject (Adjustment)), Climb_Rate, The_Digits);
   end Configure;

   --------------------
   -- Get_Adjustment --
   --------------------

   function Get_Adjustment
      (Spin_Button : not null access Gtk_Spin_Button_Record)
       return Gtk.Adjustment.Gtk_Adjustment
   is
      function Internal (Spin_Button : System.Address) return System.Address;
      pragma Import (C, Internal, "gtk_spin_button_get_adjustment");
      Stub_Gtk_Adjustment : Gtk.Adjustment.Gtk_Adjustment_Record;
   begin
      return Gtk.Adjustment.Gtk_Adjustment (Get_User_Data (Internal (Get_Object (Spin_Button)), Stub_Gtk_Adjustment));
   end Get_Adjustment;

   ----------------
   -- Get_Digits --
   ----------------

   function Get_Digits
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Guint
   is
      function Internal (Spin_Button : System.Address) return Guint;
      pragma Import (C, Internal, "gtk_spin_button_get_digits");
   begin
      return Internal (Get_Object (Spin_Button));
   end Get_Digits;

   --------------------
   -- Get_Increments --
   --------------------

   procedure Get_Increments
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Step        : out Gdouble;
       Page        : out Gdouble)
   is
      procedure Internal
         (Spin_Button : System.Address;
          Step        : out Gdouble;
          Page        : out Gdouble);
      pragma Import (C, Internal, "gtk_spin_button_get_increments");
   begin
      Internal (Get_Object (Spin_Button), Step, Page);
   end Get_Increments;

   -----------------
   -- Get_Numeric --
   -----------------

   function Get_Numeric
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Boolean
   is
      function Internal (Spin_Button : System.Address) return Integer;
      pragma Import (C, Internal, "gtk_spin_button_get_numeric");
   begin
      return Boolean'Val (Internal (Get_Object (Spin_Button)));
   end Get_Numeric;

   ---------------
   -- Get_Range --
   ---------------

   procedure Get_Range
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Min         : out Gdouble;
       Max         : out Gdouble)
   is
      procedure Internal
         (Spin_Button : System.Address;
          Min         : out Gdouble;
          Max         : out Gdouble);
      pragma Import (C, Internal, "gtk_spin_button_get_range");
   begin
      Internal (Get_Object (Spin_Button), Min, Max);
   end Get_Range;

   -----------------------
   -- Get_Snap_To_Ticks --
   -----------------------

   function Get_Snap_To_Ticks
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Boolean
   is
      function Internal (Spin_Button : System.Address) return Integer;
      pragma Import (C, Internal, "gtk_spin_button_get_snap_to_ticks");
   begin
      return Boolean'Val (Internal (Get_Object (Spin_Button)));
   end Get_Snap_To_Ticks;

   -----------------------
   -- Get_Update_Policy --
   -----------------------

   function Get_Update_Policy
      (Spin_Button : not null access Gtk_Spin_Button_Record)
       return Gtk_Spin_Button_Update_Policy
   is
      function Internal
         (Spin_Button : System.Address) return Gtk_Spin_Button_Update_Policy;
      pragma Import (C, Internal, "gtk_spin_button_get_update_policy");
   begin
      return Internal (Get_Object (Spin_Button));
   end Get_Update_Policy;

   ---------------
   -- Get_Value --
   ---------------

   function Get_Value
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Gdouble
   is
      function Internal (Spin_Button : System.Address) return Gdouble;
      pragma Import (C, Internal, "gtk_spin_button_get_value");
   begin
      return Internal (Get_Object (Spin_Button));
   end Get_Value;

   ----------------------
   -- Get_Value_As_Int --
   ----------------------

   function Get_Value_As_Int
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Gint
   is
      function Internal (Spin_Button : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_spin_button_get_value_as_int");
   begin
      return Internal (Get_Object (Spin_Button));
   end Get_Value_As_Int;

   --------------
   -- Get_Wrap --
   --------------

   function Get_Wrap
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Boolean
   is
      function Internal (Spin_Button : System.Address) return Integer;
      pragma Import (C, Internal, "gtk_spin_button_get_wrap");
   begin
      return Boolean'Val (Internal (Get_Object (Spin_Button)));
   end Get_Wrap;

   --------------------
   -- Set_Adjustment --
   --------------------

   procedure Set_Adjustment
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Adjustment  : not null access Gtk.Adjustment.Gtk_Adjustment_Record'Class)
      
   is
      procedure Internal
         (Spin_Button : System.Address;
          Adjustment  : System.Address);
      pragma Import (C, Internal, "gtk_spin_button_set_adjustment");
   begin
      Internal (Get_Object (Spin_Button), Get_Object (Adjustment));
   end Set_Adjustment;

   ----------------
   -- Set_Digits --
   ----------------

   procedure Set_Digits
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       The_Digits  : Guint)
   is
      procedure Internal (Spin_Button : System.Address; The_Digits : Guint);
      pragma Import (C, Internal, "gtk_spin_button_set_digits");
   begin
      Internal (Get_Object (Spin_Button), The_Digits);
   end Set_Digits;

   --------------------
   -- Set_Increments --
   --------------------

   procedure Set_Increments
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Step        : Gdouble;
       Page        : Gdouble)
   is
      procedure Internal
         (Spin_Button : System.Address;
          Step        : Gdouble;
          Page        : Gdouble);
      pragma Import (C, Internal, "gtk_spin_button_set_increments");
   begin
      Internal (Get_Object (Spin_Button), Step, Page);
   end Set_Increments;

   -----------------
   -- Set_Numeric --
   -----------------

   procedure Set_Numeric
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Numeric     : Boolean)
   is
      procedure Internal (Spin_Button : System.Address; Numeric : Integer);
      pragma Import (C, Internal, "gtk_spin_button_set_numeric");
   begin
      Internal (Get_Object (Spin_Button), Boolean'Pos (Numeric));
   end Set_Numeric;

   ---------------
   -- Set_Range --
   ---------------

   procedure Set_Range
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Min         : Gdouble;
       Max         : Gdouble)
   is
      procedure Internal
         (Spin_Button : System.Address;
          Min         : Gdouble;
          Max         : Gdouble);
      pragma Import (C, Internal, "gtk_spin_button_set_range");
   begin
      Internal (Get_Object (Spin_Button), Min, Max);
   end Set_Range;

   -----------------------
   -- Set_Snap_To_Ticks --
   -----------------------

   procedure Set_Snap_To_Ticks
      (Spin_Button   : not null access Gtk_Spin_Button_Record;
       Snap_To_Ticks : Boolean)
   is
      procedure Internal
         (Spin_Button   : System.Address;
          Snap_To_Ticks : Integer);
      pragma Import (C, Internal, "gtk_spin_button_set_snap_to_ticks");
   begin
      Internal (Get_Object (Spin_Button), Boolean'Pos (Snap_To_Ticks));
   end Set_Snap_To_Ticks;

   -----------------------
   -- Set_Update_Policy --
   -----------------------

   procedure Set_Update_Policy
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Policy      : Gtk_Spin_Button_Update_Policy)
   is
      procedure Internal
         (Spin_Button : System.Address;
          Policy      : Gtk_Spin_Button_Update_Policy);
      pragma Import (C, Internal, "gtk_spin_button_set_update_policy");
   begin
      Internal (Get_Object (Spin_Button), Policy);
   end Set_Update_Policy;

   ---------------
   -- Set_Value --
   ---------------

   procedure Set_Value
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Value       : Gdouble)
   is
      procedure Internal (Spin_Button : System.Address; Value : Gdouble);
      pragma Import (C, Internal, "gtk_spin_button_set_value");
   begin
      Internal (Get_Object (Spin_Button), Value);
   end Set_Value;

   --------------
   -- Set_Wrap --
   --------------

   procedure Set_Wrap
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Wrap        : Boolean)
   is
      procedure Internal (Spin_Button : System.Address; Wrap : Integer);
      pragma Import (C, Internal, "gtk_spin_button_set_wrap");
   begin
      Internal (Get_Object (Spin_Button), Boolean'Pos (Wrap));
   end Set_Wrap;

   ----------
   -- Spin --
   ----------

   procedure Spin
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Direction   : Gtk_Spin_Type;
       Increment   : Gdouble)
   is
      procedure Internal
         (Spin_Button : System.Address;
          Direction   : Gtk_Spin_Type;
          Increment   : Gdouble);
      pragma Import (C, Internal, "gtk_spin_button_spin");
   begin
      Internal (Get_Object (Spin_Button), Direction, Increment);
   end Spin;

   ------------
   -- Update --
   ------------

   procedure Update (Spin_Button : not null access Gtk_Spin_Button_Record) is
      procedure Internal (Spin_Button : System.Address);
      pragma Import (C, Internal, "gtk_spin_button_update");
   begin
      Internal (Get_Object (Spin_Button));
   end Update;

   --------------------
   -- Copy_Clipboard --
   --------------------

   procedure Copy_Clipboard
      (Editable : not null access Gtk_Spin_Button_Record)
   is
      procedure Internal (Editable : System.Address);
      pragma Import (C, Internal, "gtk_editable_copy_clipboard");
   begin
      Internal (Get_Object (Editable));
   end Copy_Clipboard;

   -------------------
   -- Cut_Clipboard --
   -------------------

   procedure Cut_Clipboard
      (Editable : not null access Gtk_Spin_Button_Record)
   is
      procedure Internal (Editable : System.Address);
      pragma Import (C, Internal, "gtk_editable_cut_clipboard");
   begin
      Internal (Get_Object (Editable));
   end Cut_Clipboard;

   ----------------------
   -- Delete_Selection --
   ----------------------

   procedure Delete_Selection
      (Editable : not null access Gtk_Spin_Button_Record)
   is
      procedure Internal (Editable : System.Address);
      pragma Import (C, Internal, "gtk_editable_delete_selection");
   begin
      Internal (Get_Object (Editable));
   end Delete_Selection;

   -----------------
   -- Delete_Text --
   -----------------

   procedure Delete_Text
      (Editable  : not null access Gtk_Spin_Button_Record;
       Start_Pos : Gint;
       End_Pos   : Gint := -1)
   is
      procedure Internal
         (Editable  : System.Address;
          Start_Pos : Gint;
          End_Pos   : Gint);
      pragma Import (C, Internal, "gtk_editable_delete_text");
   begin
      Internal (Get_Object (Editable), Start_Pos, End_Pos);
   end Delete_Text;

   ------------------
   -- Editing_Done --
   ------------------

   procedure Editing_Done
      (Cell_Editable : not null access Gtk_Spin_Button_Record)
   is
      procedure Internal (Cell_Editable : System.Address);
      pragma Import (C, Internal, "gtk_cell_editable_editing_done");
   begin
      Internal (Get_Object (Cell_Editable));
   end Editing_Done;

   ---------------
   -- Get_Chars --
   ---------------

   function Get_Chars
      (Editable  : not null access Gtk_Spin_Button_Record;
       Start_Pos : Gint;
       End_Pos   : Gint := -1) return UTF8_String
   is
      function Internal
         (Editable  : System.Address;
          Start_Pos : Gint;
          End_Pos   : Gint) return Interfaces.C.Strings.chars_ptr;
      pragma Import (C, Internal, "gtk_editable_get_chars");
   begin
      return Gtkada.Bindings.Value_And_Free (Internal (Get_Object (Editable), Start_Pos, End_Pos));
   end Get_Chars;

   ------------------
   -- Get_Editable --
   ------------------

   function Get_Editable
      (Editable : not null access Gtk_Spin_Button_Record) return Boolean
   is
      function Internal (Editable : System.Address) return Integer;
      pragma Import (C, Internal, "gtk_editable_get_editable");
   begin
      return Boolean'Val (Internal (Get_Object (Editable)));
   end Get_Editable;

   ------------------
   -- Get_Position --
   ------------------

   function Get_Position
      (Editable : not null access Gtk_Spin_Button_Record) return Gint
   is
      function Internal (Editable : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_editable_get_position");
   begin
      return Internal (Get_Object (Editable));
   end Get_Position;

   --------------------------
   -- Get_Selection_Bounds --
   --------------------------

   procedure Get_Selection_Bounds
      (Editable      : not null access Gtk_Spin_Button_Record;
       Start_Pos     : out Gint;
       End_Pos       : out Gint;
       Has_Selection : out Boolean)
   is
      function Internal
         (Editable      : System.Address;
          Acc_Start_Pos : access Gint;
          Acc_End_Pos   : access Gint) return Integer;
      pragma Import (C, Internal, "gtk_editable_get_selection_bounds");
      Acc_Start_Pos : aliased Gint;
      Acc_End_Pos   : aliased Gint;
      Tmp_Return    : Integer;
   begin
      Tmp_Return := Internal (Get_Object (Editable), Acc_Start_Pos'Access, Acc_End_Pos'Access);
      Start_Pos := Acc_Start_Pos;
      End_Pos := Acc_End_Pos;
      Has_Selection := Boolean'Val (Tmp_Return);
   end Get_Selection_Bounds;

   -----------------
   -- Insert_Text --
   -----------------

   procedure Insert_Text
      (Editable        : not null access Gtk_Spin_Button_Record;
       New_Text        : UTF8_String;
       New_Text_Length : Gint;
       Position        : in out Gint)
   is
      procedure Internal
         (Editable        : System.Address;
          New_Text        : Interfaces.C.Strings.chars_ptr;
          New_Text_Length : Gint;
          Position        : in out Gint);
      pragma Import (C, Internal, "gtk_editable_insert_text");
      Tmp_New_Text : Interfaces.C.Strings.chars_ptr := New_String (New_Text);
   begin
      Internal (Get_Object (Editable), Tmp_New_Text, New_Text_Length, Position);
      Free (Tmp_New_Text);
   end Insert_Text;

   ---------------------
   -- Paste_Clipboard --
   ---------------------

   procedure Paste_Clipboard
      (Editable : not null access Gtk_Spin_Button_Record)
   is
      procedure Internal (Editable : System.Address);
      pragma Import (C, Internal, "gtk_editable_paste_clipboard");
   begin
      Internal (Get_Object (Editable));
   end Paste_Clipboard;

   -------------------
   -- Remove_Widget --
   -------------------

   procedure Remove_Widget
      (Cell_Editable : not null access Gtk_Spin_Button_Record)
   is
      procedure Internal (Cell_Editable : System.Address);
      pragma Import (C, Internal, "gtk_cell_editable_remove_widget");
   begin
      Internal (Get_Object (Cell_Editable));
   end Remove_Widget;

   -------------------
   -- Select_Region --
   -------------------

   procedure Select_Region
      (Editable  : not null access Gtk_Spin_Button_Record;
       Start_Pos : Gint;
       End_Pos   : Gint := -1)
   is
      procedure Internal
         (Editable  : System.Address;
          Start_Pos : Gint;
          End_Pos   : Gint);
      pragma Import (C, Internal, "gtk_editable_select_region");
   begin
      Internal (Get_Object (Editable), Start_Pos, End_Pos);
   end Select_Region;

   ------------------
   -- Set_Editable --
   ------------------

   procedure Set_Editable
      (Editable    : not null access Gtk_Spin_Button_Record;
       Is_Editable : Boolean)
   is
      procedure Internal (Editable : System.Address; Is_Editable : Integer);
      pragma Import (C, Internal, "gtk_editable_set_editable");
   begin
      Internal (Get_Object (Editable), Boolean'Pos (Is_Editable));
   end Set_Editable;

   ------------------
   -- Set_Position --
   ------------------

   procedure Set_Position
      (Editable : not null access Gtk_Spin_Button_Record;
       Position : Gint)
   is
      procedure Internal (Editable : System.Address; Position : Gint);
      pragma Import (C, Internal, "gtk_editable_set_position");
   begin
      Internal (Get_Object (Editable), Position);
   end Set_Position;

   -------------------
   -- Start_Editing --
   -------------------

   procedure Start_Editing
      (Cell_Editable : not null access Gtk_Spin_Button_Record;
       Event         : Gdk.Event.Gdk_Event)
   is
      procedure Internal
         (Cell_Editable : System.Address;
          Event         : Gdk.Event.Gdk_Event);
      pragma Import (C, Internal, "gtk_cell_editable_start_editing");
   begin
      Internal (Get_Object (Cell_Editable), Event);
   end Start_Editing;

end Gtk.Spin_Button;
