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

--  <description>
--  Gtk.Scale_Button.Gtk_Scale_Button provides a button which pops up a scale
--  widget. This kind of widget is commonly used for volume controls in
--  multimedia applications, and GTK+ provides a
--  Gtk.Volume_Button.Gtk_Volume_Button subclass that is tailored for this use
--  case.
--
--  </description>

pragma Warnings (Off, "*is already use-visible*");
with GNAT.Strings;    use GNAT.Strings;
with Glib;            use Glib;
with Glib.Properties; use Glib.Properties;
with Glib.Types;      use Glib.Types;
with Gtk.Action;      use Gtk.Action;
with Gtk.Activatable; use Gtk.Activatable;
with Gtk.Adjustment;  use Gtk.Adjustment;
with Gtk.Buildable;   use Gtk.Buildable;
with Gtk.Button;      use Gtk.Button;
with Gtk.Enums;       use Gtk.Enums;
with Gtk.Orientable;  use Gtk.Orientable;
with Gtk.Widget;      use Gtk.Widget;

package Gtk.Scale_Button is

   type Gtk_Scale_Button_Record is new Gtk_Button_Record with null record;
   type Gtk_Scale_Button is access all Gtk_Scale_Button_Record'Class;

   ------------------
   -- Constructors --
   ------------------

   procedure Gtk_New
      (Button : out Gtk_Scale_Button;
       Size   : Gtk.Enums.Gtk_Icon_Size;
       Min    : Gdouble;
       Max    : Gdouble;
       Step   : Gdouble;
       Icons  : GNAT.Strings.String_List);
   procedure Initialize
      (Button : not null access Gtk_Scale_Button_Record'Class;
       Size   : Gtk.Enums.Gtk_Icon_Size;
       Min    : Gdouble;
       Max    : Gdouble;
       Step   : Gdouble;
       Icons  : GNAT.Strings.String_List);
   --  Creates a Gtk.Scale_Button.Gtk_Scale_Button, with a range between Min
   --  and Max, with a stepping of Step.
   --  Since: gtk+ 2.12
   --  "size": a stock icon size
   --  "min": the minimum value of the scale (usually 0)
   --  "max": the maximum value of the scale (usually 100)
   --  "step": the stepping of value when a scroll-wheel event, or up/down
   --  arrow event occurs (usually 2)
   --  "icons": a null-terminated array of icon names, or null if you want to
   --  set the list later with Gtk.Scale_Button.Set_Icons

   function Get_Type return Glib.GType;
   pragma Import (C, Get_Type, "gtk_scale_button_get_type");

   -------------
   -- Methods --
   -------------

   function Get_Adjustment
      (Button : not null access Gtk_Scale_Button_Record)
       return Gtk.Adjustment.Gtk_Adjustment;
   --  Gets the Gtk.Adjustment.Gtk_Adjustment associated with the
   --  Gtk.Scale_Button.Gtk_Scale_Button's scale. See Gtk.GRange.Get_Adjustment
   --  for details.
   --  Since: gtk+ 2.12

   procedure Set_Adjustment
      (Button     : not null access Gtk_Scale_Button_Record;
       Adjustment : not null access Gtk.Adjustment.Gtk_Adjustment_Record'Class)
      ;
   --  Sets the Gtk.Adjustment.Gtk_Adjustment to be used as a model for the
   --  Gtk.Scale_Button.Gtk_Scale_Button's scale. See Gtk.GRange.Set_Adjustment
   --  for details.
   --  Since: gtk+ 2.12
   --  "adjustment": a Gtk.Adjustment.Gtk_Adjustment

   function Get_Minus_Button
      (Button : not null access Gtk_Scale_Button_Record)
       return Gtk.Widget.Gtk_Widget;
   --  Retrieves the minus button of the Gtk.Scale_Button.Gtk_Scale_Button.
   --  Since: gtk+ 2.14

   function Get_Plus_Button
      (Button : not null access Gtk_Scale_Button_Record)
       return Gtk.Widget.Gtk_Widget;
   --  Retrieves the plus button of the Gtk.Scale_Button.Gtk_Scale_Button.
   --  Since: gtk+ 2.14

   function Get_Popup
      (Button : not null access Gtk_Scale_Button_Record)
       return Gtk.Widget.Gtk_Widget;
   --  Retrieves the popup of the Gtk.Scale_Button.Gtk_Scale_Button.
   --  Since: gtk+ 2.14

   function Get_Value
      (Button : not null access Gtk_Scale_Button_Record) return Gdouble;
   --  Gets the current value of the scale button.
   --  Since: gtk+ 2.12

   procedure Set_Value
      (Button : not null access Gtk_Scale_Button_Record;
       Value  : Gdouble);
   --  Sets the current value of the scale; if the value is outside the
   --  minimum or maximum range values, it will be clamped to fit inside them.
   --  The scale button emits the
   --  Gtk.Scale_Button.Gtk_Scale_Button::value-changed signal if the value
   --  changes.
   --  Since: gtk+ 2.12
   --  "value": new value of the scale button

   procedure Set_Icons
      (Button : not null access Gtk_Scale_Button_Record;
       Icons  : GNAT.Strings.String_List);
   --  Sets the icons to be used by the scale button. For details, see the
   --  Gtk.Scale_Button.Gtk_Scale_Button:icons property.
   --  Since: gtk+ 2.12
   --  "icons": a null-terminated array of icon names

   ---------------------------------------------
   -- Inherited subprograms (from interfaces) --
   ---------------------------------------------
   --  Methods inherited from the Buildable interface are not duplicated here
   --  since they are meant to be used by tools, mostly. If you need to call
   --  them, use an explicit cast through the "-" operator below.

   procedure Do_Set_Related_Action
      (Self   : not null access Gtk_Scale_Button_Record;
       Action : not null access Gtk.Action.Gtk_Action_Record'Class);

   function Get_Related_Action
      (Self : not null access Gtk_Scale_Button_Record)
       return Gtk.Action.Gtk_Action;

   procedure Set_Related_Action
      (Self   : not null access Gtk_Scale_Button_Record;
       Action : not null access Gtk.Action.Gtk_Action_Record'Class);

   function Get_Use_Action_Appearance
      (Self : not null access Gtk_Scale_Button_Record) return Boolean;

   procedure Set_Use_Action_Appearance
      (Self           : not null access Gtk_Scale_Button_Record;
       Use_Appearance : Boolean);

   procedure Sync_Action_Properties
      (Self   : not null access Gtk_Scale_Button_Record;
       Action : access Gtk.Action.Gtk_Action_Record'Class);

   function Get_Orientation
      (Self : not null access Gtk_Scale_Button_Record)
       return Gtk.Enums.Gtk_Orientation;

   procedure Set_Orientation
      (Self        : not null access Gtk_Scale_Button_Record;
       Orientation : Gtk.Enums.Gtk_Orientation);

   ----------------
   -- Interfaces --
   ----------------
   --  This class implements several interfaces. See Glib.Types
   --
   --  - "Activatable"
   --
   --  - "Buildable"
   --
   --  - "Orientable"

   package Implements_Gtk_Activatable is new Glib.Types.Implements
     (Gtk.Activatable.Gtk_Activatable, Gtk_Scale_Button_Record, Gtk_Scale_Button);
   function "+"
     (Widget : access Gtk_Scale_Button_Record'Class)
   return Gtk.Activatable.Gtk_Activatable
   renames Implements_Gtk_Activatable.To_Interface;
   function "-"
     (Interf : Gtk.Activatable.Gtk_Activatable)
   return Gtk_Scale_Button
   renames Implements_Gtk_Activatable.To_Object;

   package Implements_Gtk_Buildable is new Glib.Types.Implements
     (Gtk.Buildable.Gtk_Buildable, Gtk_Scale_Button_Record, Gtk_Scale_Button);
   function "+"
     (Widget : access Gtk_Scale_Button_Record'Class)
   return Gtk.Buildable.Gtk_Buildable
   renames Implements_Gtk_Buildable.To_Interface;
   function "-"
     (Interf : Gtk.Buildable.Gtk_Buildable)
   return Gtk_Scale_Button
   renames Implements_Gtk_Buildable.To_Object;

   package Implements_Gtk_Orientable is new Glib.Types.Implements
     (Gtk.Orientable.Gtk_Orientable, Gtk_Scale_Button_Record, Gtk_Scale_Button);
   function "+"
     (Widget : access Gtk_Scale_Button_Record'Class)
   return Gtk.Orientable.Gtk_Orientable
   renames Implements_Gtk_Orientable.To_Interface;
   function "-"
     (Interf : Gtk.Orientable.Gtk_Orientable)
   return Gtk_Scale_Button
   renames Implements_Gtk_Orientable.To_Object;

   ----------------
   -- Properties --
   ----------------
   --  The following properties are defined for this widget. See
   --  Glib.Properties for more information on properties)
   --
   --  Name: Adjustment_Property
   --  Type: Gtk.Adjustment.Gtk_Adjustment
   --  Flags: read-write
   --
   --  Name: Size_Property
   --  Type: Gtk.Enums.Gtk_Icon_Size
   --  Flags: read-write
   --
   --  Name: Value_Property
   --  Type: Gdouble
   --  Flags: read-write

   Adjustment_Property : constant Glib.Properties.Property_Object;
   Size_Property : constant Gtk.Enums.Property_Gtk_Icon_Size;
   Value_Property : constant Glib.Properties.Property_Double;

   -------------
   -- Signals --
   -------------
   --  The following new signals are defined for this widget:
   --
   --  "popdown"
   --     procedure Handler (Self : access Gtk_Scale_Button_Record'Class);
   --  The ::popdown signal is a <link linkend="keybinding-signals">keybinding
   --  signal</link> which gets emitted to popdown the scale widget.
   --
   --  The default binding for this signal is Escape.
   --
   --  "popup"
   --     procedure Handler (Self : access Gtk_Scale_Button_Record'Class);
   --  The ::popup signal is a <link linkend="keybinding-signals">keybinding
   --  signal</link> which gets emitted to popup the scale widget.
   --
   --  The default bindings for this signal are Space, Enter and Return.
   --
   --  "value-changed"
   --     procedure Handler
   --       (Self  : access Gtk_Scale_Button_Record'Class;
   --        Value : Gdouble);
   --    --  "value": the new value
   --  The ::value-changed signal is emitted when the value field has changed.

   Signal_Popdown : constant Glib.Signal_Name := "popdown";
   Signal_Popup : constant Glib.Signal_Name := "popup";
   Signal_Value_Changed : constant Glib.Signal_Name := "value-changed";

private
   Adjustment_Property : constant Glib.Properties.Property_Object :=
     Glib.Properties.Build ("adjustment");
   Size_Property : constant Gtk.Enums.Property_Gtk_Icon_Size :=
     Gtk.Enums.Build ("size");
   Value_Property : constant Glib.Properties.Property_Double :=
     Glib.Properties.Build ("value");
end Gtk.Scale_Button;