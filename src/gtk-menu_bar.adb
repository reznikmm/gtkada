-----------------------------------------------------------------------
--          GtkAda - Ada95 binding for the Gimp Toolkit              --
--                                                                   --
--                     Copyright (C) 1998-2000                       --
--        Emmanuel Briot, Joel Brobecker and Arnaud Charlet          --
--                                                                   --
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
-- License as published by the Free Software Foundation; either      --
-- version 2 of the License, or (at your option) any later version.  --
--                                                                   --
-- This library is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
--                                                                   --
-- As a special exception, if other files instantiate generics from  --
-- this unit, or you link this unit with other files to produce an   --
-- executable, this  unit  does not  by itself cause  the resulting  --
-- executable to be covered by the GNU General Public License. This  --
-- exception does not however invalidate any other reasons why the   --
-- executable file  might be covered by the  GNU Public License.     --
-----------------------------------------------------------------------

with System;
with Gdk; use Gdk;
with Gtk.Util; use Gtk.Util;

package body Gtk.Menu_Bar is

   ------------
   -- Append --
   ------------

   procedure Append
     (Menu_Bar : access Gtk_Menu_Bar_Record;
      Child    : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class)
   is
      procedure Internal
        (Menu_Bar : System.Address;
         Child    : System.Address);
      pragma Import (C, Internal, "gtk_menu_bar_append");
   begin
      Internal (Get_Object (Menu_Bar), Get_Object (Child));
   end Append;

   ------------
   -- Insert --
   ------------

   procedure Insert
     (Menu_Bar : access Gtk_Menu_Bar_Record;
      Child    : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class;
      Position : in Gint)
   is
      procedure Internal (Menu_Bar : System.Address;
                          Child    : System.Address;
                          Position : Gint);
      pragma Import (C, Internal, "gtk_menu_bar_insert");
   begin
      Internal (Get_Object (Menu_Bar), Get_Object (Child), Position);
   end Insert;

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New (Menu_Bar : out Gtk_Menu_Bar) is
   begin
      Menu_Bar := new Gtk_Menu_Bar_Record;
      Initialize (Menu_Bar);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Menu_Bar : access Gtk_Menu_Bar_Record'Class) is
      function Internal return System.Address;
      pragma Import (C, Internal, "gtk_menu_bar_new");
   begin
      Set_Object (Menu_Bar, Internal);
      Initialize_User_Data (Menu_Bar);
   end Initialize;

   -------------
   -- Prepend --
   -------------

   procedure Prepend
     (Menu_Bar : access Gtk_Menu_Bar_Record;
      Child    : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class)
   is
      procedure Internal (Menu_Bar : System.Address;
                          Child    : System.Address);
      pragma Import (C, Internal, "gtk_menu_bar_prepend");
   begin
      Internal (Get_Object (Menu_Bar), Get_Object (Child));
   end Prepend;

   ---------------------
   -- Set_Shadow_Type --
   ---------------------

   procedure Set_Shadow_Type
     (Menu_Bar : access Gtk_Menu_Bar_Record;
      The_Type : in Gtk_Shadow_Type)
   is
      procedure Internal
        (Menu_Bar : in System.Address;
         The_Type : in Gint);
      pragma Import (C, Internal, "gtk_menu_bar_set_shadow_type");
   begin
      Internal (Get_Object (Menu_Bar), Gtk_Shadow_Type'Pos (The_Type));
   end Set_Shadow_Type;

   --------------
   -- Generate --
   --------------

   procedure Generate (N    : in Node_Ptr;
                       File : in File_Type) is
   begin
      Gen_New (N, "Menu_Bar", File => File);
      Menu_Shell.Generate (N, File);
      Gen_Set (N, "Menu_Bar", "shadow_type", File => File);
   end Generate;

   procedure Generate (Menu_Bar : in out Gtk_Object;
                       N        : in Node_Ptr) is
      S : String_Ptr;
   begin
      if not N.Specific_Data.Created then
         Gtk_New (Gtk_Menu_Bar (Menu_Bar));
         Set_Object (Get_Field (N, "name"), Menu_Bar);
         N.Specific_Data.Created := True;
      end if;

      Menu_Shell.Generate (Menu_Bar, N);

      S := Get_Field (N, "shadow_type");

      if S /= null then
         Set_Shadow_Type (Gtk_Menu_Bar (Menu_Bar),
           Gtk_Shadow_Type'Value (S (S'First + 4 .. S'Last)));
      end if;
   end Generate;

end Gtk.Menu_Bar;
