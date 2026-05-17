unit mousei;
{

                          .       .
                         / `.   .' \
                 .---.  <    > <    >  .---.
                 |    \  \ - ~ ~ - /  /    |
                  ~-..-~             ~-..-~
              \~~~\.'                    `./~~~/
    .-~~^-.    \__/                        \__/
  .'  O    \     /               /       \  \
 (_____,    `._.'               |         )  \/~~~/
  `----.          /       )     |        /    \__/
        `-.      |       /      |       /      `. ,~~|
            ~-.__|      /_ - ~ ^|      /- _      `..-'   :  :
                 |     /        |     /     ~-.     `-. _||_||_
                .|_____|       .|_____|         ~ - . _ _ _ _ _>

                           The
                Pascal Graphical Environment

               Mouse Driver Control Interface

}

interface
Uses {insert mouse driver here}
     vesa256,crt,dos;

     function MousePX:integer; {Where Mouse X}
     function MousePY:integer; {Where Mouse Y}

     function RightMouseButtonPressed:boolean;
     function RightMouseButtonReleased:boolean;

     function MouseButtonPressed:boolean;
     function MouseButtonReleased:boolean;

     Procedure MouseSX(x:integer);
     Procedure MouseSY(Y:Integer);

     Procedure MouseIOff;
     Procedure MouseIOn;

     procedure IntMouse;
     procedure DispMouse; {erase pointer}
     procedure KillMouse; {show pointer}

     procedure CDispMouse(x,y,x1,y1:integer); {Conditional erase}
     procedure CKillMouse(x,y,x1,y1:integer); {conditional display}

     procedure StartMouse;

     Procedure MCursor(x,y:integer;name:pchar);

     Procedure MouseOff;

     function mir{Mouse In Region}(x,y,x1,y1:integer):boolean;
     function mtir{Mouse Tip in Region}(x,y,x1,y1:integer):boolean;

     procedure TestIt;

     Var MouseShown:boolean;
     Var Int1cSave:pointer;
     Var MouseInts:boolean;


Implementation
Var NulI:integer;

Procedure MouseIOff;
begin
     MouseShown:=false;
end;
Procedure MouseIOn;
begin
     MouseShown:=true;
end;
procedure mouseoff;
begin
  SetIntVec($08,Int1CSave); {restore old int8 to dos, DONT TAKE THIS OUT!!!}
end;

procedure CDispMouse; {Conditional erase}
 Begin
      if MIR(x,y,x1,y1)=true then DispMouse;
 end;

procedure CKillMouse; {conditional display}
 Begin
      if MIR(x,y,x1,y1)=true then KillMouse;
 end;

Procedure MouseSX(x:integer);
 var buttons:word;
     xi,yi:word;
 Begin
{      buttons:=2;
       Xi:=x;
       yi:=mousey;
       mouse_position (buttons,xi,yi);}
       SetMouseXY(X,MousePY);
 End;

Procedure MouseSY(Y:Integer);
 var buttons:word;
     xi,yi:word;
 Begin
 {      buttons:=2;
       Yi:=y;
       xi:=mousex;
       mouse_position (buttons,xi,yi);}
       SetMouseXY(MousePX,Y);
 End;

function MousePX:integer; {Where Mouse X}
 var px:integer;
 Begin
      if MouseInts=false then movemouse;
      GetMouseXY(PX,NulI);
      MousePX:=px;
 End;


function MousePY:integer; {Where Mouse Y}
 var py:integer;
 Begin
      if MouseInts=false then movemouse;
      GetMouseXY(NulI,py);
      MousePY:=py;
 End;

function MouseButtonPressed:boolean;
 Var a,b,c:word;
 Begin
      MouseButtonPressed:=IsLeftMouseButtonDown;
 End;


function RightMouseButtonReleased:boolean;
 Var a,b,c:word;
 Begin
      if IsRightMouseButtonDown=false then RightMouseButtonReleased:=True
 End;

function RightMouseButtonPressed:boolean;
 Var a,b,c:word;
 Begin
      RightMouseButtonPressed:=IsRightMouseButtonDown;
 End;


function MouseButtonReleased:boolean;
 Var a,b,c:word;
 Begin
      if IsLeftMouseButtonDown=false then
      MouseButtonReleased:=True;
 End;

procedure DispMouse;
 Begin
      if mouseshown=true then exit;
      ShowMouse;
      mouseshown:=true;
 End;


procedure KillMouse;
 Begin
      if mouseshown=false then exit;
      mouseshown:=false;
      HideMouse;
 End;

{$F+,S-,W-}
PROCEDURE Mouse; INTERRUPT;
{returns the moment something changes (mouse buttons and keyboard)}

BEGIN
if mouseshown=true then MoveMouse;{}
END; {WaitForUser}
{$F-,S+}


procedure StartMouse;
 Begin
  mouseints:=true;

  GetIntVec($08,Int1CSave); {Save old int8 address, DONT TAKE THIS OUT!!}

  {
   Ultimately we want to put the bios timer in turbo mode, so we crank it
   up to +/- 10Khz, that gives a nice cycle rate :) and room for having
   some fun. Also makes it less glitchy, (see what its like with out it)
  }
  if 1=1 then
  begin
  asm
     mov cx, 119; {Pop the frequency in a 16bit register}
     mov al,36h;
     out 43h,al;  {Set port 36h}
     mov al,cl;
     out 40h,al;  {Set the low register frequency in port 40h}
     mov al,ch;
     out 40h,al   {Set the high registe frequency in port 40h}
  end;
  end;

  {Reroute int8 to our mouse refresher}
  SetIntVec($08,Addr(Mouse));{}
 End;

Procedure IntMouse;
begin
     SetMousePointers(0,0,'normal.pcx','resize.pcx','move.pcx');
end;

function mir{Mouse In Region}(x,y,x1,y1:integer):boolean;
begin
     if (mousepx>x-16) and (mousepx<x1) then
     begin
     if (mousepy>y-16) and (mousepy<y1) then mir:=true
     else mir:=false;
     end
     else mir:=false;

end;

function mtir{Mouse In Region}(x,y,x1,y1:integer):boolean;
begin
     if (mousepx>x) and (mousepx<x1) then
     begin
     if (mousepy>y) and (mousepy<y1) then mtir:=true
     else mtir:=false;
     end
     else mtir:=false;

end;

procedure TestIt;
var done:boolean;
    lastbtn:word;
begin
     intmouse;
{     while done=false do
     begin
          write('X=',mousePX,' Y=',mousePY,' Last Button',mousebutton);
          if readkey=#27 then done:=true;
     end;}
end;

Procedure MCursor;
begin
    SetMousePointers(0,0,name,name,name);
end;


end.