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
--  A Gtk.Spin_Button.Gtk_Spin_Button is an ideal way to allow the user to set
--  the value of some attribute. Rather than having to directly type a number
--  into a Gtk.GEntry.Gtk_Entry, GtkSpinButton allows the user to click on one
--  of two arrows to increment or decrement the displayed value. A value can
--  still be typed in, with the bonus that it can be checked to ensure it is in
--  a given range.
--
--  The main properties of a GtkSpinButton are through an adjustment. See the
--  Gtk.Adjustment.Gtk_Adjustment section for more details about an
--  adjustment's properties.
--
--  == Using a GtkSpinButton to get an integer ==
--
--    /* Provides a function to retrieve an integer value from a
--    * GtkSpinButton and creates a spin button to model percentage
--    * values.
--    */
--    gint
--    grab_int_value (GtkSpinButton *button,
--       gpointer       user_data)
--    {
--       return gtk_spin_button_get_value_as_int (button);
--    }
--    void
--    create_integer_spin_button (void)
--    {
--       GtkWidget *window, *button;
--       GtkAdjustment *adjustment;
--       adjustment = gtk_adjustment_new (50.0, 0.0, 100.0, 1.0, 5.0, 0.0);
--       window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
--       gtk_container_set_border_width (GTK_CONTAINER (window), 5);
--       /* creates the spinbutton, with no decimal places */
--       button = gtk_spin_button_new (adjustment, 1.0, 0);
--       gtk_container_add (GTK_CONTAINER (window), button);
--       gtk_widget_show_all (window);
--    }
--
--  == Using a GtkSpinButton to get a floating point value ==
--
--    /* Provides a function to retrieve a floating point value from a
--    * GtkSpinButton, and creates a high precision spin button.
--    */
--    gfloat
--    grab_float_value (GtkSpinButton *button,
--       gpointer       user_data)
--    {
--       return gtk_spin_button_get_value (button);
--    }
--    void
--    create_floating_spin_button (void)
--    {
--       GtkWidget *window, *button;
--       GtkAdjustment *adjustment;
--       adjustment = gtk_adjustment_new (2.500, 0.0, 5.0, 0.001, 0.1, 0.0);
--       window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
--       gtk_container_set_border_width (GTK_CONTAINER (window), 5);
--       /* creates the spinbutton, with three decimal places */
--       button = gtk_spin_button_new (adjustment, 0.001, 3);
--       gtk_container_add (GTK_CONTAINER (window), button);
--       gtk_widget_show_all (window);
--    }
--
--
--  </description>

pragma Warnings (Off, "*is already use-visible*");
with Gdk.Event;               use Gdk.Event;
with Glib;                    use Glib;
with Glib.Generic_Properties; use Glib.Generic_Properties;
with Glib.Properties;         use Glib.Properties;
with Glib.Types;              use Glib.Types;
with Gtk.Adjustment;          use Gtk.Adjustment;
with Gtk.Buildable;           use Gtk.Buildable;
with Gtk.Cell_Editable;       use Gtk.Cell_Editable;
with Gtk.Editable;            use Gtk.Editable;
with Gtk.GEntry;              use Gtk.GEntry;

package Gtk.Spin_Button is

   type Gtk_Spin_Button_Record is new Gtk_Entry_Record with null record;
   type Gtk_Spin_Button is access all Gtk_Spin_Button_Record'Class;

   type Gtk_Spin_Type is (
      Spin_Step_Forward,
      Spin_Step_Backward,
      Spin_Page_Forward,
      Spin_Page_Backward,
      Spin_Home,
      Spin_End,
      Spin_User_Defined);
   pragma Convention (C, Gtk_Spin_Type);
   --  The values of the GtkSpinType enumeration are used to specify the
   --  change to make in Gtk.Spin_Button.Spin.

   type Gtk_Spin_Button_Update_Policy is (
      Update_Always,
      Update_If_Valid);
   pragma Convention (C, Gtk_Spin_Button_Update_Policy);
   --  The spin button update policy determines whether the spin button
   --  displays values even if they are outside the bounds of its adjustment.
   --  See Gtk.Spin_Button.Set_Update_Policy.

   ----------------------------
   -- Enumeration Properties --
   ----------------------------

   package Gtk_Spin_Type_Properties is
      new Generic_Internal_Discrete_Property (Gtk_Spin_Type);
   type Property_Gtk_Spin_Type is new Gtk_Spin_Type_Properties.Property;

   package Gtk_Spin_Button_Update_Policy_Properties is
      new Generic_Internal_Discrete_Property (Gtk_Spin_Button_Update_Policy);
   type Property_Gtk_Spin_Button_Update_Policy is new Gtk_Spin_Button_Update_Policy_Properties.Property;

   ------------------
   -- Constructors --
   ------------------

   procedure Gtk_New
      (Spin_Button : out Gtk_Spin_Button;
       Adjustment  : access Gtk.Adjustment.Gtk_Adjustment_Record'Class;
       Climb_Rate  : Gdouble;
       The_Digits  : Guint := 0);
   procedure Initialize
      (Spin_Button : not null access Gtk_Spin_Button_Record'Class;
       Adjustment  : access Gtk.Adjustment.Gtk_Adjustment_Record'Class;
       Climb_Rate  : Gdouble;
       The_Digits  : Guint := 0);
   --  Creates a new Gtk.Spin_Button.Gtk_Spin_Button.
   --  "adjustment": the Gtk.Adjustment.Gtk_Adjustment object that this spin
   --  button should use, or null
   --  "climb_rate": specifies how much the spin button changes when an arrow
   --  is clicked on
   --  "digits": the number of decimal places to display

   procedure Gtk_New
      (Spin_Button : out Gtk_Spin_Button;
       Min         : Gdouble;
       Max         : Gdouble;
       Step        : Gdouble);
   procedure Initialize
      (Spin_Button : not null access Gtk_Spin_Button_Record'Class;
       Min         : Gdouble;
       Max         : Gdouble;
       Step        : Gdouble);
   --  This is a convenience constructor that allows creation of a numeric
   --  Gtk.Spin_Button.Gtk_Spin_Button without manually creating an adjustment.
   --  The value is initially set to the minimum value and a page increment of
   --  10 * Step is the default. The precision of the spin button is equivalent
   --  to the precision of Step.
   --  Note that the way in which the precision is derived works best if Step
   --  is a power of ten. If the resulting precision is not suitable for your
   --  needs, use Gtk.Spin_Button.Set_Digits to correct it.
   --  "min": Minimum allowable value
   --  "max": Maximum allowable value
   --  "step": Increment added or subtracted by spinning the widget

   function Get_Type return Glib.GType;
   pragma Import (C, Get_Type, "gtk_spin_button_get_type");

   -------------
   -- Methods --
   -------------

   procedure Configure
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Adjustment  : access Gtk.Adjustment.Gtk_Adjustment_Record'Class;
       Climb_Rate  : Gdouble;
       The_Digits  : Guint);
   --  Changes the properties of an existing spin button. The adjustment,
   --  climb rate, and number of decimal places are all changed accordingly,
   --  after this function call.
   --  "adjustment": a Gtk.Adjustment.Gtk_Adjustment
   --  "climb_rate": the new climb rate
   --  "digits": the number of decimal places to display in the spin button

   function Get_Adjustment
      (Spin_Button : not null access Gtk_Spin_Button_Record)
       return Gtk.Adjustment.Gtk_Adjustment;
   --  Get the adjustment associated with a Gtk.Spin_Button.Gtk_Spin_Button

   procedure Set_Adjustment
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Adjustment  : not null access Gtk.Adjustment.Gtk_Adjustment_Record'Class)
      ;
   --  Replaces the Gtk.Adjustment.Gtk_Adjustment associated with Spin_Button.
   --  "adjustment": a Gtk.Adjustment.Gtk_Adjustment to replace the existing
   --  adjustment

   function Get_Digits
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Guint;
   --  Fetches the precision of Spin_Button. See Gtk.Spin_Button.Set_Digits.

   procedure Set_Digits
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       The_Digits  : Guint);
   --  Set the precision to be displayed by Spin_Button. Up to 20 digit
   --  precision is allowed.
   --  "digits": the number of digits after the decimal point to be displayed
   --  for the spin button's value

   procedure Get_Increments
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Step        : out Gdouble;
       Page        : out Gdouble);
   --  Gets the current step and page the increments used by Spin_Button. See
   --  Gtk.Spin_Button.Set_Increments.
   --  "step": location to store step increment, or null
   --  "page": location to store page increment, or null

   procedure Set_Increments
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Step        : Gdouble;
       Page        : Gdouble);
   --  Sets the step and page increments for spin_button. This affects how
   --  quickly the value changes when the spin button's arrows are activated.
   --  "step": increment applied for a button 1 press.
   --  "page": increment applied for a button 2 press.

   function Get_Numeric
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Boolean;
   --  Returns whether non-numeric text can be typed into the spin button. See
   --  Gtk.Spin_Button.Set_Numeric.

   procedure Set_Numeric
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Numeric     : Boolean);
   --  Sets the flag that determines if non-numeric text can be typed into the
   --  spin button.
   --  "numeric": flag indicating if only numeric entry is allowed

   procedure Get_Range
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Min         : out Gdouble;
       Max         : out Gdouble);
   --  Gets the range allowed for Spin_Button. See Gtk.Spin_Button.Set_Range.
   --  "min": location to store minimum allowed value, or null
   --  "max": location to store maximum allowed value, or null

   procedure Set_Range
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Min         : Gdouble;
       Max         : Gdouble);
   --  Sets the minimum and maximum allowable values for Spin_Button.
   --  "min": minimum allowable value
   --  "max": maximum allowable value

   function Get_Snap_To_Ticks
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Boolean;
   --  Returns whether the values are corrected to the nearest step. See
   --  Gtk.Spin_Button.Set_Snap_To_Ticks.

   procedure Set_Snap_To_Ticks
      (Spin_Button   : not null access Gtk_Spin_Button_Record;
       Snap_To_Ticks : Boolean);
   --  Sets the policy as to whether values are corrected to the nearest step
   --  increment when a spin button is activated after providing an invalid
   --  value.
   --  "snap_to_ticks": a flag indicating if invalid values should be
   --  corrected

   function Get_Update_Policy
      (Spin_Button : not null access Gtk_Spin_Button_Record)
       return Gtk_Spin_Button_Update_Policy;
   --  Gets the update behavior of a spin button. See
   --  Gtk.Spin_Button.Set_Update_Policy.

   procedure Set_Update_Policy
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Policy      : Gtk_Spin_Button_Update_Policy);
   --  Sets the update behavior of a spin button. This determines wether the
   --  spin button is always updated or only when a valid value is set.
   --  "policy": a Gtk.Spin_Button.Gtk_Spin_Button_Update_Policy value

   function Get_Value
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Gdouble;
   --  Get the value in the Spin_Button.

   procedure Set_Value
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Value       : Gdouble);
   --  Sets the value of Spin_Button.
   --  "value": the new value

   function Get_Value_As_Int
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Gint;
   --  Get the value Spin_Button represented as an integer.

   function Get_Wrap
      (Spin_Button : not null access Gtk_Spin_Button_Record) return Boolean;
   --  Returns whether the spin button's value wraps around to the opposite
   --  limit when the upper or lower limit of the range is exceeded. See
   --  Gtk.Spin_Button.Set_Wrap.

   procedure Set_Wrap
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Wrap        : Boolean);
   --  Sets the flag that determines if a spin button value wraps around to
   --  the opposite limit when the upper or lower limit of the range is
   --  exceeded.
   --  "wrap": a flag indicating if wrapping behavior is performed

   procedure Spin
      (Spin_Button : not null access Gtk_Spin_Button_Record;
       Direction   : Gtk_Spin_Type;
       Increment   : Gdouble);
   --  Increment or decrement a spin button's value in a specified direction
   --  by a specified amount.
   --  "direction": a Gtk.Spin_Button.Gtk_Spin_Type indicating the direction
   --  to spin
   --  "increment": step increment to apply in the specified direction

   procedure Update (Spin_Button : not null access Gtk_Spin_Button_Record);
   --  Manually force an update of the spin button.

   ---------------------------------------------
   -- Inherited subprograms (from interfaces) --
   ---------------------------------------------
   --  Methods inherited from the Buildable interface are not duplicated here
   --  since they are meant to be used by tools, mostly. If you need to call
   --  them, use an explicit cast through the "-" operator below.

   procedure Editing_Done
      (Cell_Editable : not null access Gtk_Spin_Button_Record);

   procedure Remove_Widget
      (Cell_Editable : not null access Gtk_Spin_Button_Record);

   procedure Start_Editing
      (Cell_Editable : not null access Gtk_Spin_Button_Record;
       Event         : Gdk.Event.Gdk_Event);

   procedure Copy_Clipboard
      (Editable : not null access Gtk_Spin_Button_Record);

   procedure Cut_Clipboard
      (Editable : not null access Gtk_Spin_Button_Record);

   procedure Delete_Selection
      (Editable : not null access Gtk_Spin_Button_Record);

   procedure Delete_Text
      (Editable  : not null access Gtk_Spin_Button_Record;
       Start_Pos : Gint;
       End_Pos   : Gint := -1);

   function Get_Chars
      (Editable  : not null access Gtk_Spin_Button_Record;
       Start_Pos : Gint;
       End_Pos   : Gint := -1) return UTF8_String;

   function Get_Editable
      (Editable : not null access Gtk_Spin_Button_Record) return Boolean;

   procedure Set_Editable
      (Editable    : not null access Gtk_Spin_Button_Record;
       Is_Editable : Boolean);

   function Get_Position
      (Editable : not null access Gtk_Spin_Button_Record) return Gint;

   procedure Set_Position
      (Editable : not null access Gtk_Spin_Button_Record;
       Position : Gint);

   procedure Get_Selection_Bounds
      (Editable      : not null access Gtk_Spin_Button_Record;
       Start_Pos     : out Gint;
       End_Pos       : out Gint;
       Has_Selection : out Boolean);

   procedure Insert_Text
      (Editable        : not null access Gtk_Spin_Button_Record;
       New_Text        : UTF8_String;
       New_Text_Length : Gint;
       Position        : in out Gint);

   procedure Paste_Clipboard
      (Editable : not null access Gtk_Spin_Button_Record);

   procedure Select_Region
      (Editable  : not null access Gtk_Spin_Button_Record;
       Start_Pos : Gint;
       End_Pos   : Gint := -1);

   ----------------
   -- Interfaces --
   ----------------
   --  This class implements several interfaces. See Glib.Types
   --
   --  - "Buildable"
   --
   --  - "CellEditable"
   --
   --  - "Editable"

   package Implements_Gtk_Buildable is new Glib.Types.Implements
     (Gtk.Buildable.Gtk_Buildable, Gtk_Spin_Button_Record, Gtk_Spin_Button);
   function "+"
     (Widget : access Gtk_Spin_Button_Record'Class)
   return Gtk.Buildable.Gtk_Buildable
   renames Implements_Gtk_Buildable.To_Interface;
   function "-"
     (Interf : Gtk.Buildable.Gtk_Buildable)
   return Gtk_Spin_Button
   renames Implements_Gtk_Buildable.To_Object;

   package Implements_Gtk_Cell_Editable is new Glib.Types.Implements
     (Gtk.Cell_Editable.Gtk_Cell_Editable, Gtk_Spin_Button_Record, Gtk_Spin_Button);
   function "+"
     (Widget : access Gtk_Spin_Button_Record'Class)
   return Gtk.Cell_Editable.Gtk_Cell_Editable
   renames Implements_Gtk_Cell_Editable.To_Interface;
   function "-"
     (Interf : Gtk.Cell_Editable.Gtk_Cell_Editable)
   return Gtk_Spin_Button
   renames Implements_Gtk_Cell_Editable.To_Object;

   package Implements_Gtk_Editable is new Glib.Types.Implements
     (Gtk.Editable.Gtk_Editable, Gtk_Spin_Button_Record, Gtk_Spin_Button);
   function "+"
     (Widget : access Gtk_Spin_Button_Record'Class)
   return Gtk.Editable.Gtk_Editable
   renames Implements_Gtk_Editable.To_Interface;
   function "-"
     (Interf : Gtk.Editable.Gtk_Editable)
   return Gtk_Spin_Button
   renames Implements_Gtk_Editable.To_Object;

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
   --  Name: Climb_Rate_Property
   --  Type: Gdouble
   --  Flags: read-write
   --
   --  Name: The_Digits_Property
   --  Type: Guint
   --  Flags: read-write
   --
   --  Name: Numeric_Property
   --  Type: Boolean
   --  Flags: read-write
   --
   --  Name: Snap_To_Ticks_Property
   --  Type: Boolean
   --  Flags: read-write
   --
   --  Name: Update_Policy_Property
   --  Type: Gtk_Spin_Button_Update_Policy
   --  Flags: read-write
   --
   --  Name: Value_Property
   --  Type: Gdouble
   --  Flags: read-write
   --
   --  Name: Wrap_Property
   --  Type: Boolean
   --  Flags: read-write

   Adjustment_Property : constant Glib.Properties.Property_Object;
   Climb_Rate_Property : constant Glib.Properties.Property_Double;
   The_Digits_Property : constant Glib.Properties.Property_Uint;
   Numeric_Property : constant Glib.Properties.Property_Boolean;
   Snap_To_Ticks_Property : constant Glib.Properties.Property_Boolean;
   Update_Policy_Property : constant Gtk.Spin_Button.Property_Gtk_Spin_Button_Update_Policy;
   Value_Property : constant Glib.Properties.Property_Double;
   Wrap_Property : constant Glib.Properties.Property_Boolean;

   -------------
   -- Signals --
   -------------
   --  The following new signals are defined for this widget:
   --
   --  "change-value"
   --     procedure Handler
   --       (Self   : access Gtk_Spin_Button_Record'Class;
   --        Object : Gtk.Enums.Gtk_Scroll_Type);
   --
   --  "input"
   --     function Handler
   --       (Self      : access Gtk_Spin_Button_Record'Class;
   --        New_Value : out Gdouble) return Gint;
   --    --  "new_value": return location for the new value
   --  The ::input signal can be used to influence the conversion of the users
   --  input into a double value. The signal handler is expected to use
   --  Gtk.GEntry.Get_Text to retrieve the text of the entry and set New_Value
   --  to the new value.
   --
   --  The default conversion uses g_strtod.
   --
   --  was not handled, and GTK_INPUT_ERROR if the conversion failed.
   --
   --  Returns True for a successful conversion, False if the input
   --
   --  "output"
   --     function Handler
   --       (Self : access Gtk_Spin_Button_Record'Class) return Boolean;
   --  The ::output signal can be used to change to formatting of the value
   --  that is displayed in the spin buttons entry. |[ /* show leading zeros */
   --  static gboolean on_output (GtkSpinButton *spin, gpointer data) {
   --  GtkAdjustment *adjustment; gchar *text; int value;
   --
   --  adjustment = gtk_spin_button_get_adjustment (spin); value =
   --  (int)gtk_adjustment_get_value (adjustment); text = g_strdup_printf
   --  ("%02d", value); gtk_entry_set_text (GTK_ENTRY (spin), text); g_free
   --  (text);
   --
   --  return TRUE; } ]|
   --
   --  Returns True if the value has been displayed
   --
   --  "value-changed"
   --     procedure Handler (Self : access Gtk_Spin_Button_Record'Class);
   --
   --  "wrapped"
   --     procedure Handler (Self : access Gtk_Spin_Button_Record'Class);
   --  The wrapped signal is emitted right after the spinbutton wraps from its
   --  maximum to minimum value or vice-versa.

   Signal_Change_Value : constant Glib.Signal_Name := "change-value";
   Signal_Input : constant Glib.Signal_Name := "input";
   Signal_Output : constant Glib.Signal_Name := "output";
   Signal_Value_Changed : constant Glib.Signal_Name := "value-changed";
   Signal_Wrapped : constant Glib.Signal_Name := "wrapped";

private
   Adjustment_Property : constant Glib.Properties.Property_Object :=
     Glib.Properties.Build ("adjustment");
   Climb_Rate_Property : constant Glib.Properties.Property_Double :=
     Glib.Properties.Build ("climb-rate");
   The_Digits_Property : constant Glib.Properties.Property_Uint :=
     Glib.Properties.Build ("digits");
   Numeric_Property : constant Glib.Properties.Property_Boolean :=
     Glib.Properties.Build ("numeric");
   Snap_To_Ticks_Property : constant Glib.Properties.Property_Boolean :=
     Glib.Properties.Build ("snap-to-ticks");
   Update_Policy_Property : constant Gtk.Spin_Button.Property_Gtk_Spin_Button_Update_Policy :=
     Gtk.Spin_Button.Build ("update-policy");
   Value_Property : constant Glib.Properties.Property_Double :=
     Glib.Properties.Build ("value");
   Wrap_Property : constant Glib.Properties.Property_Boolean :=
     Glib.Properties.Build ("wrap");
end Gtk.Spin_Button;