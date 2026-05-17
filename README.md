```
                          .       .
                         / `.   .' \
                 .---.  <    > <    >  .---.
                 |    \  \ - ~ ~ - /  /    |
                  ~-..-~             ~-..-~
              \~~~\.'                    `./~~~/
    .-~~^-.    \__/         PGE            \__/
  .'  O    \     /               /       \  \
 (_____,    `._.'               |         }  \/~~~/
  `----.          /       }     |        /    \__/
        `-.      |       /      |       /      `. ,~~|
            ~-.__|      /_ - ~ ^|      /- _      `..-'   :  :
                 |     /        |     /     ~-.     `-. _||_||_
                .|_____|       .|_____|         ~ - . _ _ _ _ _>
```

# The Pascal Graphical Environment

A GUI widget toolkit for building graphical DOS applications in Turbo Pascal 7.

---

## Contents

1. [What is PGE?](#1-what-is-pge)
2. [Examples](#2-examples)
3. [Getting Started](#3-getting-started)
4. [Extending PGE](#4-extending-pge)
5. [Compiling](#5-compiling)
6. [Module List](#6-module-list)
7. [Licence](#7-licence)

---

## 1. What is PGE?

PGE is a GUI widget set that provides a framework for developing graphical applications for DOS.

**Note:** PGE is not a full GUI environment. It provides extremely simple control of UI elements to create an easy method of programming graphical apps while still maintaining simplicity and control. The programmer retains full control of the event loop — you define the events.

---

## 2. Examples

The `examples/` directory contains several demo programs:

| File | Description |
|------|-------------|
| `Demo.pas` | Demonstrates all of the controls |
| `Demo2.pas` | Demonstrates animation inside a window |
| `Calc.pas` | A simple calculator |
| `CDPlayer.pas` | A CD player application |
| `Popwin.pas` | Demonstrates drawing a window at runtime |
| `Editor.pas` | A simple popup and edit box implementation |

---

## 3. Getting Started

Here is a minimal template for a PGE application:

```pascal
program MyProgram;

uses crt, {$I pge.inc}

var
   MyGUI    : TGui;
   MyScreen : TScreen;
   MyWindow : TWin;
   MyButton : TButton;
   Done     : boolean;

procedure MyEventLoop;
begin
   while Done = false do
   begin
      if keypressed = true then
         if readkey = #27 then Done := true; { Exit on Escape }

      if MyWindow.Closed = true then Done := true; { Exit on close button }

      if MyButton.pushed = true then
      begin
         { Insert button handler here }
      end;

      { Insert other event handlers here }

      if MyWindow.Moved = true then          { If window was moved... }
         MyButton.ParentMove(MyWindow);      { ...redraw button in parent }
   end;
end;

begin
   MyScreen.Init('.\', 0, 0);   { Initialise screen }

   { TWin.Make(x, y, width, height, caption, minWidth, minHeight, titleBarColor) }
   MyWindow.Make(20, 20, 150, 100, ' Sample Window ', 150, 100, blue);
   MyButton.Make(30, 50, 70, 20, 'Button1', 0, Window1);

   MyWindow.Draw;
   MyButton.Draw;

   MyEventLoop;

   DeskTop.VideoOff;
end.
```

---

## 4. Extending PGE

Rather than adding to the already large `PGE.PAS`, new controls should be created as separate units (as `EditBox.pas` was), or added to `XPGE`. Here is a template for a custom control:

```pascal
unit MyControl;

interface

uses crt, graph, pge, fx, mousei, video;

const
   { Insert constants here }

type
   PControl = ^TControl;
   TControl = Object(TWin)
      x, y, l, h : integer;
      ox, oy      : integer;
      { Insert variables here }

      Constructor Make(rx, ry, rl, rh, rFont: Integer;
                       rBlankOut: Boolean; parent: TWin);
      Procedure   Draw;                     Virtual;
      Procedure   ParentMove(Parent: TWin); Virtual;
      { Insert methods here }
      Destructor  Destroy;
   end;

Implementation

Constructor TControl.Make;
begin
   ox := rx;
   oy := ry;
   x  := rx + Parent.w_x;
   y  := ry + Parent.w_y;
   l  := rl;
   h  := rh;
   { Insert constructor code here }
end;

Procedure TControl.Draw;
begin
   Mouse_Cursor(false);
   { Insert drawing code here }
   Mouse_Cursor(true);
end;

Procedure TControl.ParentMove;
begin
   x := ox + Parent.w_x;
   y := oy + Parent.w_y;
   Self.Draw;
end;

Destructor TControl.Destroy;
begin
   { Insert cleanup code here }
end;

end.
```

---

## 5. Compiling

### Using `build.bat`

A `build.bat` script is included to compile all examples and modules. Edit it to point to your Turbo Pascal installation:

```bat
set TP=C:\where_pascal_is
```

Then run `build.bat`.

### Compiling from Turbo Pascal IDE

1. Go to **Options → Directories**.
2. Under **Units**, add the path to the PGE folder alongside your TP7 units path, separated by semicolons:

```
C:\TP\UNITS;.\PGE
```

The `.\PGE` entry tells the compiler to look for PGE units in the `PGE` subfolder relative to the current directory.

### Including PGE in your program

```pascal
uses myunits, {$I pge.inc}
```

---

## 6. Module List

| Module | Description |
|--------|-------------|
| `PGE.PAS` | Main module |
| `POPUP.PAS` | Popup menu |
| `VIDEO.PAS` | Video output |
| `FX.PAS` | Special effects |
| `EDITBOX.PAS` | Edit box control |
| `BITMAP.PAS` | Bitmap support |
| `LISTBOX.PAS` | List box control |
| `KEYDEF.PAS` | Key map definitions |
| `MISC.PAS` | Miscellaneous tools |
| `MATH.PAS` | Math utilities |
| `XGRAPH.PAS` | Graphics extensions |
| `DINO.PAS` | Dino the PGE Dinosaur |
| `XCRT.PAS` | CRT extensions |
| `CDAUDIO.PAS` | CD player control |
| `MOUSE.PAS` | Mouse driver |
| `MOUSEI.PAS` | Mouse driver interface |
| `INI.PAS` | `.INI` file parsing |
| `DIALOG.PAS` | Dialog boxes |
| `IO.PAS` | File I/O |

---

## 7. Licence

    The Pascal Graphical Environment
    Copyright (C) 2000 Colin Alston

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 1, or (at your option)
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

---

