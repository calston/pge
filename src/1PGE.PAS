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


                     VV   VV     444
                     VV   VV    4444
                     VV   VV   44 44
                      VV VV   44  44
                      VV VV  44   44
                       VVV   44444444
                        V         44


                     Core System Module

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 1, or (at your option)
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
xFoundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

If you find fault with the PGE system then PLEASE send any bug
reports to diskbox@yifan.net. Please include your Pascal version
and any infomation that you feel might influence the problem.

}
unit pge;
interface
uses video,vesa256,crt,mousei,bitmap,fx,ini,advcrt,strings,dino;

const
     HorizDir=0;
     VertDir=1;
     SmoothingDelay=10;

Var
     SillyVar:pchar;
     ThemeConfig:Config;
     insetcolors:integer;
     BKColor   :integer;
     TBColor   :integer;
     WinColor  :integer;
     BTNFace   :integer;
     BTNFont   :integer;
     DarkShad  :integer;
     LightShad :integer;
     FontColor :integer;
     MenuOn    :integer;
     MenuOff   :integer;
     Wallpaper :string;
     DesktopRes:byte;

type

    TGui = object
         numwins:integer;
    end;

    {Main Gui Object}
    PScreen = ^TScreen;
    TScreen = object(TGui)
         DriverPath : string;
         Mode   : integer;
         Driver : integer;
         error  : integer;
         mouse_x, mouse_y: integer;
         errmsg : string;

         procedure init;
         function ScreenSaver:integer;
         procedure VideoOn;
         procedure mouseon;
         procedure mouseoff;
         procedure VideoOff;
    end;

    {Window Control Object}
    PWin = ^TWin;
    TWin = object(TGui)
         w_x       : integer;     {x location}
         w_y       : integer;     {y location}
         w_l       : integer;     {length}
         w_h       : integer;     {hight}
         w_caption : string ;     {caption}
         w_winsize : word   ;     {the size of the bitmap in w_window}
         w_minx    : integer;     {the minumum x size}
         w_miny    : integer;     {the minimum y size}
         w_isdrawn : boolean;     {has it been drawn yet?}
         StillResize:boolean;
         CL_x,CL_y : integer;
         WinJunk,BGJunk:Pointer;

         constructor Make(x,y,l,h:integer; title:string;minx,miny:integer);

         procedure Draw;              Virtual;{draw window}
         procedure Move(x,y:integer); Virtual;{move window to new x,y location}
         procedure ResizeDrag;        Virtual;{resize a window}
         Procedure DrawModeOn;
         Procedure DrawModeOff;
         function  IsDrawn:boolean;   Virtual;{is window drawn?  (interface)}
         function  Moved:boolean;     Virtual;{has the titlebar been pushed}
         function  Resize:boolean;    Virtual;{is the user trying to resize it}
         function  BodyPushed:boolean;Virtual;{was the entire window clicked}
         Function  WindowClosed:boolean; Virtual; {Has the user pressed the close button}
         function  Drag:boolean;              {drag a window}

         destructor destroy;          {Destroy window}
    end;

    {Consol}
    PConsol = ^TConsol;
    TConsol = Object(twin)
         x,y,l,h :integer;
         List    :array[1..100]of string[100];

    end;

    {Check Box Object}
    PChkBox = ^TChkBox;
    TChkBox = object(twin)
         x       : integer;
         y       : integer;
         lable   : string ;
         cischeck : boolean;
         parent  : TWin   ;
         co_x      : integer;
         co_y      : integer;
         Constructor Make(ix,iy:integer; ilable:string; iparent:twin); {make it}

         procedure Draw;             Virtual;     {Draw it}
         function  IsCheck:boolean; Virtual;      {is box checked}
         function  IsVoid :boolean; Virtual;      {is box clear}
         function  Pushed :boolean; Virtual;      {was it pushed}
         procedure Move(ix,iy:integer); Virtual;    {move it}
         procedure Change(ix,iy:integer; ilable:string);Virtual; {change it}
         procedure ParentMove(parentname:twin);    Virtual;   {Move to parent x,y pos}

         destructor Destroy;              {destroy it}
    end;

    {lable}
    PLable = ^TLable;
    TLable = object(TWin)
         x       :integer;              {LAble x}
         y       :integer;              {lable y}
         lable   :string ;            {lable text}
         labelcolor:integer;            {lable color}
         bkcolor :integer;            {lable bkcolor}
         ox      :integer;              {lable origional x}
         oy      :integer;              {lable origional y}
         l       :integer;
         font    :word;
         Host    :TWin;
         Constructor make(ix,iy,icol,ifont:integer; ilable:string; iparent:TWin);

         procedure  Draw; Virtual;{draw lable and set text}
         procedure  ParentMove(parent:TWin);  {move lable to parent x,y location}
         procedure  Erase;                    {supposed!! to erase lable}

         Destructor Destroy;
    end;
    {Button control object}
    PPCXButton = ^TPCXButton;
    TPCXButton = object(TWin)
         x       : integer;  {button x location}
         y       : integer;  {button y location}
         l       : integer;  {button length}
         h       : integer;  {button hight}
         PCXFile   : string ;  {button lable}
         ox      : integer;  {button origional x location}
         oy      : integer;  {button origional y location}
         isclose : boolean;  {is it a close button}
         ispushed: boolean;  {has it been pushed}

         MidX      : Integer;  {}
         MidY      : Integer;  {}
         Host     :TWin;

         constructor Make(ix,iy,il,ih:integer; pfile:string; parent:TWin);
         procedure ParentMove(parent:TWin);Virtual;
         procedure Draw;           virtual;   {draw it}
         function  Pushed:boolean;   Virtual;
         Procedure Push;virtual;              {push it}
         Procedure LetGo;            Virtual;
         procedure Move(ix,iy:integer);Virtual;
         destructor destroy;
    end;

    {Button control object}
    PButton = ^TButton;
    TButton = object(TWin)
         x        : integer;  {button x location}
         y        : integer;  {button y location}
         l        : integer;  {button length}
         h        : integer;  {button hight}
         lable    : string ;  {button lable}
         ox       : integer;  {button origional x location}
         oy       : integer;  {button origional y location}
         isclose  : boolean;  {is it a close button}
         ispushed : boolean;  {has it been pushed}
         StillDown:boolean;
         MidX     : Integer;  {}
         MidY     : Integer;  {}
         Host     :TWin;

         constructor Make(ix,iy,il,ih:integer; ilable:string;parent:TWin);
         procedure ParentMove(parent:TWin);Virtual;
         procedure Draw;           virtual;   {draw it}
         function  Pushed:boolean;   Virtual;
         Procedure Push;virtual;              {push it}
         Procedure LetGo;            Virtual;
         procedure Move(ix,iy:integer);Virtual;

         destructor destroy;
    end;

    {Progress bars}
    PProgress = ^TProgress;
    TProgress = object(TWin)
         x          :Integer;
         y          :Integer;
         l          :Integer;
         h          :Integer;
         max        :Integer;
         prX        :Integer;
         prY        :Integer;
         pposition  :integer;
         color      :integer;
         bartype    :integer;
         Host: TWIN;

         constructor make(px,py,pl,ph,pmax,pcolor,btype:integer;parent:TWin);

         Procedure Update(posit:integer);Virtual;

         Procedure Draw;                 Virtual;
         Procedure Incr(amt:integer);
         Procedure Decr(amt:integer);
         Procedure Move(tx,ty:integer);   Virtual;
         Procedure ParentMove(parent:TWin);Virtual;

         function Pos:integer;
         function PosX:integer;
         function PosY:integer;
         Function Step(amt:integer):integer;

         Destructor Destroy;
    end;

    PScrollBar = ^TScrollBar;
    TScrollBar = object(TWin)
         x        :integer;
         y        :integer;
         orx,ory  :integer;
         l        :integer;
         scrolldir:integer;
         position :integer;
         max      :integer;
         s1,s2,push:integer;
         Stoped   :boolean;
         Host     :TWin;

         increment:integer;

         Constructor make(sx,sy,sl,sdir,spos,smax:integer;parent:TWin);
         procedure Draw; virtual;
         procedure EraseS; virtual;
         procedure ReDraws; virtual;
         procedure Incr; procedure decr;
         Procedure ParentMove(parent:TWin); virtual;

         function Value:integer;

         function Change:boolean;

         Destructor Destroy;
    end;


procedure Idel;
Procedure NulCmd;
procedure Wait(m:integer);
function Int2Str(int:integer):string;
procedure WinCopy(var w1,w2:TWin);


implementation
uses xpge;

{
************************************************
****                                        ****
****           Support Functions            ****
****                                        ****
************************************************
}
procedure Idel;
begin
     asm
        ret
     end;
end;

procedure WinCopy;
begin
     w2.make(w1.w_x,w1.w_y,w1.w_l,w1.w_h,w1.w_caption,w1.w_minx,w1.w_miny);
end;

Procedure NulCmd;
begin

end;


Procedure WaitOn;
Begin
     FillRectangle(0,0,10,10,lightred)
end;

procedure WaitOff;
begin
     FillRectangle(0,0,10,10,bkcolor)
end;
function Int2Str(int:integer):string;
var s:string;
begin
     Str(Int, S);
     Int2Str := S;
end;

procedure Wait(m:integer);
var j,t:integer;
    f,g,h:real;
begin

     for t:= 1 to m do
      for j:= 1 to 2000 do
      begin
           movemouse;
           f:=g;
           g:=h;
           h:=t;
      end;
end;


{
************************************************
****                                        ****
****        Scroll Bars (TScrollBar)        ****
****                                        ****
************************************************
}

{TScroll Bar Begins Here}
Constructor TScrollbar.Make;
var temp,temp2:real;
begin
     {Setup Variables}
       x:=sx+parent.w_x;
       y:=sy+parent.w_y;
       orx:=sx;
       ory:=sy;
       l:=sl;
       scrolldir:=sdir; {0/1}

       temp:= (l-47)/100;
       temp2:=(spos/smax)*100;
       temp:=temp2*temp;
       position:=round(temp);
       s1:=0;
       s2:=0;
       max:=smax;
       increment:=1;
       push:=0;
     {Misc...}
     WinCopy(parent,host);
end;

procedure TScrollbar.EraseS;
var pos:integer;
begin
     killmouse;
     Host.DrawModeOn;

     if scrolldir=1 then
     begin
          fillrectangle(x+1,y+15+(position+2),x+14,y+30+(position+2),BTNFace);
     end;

     if (ScrollDir=0) then
     begin
          fillrectangle(x+15+(position+2),y+1,x+30+(position+2),y+14,BTNFace);
     end;
     Host.DrawModeOff;
     dispmouse;
end;


procedure TScrollbar.ReDraws;
var pos:integer;
begin
     killmouse;
     Host.DrawModeOn;

     if scrolldir=1 then
     begin
          If S1=0 then bevel(x,y,x+15,y+15,lightshad,darkshad);
          If S1=1 then bevel(x,y,x+15,y+15,darkshad,lightshad);

          If S2=0 then bevel(x,(y+l)-15,x+15,y+l,lightshad,darkshad);
          If S2=1 then bevel(x,(y+l)-15,x+15,y+l,darkshad,lightshad);

          {Marker Thing}
           Bevel(x+1,y+15+(position+2),x+14,y+30+(position+2),lightshad,darkshad);
     end;

     if (ScrollDir=0) then
     begin
          If S1=0 then bevel(x,y,x+15,y+15,lightshad,darkshad);
          If S1=1 then bevel(x,y,x+15,y+15,darkshad,lightshad);
          If S2=0 then bevel(x+l-15,y,x+l,y+15,lightshad,darkshad);
          If S2=1 then bevel(x+l-15,y,x+l,y+15,darkshad,lightshad);
          {Marker thing}
           Bevel(x+15+(position+2),y+1,x+30+(position+2),y+14,lightshad,darkshad);

     end;
     Host.DrawModeOff;
     dispmouse;
end;

Procedure TScrollBar.Draw;
var pos:integer;
begin
     killmouse;
     Host.DrawModeOn;
     if scrolldir=1 then
     begin
          fillrectangle(x,y,x+15,y+l,BTNFace);
          bevel(x,y,x+15,y+l,darkshad,lightshad);

          If S1=0 then bevel(x,y,x+15,y+15,lightshad,darkshad);
          If S1=1 then bevel(x,y,x+15,y+15,darkshad,lightshad);
          setcolor:=btnfont;
           outtextxy(x+5,y+3,chr(24));

          If S2=0 then bevel(x,(y+l)-15,x+15,y+l,lightshad,darkshad);
          If S2=1 then bevel(x,(y+l)-15,x+15,y+l,darkshad,lightshad);
          setcolor:=btnfont;
           outtextxy(x+5,y+l-12,chr(25));

          {Marker Thing}
           Bevel(x+1,y+15+(position+2),x+14,y+30+(position+2),lightshad,darkshad);
     end;

     if (ScrollDir=0) then
     begin
          {Base}
           fillrectangle(x,y,x+l,y+15,BTNFace);
           bevel(x,y,x+l,y+15,darkshad,lightshad);

          {End Buttons}
           If S1=0 then bevel(x,y,x+15,y+15,lightshad,darkshad);
           If S1=1 then bevel(x,y,x+15,y+15,darkshad,lightshad);
           setcolor:=btnfont;
            outtextxy(x+3,y+3,chr(27));

           If S2=0 then bevel(x+l-15,y,x+l,y+15,lightshad,darkshad);
           If S2=1 then bevel(x+l-15,y,x+l,y+15,darkshad,lightshad);
           setcolor:=btnfont;
            outtextxy(x+l-12,y+3,chr(26));

          {Marker Thing}
           Bevel(x+15+(position+2),y+1,x+30+(position+2),y+14,lightshad,darkshad);
     end;
     Host.DrawModeOff;
     dispmouse;
end;

procedure Tscrollbar.parentmove;
begin
     x:= orx + parent.w_x;{x is relevent to position in parent}
     y:= ory + parent.w_y;{y "..." }
     WinCopy(parent,host);
     TScrollBar.draw;
end;

{Procedure ReDraw(xi,yi:integer)
begin
end; }

Procedure TScrollBar.incr;
begin
     MoveMouse;
     if  position=l-47 then
     begin
          if stoped=false then TScrollbar.Redraws;
          stoped:=true;
          exit;
     end;
     stoped:=false;

     killmouse;
     if scrolldir=1 then
     begin
          TScrollbar.erases;
          position:=position+increment;
          if  position>l-47 then position:=l-47;
          TScrollbar.redraws;
          wait(SmoothingDelay);
     end;
     if scrolldir=0 then
     begin
          TScrollbar.erases;
          position:=position+increment;
          if  position>l-47 then position:=l-47;
          TScrollbar.Redraws;
          wait(SmoothingDelay);
     end;
     dispmouse;
end;

function TScrollBar.Value:integer;
var temp:real;
    temp2:real;
begin

     temp:= (position / (l-47)) *100;
     temp2:= (max/100)*1;
     temp:=temp2*temp;
     Value:=round(temp);
end;

Procedure TScrollBar.decr;
begin
     MoveMouse;
     if position=0 then
     begin
          if stoped=false then TScrollbar.Redraws;
          stoped:=true;
          exit;
     end;
     stoped:=false;
     killmouse;
     if scrolldir=1 then
     begin
          TScrollbar.erases;
          position:=position-increment;
          if position<0 then position:=0;
          {self.draw;}
          TScrollbar.Redraws;
          wait(SmoothingDelay);
     end;
     if scrolldir=0 then
     begin
          TScrollbar.erases;
          position:=position-increment;
          if  position<0 then position:=0;
          {self.draw;}
          TScrollbar.Redraws;
          wait(SmoothingDelay);
     end;
     dispmouse;
end;

Function TScrollBar.Change;
var pos,mx,dms,fd,my:integer;
begin

  if (Push>10) and (mousebuttonpressed=false) then
  begin
       s1:=0;
       s2:=0;
       push:=-1;
       stoped:=false;
       TScrollBar.Draw;
  end;


  if MouseButtonPressed=true then
  begin
     if scrolldir=0 then
     begin
          { < button }
         if (mtir(x,y,x+15,y+15)=true) then
         begin
          if MouseButtonPressed=true then
          begin
               s1:=1;
               TscrollBar.decr;
               Change:=true;
          end;
          push:=100;
         end;

          { > button }
         if (mtir(x+l-15,y,x+l,y+15)=true)  then
         begin
          if MouseButtonPressed=true then
          begin
               s2:=1;
               TscrollBar.incr;
               change:=true;
          end;
          push:=100;
         end;


          if mtir(x+15+(position+2),y+1,x+30+(position+2),y+14) then
          begin
             change:=true;
             mx:=mousePx;
             while MouseButtonPressed=true do
             begin
                  if mousepx<>mx then
                  begin
                       dms:=mx-mousepx;
                       TScrollBar.EraseS;
                       position:=position-dms;
                       if position>l-47 then position:=l-47;
                       if position<0 then position:=0;
                       TScrollBar.RedrawS;
                       mx:=mousepx;
                  end;
             end;
          end;

     end;

     if scrolldir=1 then
     begin
          { < button }
         if mtir(x,y,x+15,y+15)=true then
         begin
          if MouseButtonPressed=true then
          begin
               s1:=1;
               TscrollBar.decr;
               Change:=true;
          end;
          push:=100;
         end;
          { > button }
         if mtir(x,y+l-15,x+15,y+l)=true then
         begin
          if MouseButtonPressed=true then
          begin
               s2:=1;
               TscrollBar.incr;
               change:=true;
          end;
          push:=100;
         end;
 {         s1:=0;
          s2:=0;
          {if mtir(x+15+(position+2),y+1,x+30+(position+2),y+14) then}
          if mtir(x+1,y+15+(position+2),x+14,y+30+(position+2)) then
          begin
             change:=true;
             my:=mousePy;
             while MouseButtonPressed=true do
             begin
                  if mousepy<>my then
                  begin
                       dms:=my-mousepy;
                       TScrollBar.EraseS;
                       position:=position-dms;
                       if position>l-47 then position:=l-47;
                       if position<0 then position:=0;
                       TScrollBar.RedrawS;
                       my:=mousepy;
                  end;
             end;
          end;
     end;
  end;
  if stoped=true then Change:=false;
end;

Destructor TScrollBar.Destroy;
begin

end;


{
************************************************
****                                        ****
****           WINDOWS (TWin)               ****
****                                        ****
************************************************
}
{Creates the window}
constructor TWin.Make;
var thiswin:integer;
begin
     if numwins=10 then exit;
     w_x      := x;
     w_y      := y;
     w_l      := l;
     w_h      := h;
     w_caption:= title;
     w_minx   := minx;
     w_miny   := miny;
     StillResize:=false;
{     SpriteSelected:=Sprite;}

{BE-OS Style Title Bar..}
{     cl_x:=x+(length(w_caption)*9)+20-18;{}


end;

Procedure TWin.DrawModeOn;
begin
     {ClipGraphics(0,0,w_x+w_l-2,w_y+w_h-2);}
end;


Procedure TWin.DrawModeOff;
begin
 {    UnClipGraphics;
{     ClipGraphics(0,0,getmaxx,getmaxy);{}
end;

{Draws the window}
procedure TWin.Draw;
var  x1,y1,x,y:integer;
     tbx1:integer;
begin
     cl_x:=w_X+W_l-20;
     cl_y:=w_y+5;
     W_IsDrawn:=True;
     x1    := w_x+w_l;
     y1    := w_y+w_h;
     tbx1:=w_x+w_l; {}

     KillMouse;     {Disable mouse cursor}

     TitleBar(w_x,w_y,tbx1,w_y+25);

     {Window{}
     fillrectangle (w_x,w_y+27,x1,y1,WinColor);
     bevel(w_x,w_y+26,x1,y1,lightshad,darkshad);

     TWin.DrawModeOn;
     Text3d(w_x+6,w_y+7,W_caption,17,Fontcolor);
     TWin.DrawModeOff;

     x:=cl_x;
     y:=cl_y;
     x1:= x +15;
     y1:= y +15;

     fillrectangle (x, y, x1, y1, Tbcolor);{Fill Button Area}

     bevel(x,y,x1,y1,39,0);
     bevel(x+1,y+1,x1-1,y1-1,33,19);
     cross(x,y,x1,y1,white);

     DispMouse;
end;


{Resize a window}
procedure TWin.ResizeDrag;
var x,y,x1,y1,l,h:integer;
    mox,moy:integer;
begin
     if w_isdrawn =false then exit;
     x1:=w_x+w_l; {calculate extents}
     y1:=w_y+w_h; {                 }
     x:=w_x;
     y:=w_y;

     setcolor:=white;
     SetLineMode(255,4,1,5);
     mox:=MousePX;moy:=MousePY;{save current mouse Location}

     KillMouse;
     box(w_x,w_y,w_x+w_l,w_y+w_h);
     DispMouse;

     while MouseButtonPressed=true do
          begin {Wait for button to be released}
           if (MousePX <> mox) or (MousePY <> moy) then
              begin
               killMouse;

               box(w_x,w_y,w_x+w_l,w_y+w_h); {erase Rectangle}

               w_l:=w_l-(mox-MousePX);{calculate new x size}
               w_h:=w_h-(moy-MousePY);{calculate new y size}

               if w_l < w_minx then
                begin
                     w_l := w_minx;
                     mouseSx(mox);
                end;
               if w_h < w_miny then
                Begin
                     w_h := w_miny;
                     mouseSy(moy);
                end;

               box(w_x,w_y,w_x+w_l,w_y+w_h); {draw rectangle}

               mox:=MousePX;moy:=MousePY;{save current mouse Location}

               dispmouse;
              end;
          end;

     KillMouse;

     box(w_x,w_y,w_x+w_l,w_y+w_h);
     setLineMode(255,2,1,0);
     TWin.Destroy;
     TWin.Draw;{The shape is modified so it must be redrawn compleatly}
end;


{Drag a window}
function TWin.Drag;
var xt,yt,xt1,yt1:integer;
    mox,moy,
    mcx,mcy:integer;
begin
     unclipgraphics;
     if w_isdrawn =false then exit;
     setcolor:=white;
     SetLineMode(255,2,1,XORBlit);
     xt:=w_x; yt:=w_y; xt1:= W_x+w_l; yt1:=w_y+w_h;
{     mcursor(1,1,masktcross);}
     mox:=MousePX;moy:=MousePY;
     box(xt,yt,xt+w_l,yt+w_h);
     {while button is held down}
     repeat
           {mcursor(1,1,masktcross);}
           if (mox <> MousePX) or (moy <> MousePY) then
              begin
                   KillMouse;

                   {erase old rectangle}
                   box(xt,yt,xt+w_l,yt+w_h);

                   xt:=xt-(mox-MousePX); {Calculate Difference and position}
                   yt:=yt-(moy-MousePY); {                                 }

                   {draw new rectangle}
                   box(xt,yt,xt+w_l,yt+w_h);
                   DispMouse;
                   mox:=MousePX;moy:=MousePY; {Save time, only draw if mouse moves}
              end;

     until MouseButtonReleased=true;
     {mcursor(1,1,standard);}
     KillMouse;

     box(xt,yt,xt+w_l,yt+w_h);
     SetLineMode(255,2,1,0);
     {Start pesemistic}
     Drag:=false;
     {draw window in new location}
     if (xt<>w_x) or (yt<>w_y) then
     begin
          Drag:=true;
          TWin.Move(xt,yt);
     end;
     DispMouse;
end;

{DETECTION FUNCTIONS}

{Has the user pressed the close button}
Function  TWin.WindowClosed:boolean;
begin
     if MTIR(cl_x,cl_y,cl_x+15,cl_y+15)=true then
      if MouseButtonPressed=true then
       begin
            WindowClosed:=false;
            KillMouse;
            bevel(cl_x,cl_y,cl_x+15,cl_y+15,0,39);
            bevel(cl_x+1,cl_y+1,cl_x+15-1,cl_y+15-1,19,33);
            DispMouse;
            while MouseButtonPressed= true do
            begin
                 movemouse;
                 if MTIR(cl_x,cl_y,cl_x+15,cl_y+15)=false then
                 begin
                      killmouse;
                      bevel(cl_x,cl_y,cl_x+15,cl_y+15,39,0);
                      bevel(cl_x+1,cl_y+1,cl_x+15-1,cl_y+15-1,33,19);
                      dispmouse;
                      while MTIR(cl_x,cl_y,cl_x+15,cl_y+15)=false do
                      if MouseButtonPressed=false then exit
                 end;
                 if MTIR(cl_x,cl_y,cl_x+15,cl_y+15)=true then
                 begin
                      killmouse;
                      bevel(cl_x,cl_y,cl_x+15,cl_y+15,0,39);
                      bevel(cl_x+1,cl_y+1,cl_x+15-1,cl_y+15-1,19,33);
                      dispmouse;
                      while MTIR(cl_x,cl_y,cl_x+15,cl_y+15)=true do
                       if MouseButtonPressed=false then
                        begin
                             WindowClosed:=true;
                             TWin.destroy;
                             exit;
                        end;
                 end;
            end;
            WindowClosed:=true;
            TWin.Destroy;
       end;
end;


{Is window drawn (cant be clicked if its invisible}
function  TWin.IsDrawn:boolean;
begin
     IsDrawn:=w_isdrawn;
end;

{detects if a window was clicked}
{same as a button}
function TWin.Resize:boolean;
var  x1,y1:integer;
begin
     if w_isdrawn=false then exit;
     x1:=w_x+w_l;
     y1:=w_y+w_h;

     if mtir(x1-6,y1-6,x1+2,y1+2) then
     begin
          if StillResize=false then
          begin
               StillResize:=true;
               killmouse;
               mcursor(10,10,'.\resize.pcx');
               dispmouse;
          end;

          if MouseButtonPressed then
          begin
               TWin.ResizeDrag;
               Resize:=true;  {if so return TRUE }
          end;
     end
     else if StillResize=true then
     begin
          killmouse;
          mcursor(1,1,'.\normal.pcx');
          dispmouse;
          StillResize:=false;
     end;
end;

function TWin.BodyPushed:boolean;
var x1,y1:integer;

   begin

        if w_isdrawn=false then exit;
        x1:=w_x+w_l;
        y1:=w_y+w_h;
        if MouseButtonPressed then
        if mtir(w_x,w_y,x1,y1) then
                begin
                     BodyPushed:=true;         {if so return TRUE }
                end;
   end;

function TWin.Moved:boolean;
var mbt,mdx,mdy:word;
    x1:integer;
begin
     if w_isdrawn=false then exit; {if window is not drawn then exit}
     if MTIR(cl_x,cl_y,cl_x+15,cl_y+15)=true then exit;
     x1:=w_x+w_l;
     if mtir(w_x,w_y,x1,w_y+22) then   {Small optemisation in order of}
     begin
          if MouseButtonPressed=true then       {operation, every bit helps :) }
          begin
               killmouse;
               mcursor(10,10,'.\move.pcx');
               dispmouse;
               if TWin.Drag = true then Moved:=true;
               killmouse;
               mcursor(1,1,'.\normal.pcx');
               dispmouse;
          end;
     end;
end;


{Moves the window to a new loaction}

procedure TWin.Move(x,y:integer);
begin
     w_x:= x;            {move x location}
     w_y:= y;            {move y location}

     cl_x:=w_x+w_l-19; {}
     cl_y:=w_y+2;
     TWin.Destroy;
     TWin.draw;          {draw window (disable/enable cursor not needed,see Twin.Draw)}
end;

{Destroy the window}
destructor TWin.Destroy;
begin
      W_IsDrawn:=False;

      killmouse;
      DrawBackground;
      dispmouse;
end;

{
************************************************
****                                        ****
****            BUTTONS (TButton)           ****
****                                        ****
************************************************
}
{TButton Objects}

constructor TButton.Make;
begin
{Create a button}
         ox      := ix;
         oy      := iy;
         x       := ix+parent.w_x;
         y       := iy+parent.w_y;
         l       := il;
         h       := ih;
         lable   := ilable;
         IsPushed:=false;
         WinCopy(parent,host);
end;

{Draws the button}
procedure TButton.Draw;
var x1,y1,light,shad,mid:integer;
begin
     Host.DrawModeOn;
     if ispushed =false then
        begin
             light:=lightshad;shad:=darkshad;
        end
     else
        begin
             light:=darkshad;shad:=lightshad;
        end;

     x1:= x +l;
     y1:= y +h;
     KillMouse;
     fillrectangle (x, y, x1, y1, BtnFace);{Fill Button Area}

     rbevel(x,y,x1,y1, light,shad);
     {if its a close button draw one of those}
     if isclose=true then
     begin
           cross(x,y,x1,y1,white);
           DispMouse;
           restore;
           exit;
     end;

     midx      :=  (x + (l div 2)) - ( (length(lable) * 8) div 2);

     midy      :=  (y + (h div 2)) - 4;

     moveto (midx, midy);

     setcolor:=BTNFont;
     outtext(lable);

     restore;
     Host.DrawModeOff;
     DispMouse;
end;

{Let button go}
Procedure TButton.LetGo;
begin
     isPushed:=false;
     TButton.Draw;
end;
{Push a buttonn}
Procedure TButton.Push;
begin
     if ispushed=false then
     begin
          ispushed:=true;
          TButton.Draw;    {Redraw}
     end;
     if (isPushed=true) and (mousebuttonpressed=false) then
     begin
          TButton.LetGo;
     end;

end;


{move in accordance to parent structure}
procedure TButton.ParentMove(parent:TWin);
begin

     x    := ox + parent.w_x;
     y    := oy + parent.w_y;
     WinCopy(parent,host);

     TButton.draw;

end;

{Was button pushed}
function TButton.Pushed:boolean;
var x1,y1:integer;
begin
        x1:=x+l;
        y1:=y+h;
        pushed:=false;

        if (MouseButtonPressed=true) and (ispushed=false) then
        begin
             if mtir(x,y,x1,y1)=true then
             begin
                  ispushed:=true;
                  TButton.Draw;    {Redraw}
             end;
        end;

        if (ispushed=true) and  (mtir(x,y,x1,y1)=false) then
        begin
             TButton.LetGo;
        end;

        if (ispushed=true) and  (mousebuttonpressed=false) then
        begin
             TButton.LetGo;
             pushed:=true;
        end;

  end;



{Move a button}
procedure TButton.Move;
begin
     KillMouse;
     fillrectangle(x,y,x+l,y+h, bkcolor);
     x:=x;               {Move x coords}
     y:=y;               {Move y coords}
     TButton.Draw;       {redraw button}
     DispMouse;
end;

destructor TButton.Destroy; {Self explanetory,ok it destroys the button, da!}
begin
     fillrectangle(x,y,x+l,y+h,bkcolor);
end;

{
************************************************
****                                        ****
****        PCX  BUTTONS (TPCXButton)       ****
****                                        ****
************************************************
}
{TButton Objects}

constructor TPCXButton.Make;
begin
{Create a button}
         ox      := ix;
         oy      := iy;
         x       := ix+parent.w_x;
         y       := iy+parent.w_y;
         l       := il;
         h       := ih;
         PCXFile := pfile;
         IsPushed:=false;
         WinCopy(parent,host);
end;

{Draws the button}
procedure TPCXButton.Draw;
var x1,y1,light,shad,mid:integer;
    ww,hh:integer;
begin
     Host.DrawModeOn;
     if ispushed =false then
        begin
             light:=lightshad;shad:=darkshad;
        end
     else
        begin
             light:=darkshad;shad:=lightshad;
        end;
     x1:= x +l;
     y1:= y +h;

     KillMouse;
     fillrectangle (x, y, x1, y1, BtnFace);{Fill Button Area}
     rbevel(x,y,x1,y1, light,shad);
     GetPCXImageSize(STRPCOPY(sillyvar,PCXFile),Ww,Hh);
     midy      := y + ((h div 2) - (Hh div 2));
     midx      := x+((l div 2)-(ww div 2));
     LoadPCXImageXY(STRPCOPY(sillyvar,PCXfile)
                    , midX,midY,8, false,false,false);
     Host.DrawModeOff;
     DispMouse;
end;


{Let button go}
Procedure TPCXButton.LetGo;
begin
     isPushed:=false;
     TPCXButton.Draw;
end;
{Push a buttonn}
Procedure TPCXButton.Push;
begin

     ispushed:=true;

     TPCXButton.Draw;    {Redraw}

     while MouseButtonPressed=true do
     begin
     end;

     TPCXButton.LetGo;

end;


{move in accordance to parent structure}
procedure TPCXButton.ParentMove(parent:TWin);
begin

     x    := ox + parent.w_x;
     y    := oy + parent.w_y;
     WinCopy(parent,host);

     TPCXButton.draw;

end;

{Was button pushed}
function TPCXButton.Pushed:boolean;
var x1,y1:integer;
begin
        x1:=x+l;
        y1:=y+h;

        if mtir(x,y,x1,y1)=true then
        begin
             if MouseButtonPressed=true then
             begin                           {if so return TRUE }
                  ispushed:=true;
                  TPCXButton.Draw;    {Redraw}
                  while MouseButtonPressed=True do
                  begin
                       if mtir(x,y,x1,y1)=false then
                         begin
                              TPCXButton.LetGo;
                              pushed:=false;
                              exit;
                         end;
                  end;
                  TPCXButton.LetGo;
                  pushed:=true
             end;

        end;

  end;



{Move a button}
procedure TPCXButton.Move;
begin
     KillMouse;
     fillrectangle(x,y,x+l,y+h, bkcolor);
     x:=x;               {Move x coords}
     y:=y;               {Move y coords}
     TPCXButton.Draw;       {redraw button}
     DispMouse;
end;

destructor TPCXButton.Destroy; {Self explanetory,ok it destroys the button, da!}
begin
     fillrectangle(x,y,x+l,y+h,bkcolor);
end;

{
************************************************
****                                        ****
****          Check Boxes (TChkBox)         ****
****                                        ****
************************************************
}

{TChkBox Check Box Control}
Constructor TChkBox.Make;
   begin
        WinCopy(iparent,parent);
        x    := ix +iparent.w_x   ; {x is relevent to position in parent}
        y    := iy +iparent.w_y; {y "  "        "  "        "  "     -title bar hight (22) }
        co_x   := ix;
        co_y   := iy;
        lable:= ilable;
        cischeck:=false;
   end;

procedure TChkBox.Draw;
var x1,y1:integer;
   begin
        parent.DrawModeOn;
        x1:=x+15;
        y1:=y+15;
        KillMouse;

        {Create basic shape}
        fillrectangle(x,y,x1,y1,BTNFace);

        Bevel(x,y,x1,y1,darkshad,lightshad);

        If cischeck=true then
        begin
             FillRectangle(x+3,y+3,x1-3,y1-3,DarkShad);
        end;
        setcolor:=BTNFont;
        outtextxy(x1+8,y1 -11,lable);
        parent.DrawModeOff;
        DispMouse;
   end;

{is check box checked}
function  TChkBox.IsCheck: boolean;
   begin
        if cischeck=true then IsCheck:=true;{yes}
   end;

{is check box blank}
function  TChkBox.IsVoid : boolean;
   begin
        if cischeck=false then IsVoid:=true;{yes}
   end;

{was it changed/clicked}
function  TChkBox.Pushed : boolean;
var mbt,mdx,mdy:word;
    x1,y1:integer;
begin
        x1:=x+15;
        y1:=y+15;

        if MouseButtonPressed=true then {if mouse button pressed}
        if mtir(x,y,x1,y1)=true then
             begin                           {if so return TRUE }
                  Pushed:=true;
                  while MouseButtonPressed=true do;

                  if cischeck=true then cischeck:=false
                                    else cischeck:=true ;
                  TChkBox.Draw;
             end;

end;

{move to parent location}
procedure TChkbox.ParentMove(parentname:twin);
begin
     x    := co_x + parentname.w_x     ; {x is relevent to position in parent}
     y    := co_y + (parentname.w_y);
     WinCopy(parentname,parent);

     TChkBox.Draw;
end;

{move check box to specified location}
procedure TChkBox.Move;
   begin
        parent.DrawModeOn;
        fillrectangle(x,y,(x+15)+(length(lable)*8),y+15,lightgray);
        TChkBox.Draw;
   end;

{modify properties}
procedure TChkBox.Change;
   begin
        x:=ix;
        y:=iy;
        lable:=ilable;
   end;

{Destroy check box}
destructor TChkBox.Destroy;
   begin
   fillrectangle(x,y,(x+15)+(length(lable)*8)+8,y+15,lightgray);
   end;

{
************************************************
****                                        ****
****           Text Labels (TLable)         ****
****                                        ****
************************************************
}
Constructor TLable.make;
begin
     ox      := ix;
     oy      := iy;
     x       := iparent.w_x+ix;
     y       := iparent.w_y+iy;
     l       := (length(ilable)*8)+9;
     lable   := ilable;
     labelcolor:= icol;
     font    :=ifont;
     host:=iparent;
end;

{draw text}
procedure   TLable.Draw;
begin
     Host.DrawModeOn;
     if mir(x, y, x + l ,y+10)=true then KillMouse;

     TLable.Erase;

     setcolor:=labelcolor;

     outtextxy(x,y,lable);
     Host.DrawModeOff;
     DispMouse;
end;

{move to parent location}
procedure   TLable.ParentMove(parent:TWin);
begin
     x:=ox + parent.w_x;
     y:=oy + parent.w_y;
     WinCopy(parent,host);
     TLable.draw; {redraw lable}
end;

{Erase text}
procedure   TLable.Erase;
begin
     Host.DrawModeOn;
     fillrectangle(x, y, x+(length(lable)*8)+8, y+10,WinColor);
     Host.DrawModeOff;
end;

{Destroy text}
Destructor  TLable.Destroy;
begin
     TLable.Erase;
end;

{
************************************************
****                                        ****
****        Progress Bars (TProgress)       ****
****                                        ****
************************************************
}


Constructor TProgress.make;
begin
     {load x and y coords}
     X:= parent.w_x + px;
     Y:= parent.w_y + py;

     {Save initial values}
     prx:=px;
     pry:=py;

     {load length and hight values}
     L:=pl;
     H:=ph;
     pposition:=1;
     {load type (horizontal or vertical)}
     barType:=btype;

     {set bar color}
     color:=pcolor;
     max:=pmax;
     WinCopy(parent,host);

end;

{Draw Progress Bar}
Procedure TProgress.Draw;
var x1,y1:integer;
    i:integer;
    ppos:integer;
    temp,temp2:real;
begin
     Host.DrawModeOn;
     y1:=h+y; {Find bottom corner locations}
     x1:=l+x;

     {Disable mouse cursor if it is over the progress bar at draw time}
     if mir(x,y,x1,y1)=true then KillMouse;

     {Draw light gray rectangle}
     fillrectangle (x+1, y+1, x1-1, y1-1, BTNFace);
     {3d bevel}
     rbevel(x,y,x1,y1,darkshad,lightshad);

     {if bar is horizontal then use horizontal calculation method}
     if bartype=horizdir then
       begin
            if pposition>max then pposition:=max;
            if pposition<1 then pposition:=1;
            temp:= (pposition / max) * 100;
            temp2:= (l / 100)*1;
            temp:=temp*temp2;
            ppos:=round(temp);
            if ppos<1 then ppos:=1;
            if ppos>l-2 then ppos:=l-2;

            SeparatedBar(x+1,y+3,{x+3+}(ppos-3),h-6,0);
       end;

       {if bar is vertical then use vertical calculation method}
       if bartype=vertdir then
       begin
            if pposition>max then pposition:=max;
            if pposition<1 then pposition:=1;

            temp:= (pposition / max) * 100;
            temp2:= (h / 100)*1;
            temp:=temp*temp2;
            ppos:= round(temp);

            if ppos<1 then ppos:=1;
            if ppos>h-2 then ppos:=h-2;

            {draw bar}
            separatedbar(x+3,y1-2,l-6,ppos-1,1);
{           outnum(x+2,y+3,ppos);  }
       end;

       {restore color, font and dirrection settings}
       Host.DrawModeOff;
       DispMouse; {reenable mouse cursor if it was disabled}
end;{

Increment Progress bar by n' amount}
Procedure TProgress.Incr(amt:integer);
begin
     pposition:=pposition+amt;
     TProgress.Draw;
end;{

Decreace Progress bar by n amount}
Procedure TProgress.Decr(amt:integer);
begin
     pposition:=pposition-amt;
     TProgress.Draw;
end;{

Update Progress bar with specific amount}
Procedure TProgress.update(posit:integer);
begin
     if posit=pposition then exit;
     pposition:=posit;
     TProgress.Draw;
end;{

Move bar to some location (reletive to screen)}
Procedure TProgress.Move(tx,ty:integer);
begin
     TProgress.draw;
end;{

move to location (reletive to parent location)}
Procedure TProgress.ParentMove(parent:TWin);
begin
     x    := prx + parent.w_x     ; {x is relevent to position in parent}
     y    := pry + parent.w_y;      {y "..." }
     WinCopy(parent,host);
     TProgress.draw;
end;{

get progress bar possition}
function TProgress.Pos:integer;
begin
     pos:=pposition;
end;{


get x position}
Function TProgress.PosX:integer;
begin
     Posx:=x;
end;{

get y position}
Function TProgress.PosY:integer;
begin
     Posy:=x;
end;{

set step amount and return the previous one}
Function TProgress.Step(amt:integer):integer;
begin
     Step:=amt;
     step:=amt;
end;{

Destroy item}
Destructor TProgress.Destroy;
begin
     Fillrectangle(x,y,x+l,y+h,lightgray);
end;

{
************************************************
****                                        ****
****        Screen Control (TScreen)        ****
****                                        ****
************************************************
}
{TScreen}
procedure TScreen.init;
begin
     writeln('Reading Theme Data ');

     ThemeConfig.Define('theme.ini');

     InsetColors   := ThemeConfig.GetNum('InsetColors','=');

     BKColor   := ThemeConfig.GetNum('BKColor','=');
     TBColor   := ThemeConfig.GetNum('TBColor','=');
     WinColor  := ThemeConfig.GetNum('WinColor','=');
     BTNFace   := ThemeConfig.GetNum('BTNFace','=');
     BTNFont   := ThemeConfig.GetNum('BTNFont','=');
     DarkShad  := ThemeConfig.GetNum('DarkShad','=');
     LightShad := ThemeConfig.GetNum('LightShad','=');
     FontColor := ThemeConfig.GetNum('FontColor','=');
     MenuOn    := ThemeConfig.GetNum('MenuOn','=');
     MenuOff   := ThemeConfig.GetNum('MenuOff','=');
     WallPaper := ThemeConfig.GetData('WallPaper','=');
     DesktopRes:= ThemeConfig.GetNum('Res','=');
     ThemeConfig.CloseFile;

     TScreen.VideoOn;
     {Mcursor(1,8,'.\cur1.pcx');}
     {StartTimer;}
end;

procedure TScreen.VideoOn;
begin
     Video_on;
     KillMouse;
     DrawBackground;
     bkcolor:=bkcolor;           {set background}
     IntMouse;
     ClipGraphics(0,0,getmaxx,getmaxy);
end;

function TScreen.ScreenSaver:integer;
begin
   {  ScreenSaver:=-5;

     if elapsedtime > SaveTime then
     if (mouse_x=MousePX) and (Mouse_Y=MousePY) then
     begin
          ScreenSaver:=5;
          ClearDevice;
     end;

     if (mouse_x<>MousePX) or (Mouse_Y<>MousePY) then
     begin
          StartTimer;
          mouse_x:=MousePX;
          mouse_y:=MousePY;
          ScreenSaver:=1;
     end;
        }
end;

procedure TScreen.mouseon;
var i,c,b,color,buttons:word;
begin

end;


procedure TScreen.mouseoff;
begin
     KillMouse;
end;


procedure TScreen.VideoOff;
begin
     Killmouse;
     ClearGraphics(0);
     MouseOff;
     FinishVesa256;
     textmode(lastmode);
{     clrscr;     }
     writeln('Ok.');
     writeln('PGE Version 3.00');
     writeln('http://pge.iwarp.com');
end;


begin
     writeln('PGE Version 3.00');
     writeln('http://pge.iwarp.com');
     Screen;
     wait(1000);
end.
