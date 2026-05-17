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
5. [Docker Development Environment](#5-docker-development-environment)
6. [Compiling](#6-compiling)
7. [Module List](#7-module-list)
8. [Licence](#8-licence)

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

## 5. Docker Development Environment

A Docker-based environment is provided that runs DOSBox-X with Turbo Pascal 7 inside a container, accessible from any browser via a built-in web interface.

### Prerequisites

- Docker
- Turbo Pascal 7 installation files placed in `tp7/` (not included — Borland released TP7 as freeware for non-commercial use)

### Build and run

```bash
docker build -t pge .

docker run --rm -v ./src:/dos/src -v ./examples:/dos/examples -v ./build.bat:/dos/build.bat -p 14500:14500 pge
```

This builds the image and starts the container. The first build will take a few minutes to download dependencies.

### Accessing the environment

Open a browser and go to:

```
http://localhost:14500
```

DOSBox-X will launch automatically and run `build.bat`, which compiles all modules and examples.

To develop iteratively, the `src/`, `examples/`, and `build.bat` are volume-mounted — changes on the host are immediately visible inside the container without a rebuild. Just re-run `build.bat` from within DOSBox-X to recompile.

### Mouse input

Mouse capture is required for full mouse support. Click inside the DOSBox-X window in your browser, then press **Ctrl+F10** to capture the mouse. Press **Ctrl+F10** again to release it.

### Native Xpra client (better performance)

For lower latency, install the [Xpra client](https://github.com/Xpra-org/xpra/releases) and connect with:

```
xpra attach tcp://localhost:14500
```

---

## 6. Compiling

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

## 7. Module List

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

## 8. Licence

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

