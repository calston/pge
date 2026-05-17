unit video;
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

                  Graphics Interface Driver

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
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


}

Interface
uses vesa256, crt, mousei;

     procedure video_on;
     procedure retrace;
     procedure save;
     procedure restore;
     procedure FillRectangle(x,y,x1,y1,color:integer);
     procedure GraphCLS;
     procedure video_off;
     procedure outnumxy(x,y,numb:integer);
     procedure video_13h;
     procedure OutlineBox(x,y,l,h:integer);
     procedure outtextxy(x,y:integer; s:string);
     procedure SetColor(s:integer);
     procedure outtext(s:string);
     Procedure DrawBackground;
     function TextWidth(s:string):integer;


Var SColor,BkColor,LineMode,BkDrawMode:byte;


implementation
uses pge,strings;


procedure setcolor;
begin
     scolor:=s;
end;

var pch:pchar;

function TextWidth(s:string):integer;
begin
     TextWidth:=GetTextWidth(S,false,0);
end;

procedure outtextxy;
begin
     {Added Y corection}
     puttext(x,y-2,s,FALSE,1,SColor,0,SpriteBlit);
end;

procedure outtext;
begin
     {Added Y corection}
     puttext(getx,gety-2,s,FALSE,1,SColor,0,SpriteBlit);
end;


var

{resolution settings}
    AutoDetect :pointer;
    resx,resy:integer;
{save settings types}
{    prvfont : textsettingstype;}
    prvcolor: integer;
    prvbkcol: integer;
 {   prvfill : fillsettingstype;}
{mouse stuf}
    buttons : word;

procedure video_13h;
assembler;
  asm
    mov ax,0013h;
    int 10h;
  end;


procedure video_on;

begin
     If DesktopRes=1 then
        StartVESA256(VESA640x480,Black);
     If DesktopRes=2 then
        StartVESA256(VESA800x600,Black);
     If DesktopRes=3 then
        StartVESA256(VESA1024x768,Black);
     If DesktopRes=4 then
        StartVESA256(VESA1280x1024,Black);
end;

Procedure DrawBackground;
var x1,y1:integer;
begin
     if bkdrawmode>1 then ClearGraphics(bkcolor);
     if (bkdrawmode<1) and (Wallpaper='') then ClearGraphics(bkcolor);
     if (wallpaper<>'') then
     begin
	  getPCXImageSize(strpcopy(pch,WallPaper),x1,y1);
          x1:=(getmaxx div 2) - (x1 div 2);
          y1:=(getmaxy div 2) - (y1 div 2);
	  LoadPCXImageXY(strpcopy(pch,WallPaper),x1,y1,CopyBlit,TRUE,TRUE,TRUE);{}
     end
end;


procedure FillRectangle(x,y,x1,y1,color:integer);
var tmp: integer;

begin
     SetLineMode(COLOR,0,0,0);
     SetFILLMode(color,0,0);

     box(x,y,x1,y1);
end;

{Closes the video drives and resets the gfx card}
procedure video_off;
begin
     FinishVesa256;
end;

procedure Retrace;
assembler;
asm
  mov dx,3dah
  @vert1:
    in al,dx
    test al,8
  jz @vert1
  @vert2:
    in al,dx
    test al,8
  jnz @vert2
end;

{saves the current settings}
procedure save;
begin

end;

{restores all the setings}
procedure restore;
          begin

          end;

procedure outnumxy(x,y,numb:integer);
var stru:string;
    o:longint;

begin
     o:=numb;
     Str(o, Stru);
     puttext(x,y,stru,true,1,SColor,0,SpriteBlit);
end;

procedure OutlineBox(x,y,l,h:integer);
begin

end;

procedure GraphCLS;
begin

end;

begin

end.

