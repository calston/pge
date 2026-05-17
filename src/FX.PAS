unit Fx;
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

                  Graphical Effects Module
}

interface

uses objects,mousei,video,vesa256;
type
     TbSprite=array[1..5,1..5] of integer;

Procedure FillPatern(patno:integer; R:TRect);
Procedure SeparatedBar(x,y,l,h,d:integer);

Procedure TitleBar(x,y,x1,y1:integer);
procedure Bevel(x,y,x1,y1,light,dark:integer);
procedure RBevel(x,y,x1,y1,light,dark:integer);
procedure cross(x,y,x1,y1,light:integer);
procedure Line3D(x,y,l,light,dark:integer);
procedure Text3d(x,y:integer;what:string;color1,color2:integer);
procedure OutNum(x,y,num:integer);
procedure DrawSprite(x,y:integer; mask:TbSprite);

implementation
uses PGE;

Procedure SeparatedBar;
var i,sd:integer;
    NumBlocks:integer;
const bSize=7;

begin
{     if l<1 then exit;
     fillrectangle(x+2,y,x+20-2,y+h,lightgreen);
     if l<15 then exit;}
     if d= 1 then
     begin
          NumBlocks:=round(h/bSize)-1;
          for i:= 0 to NumBlocks do
          begin
               fillrectangle(x,y-bSize-(i*bSize)+2,x+l,y-(i*bSize)-2,lightgreen);
               {for sd:= 1 to l do
               begin
                    setlinemode(245-sd,0,0,0);
                    line(x+sd,y-bSize-(i*bSize)+2,x+sd,y-bSize-(i*bSize)-2);

               end;}
          end;
{          fillrectangle(x,y-10-h+2,x+l,y-h-2,lightgreen);}
     end;

     if d= 0 then
     begin
          NumBlocks:=round(l/ bSize)-1;
          for i:= 0 to NumBlocks do
          begin
               fillrectangle(x+(i*bSize)+2,y,x+bSize+(i*bSize)-2,y+h,lightgreen);

               {for sd:= 1 to h do
               begin
                    setlinemode(245-sd,0,0,0);
                    line(x+(i*bSize)+2,y+sd,x+bSize+(i*bSize)-2,y+sd);

               end;}
          end;
     end;
end;


procedure DrawSprite(x,y:integer; mask:TbSprite);
var ix,iy:integer;
begin
{$R-}
     for ix:=1 to 5 do
      for iy:=1 to 5 do
      begin
           if (mask[iy,ix]<>0) then putpixel(ix+x,iy+y,mask[iy,ix]);
      end;
{$R+}
end;

procedure Cross;
begin
      SetLineMode(light,0,0,0);
      line   (x+4,y+4,x1-4,y1-4); {\1}
      line   (x+4,y1-4,x1-4,y+4); {/1}
end;

procedure outnum;
var s:string;
    d:longint;
begin
     D:=NUM;
     str(d,s);
     outtextxy(x,y,s);
end;

procedure DrawSprite3d(x,y:integer; mask:TbSprite;ls,ds:integer);
{Small procedure to draw a 5x5 mask. This time we enterpret
 1 and 2 as linked to a variable sothat one mask can be used
 for difernt colors, eg make a sprite look like it is out or in}
var ix,iy:integer;
begin
     for ix:= 1 to 5 do
      for iy:=1 to 5 do
      begin
           if (mask[iy,ix]=0) then putpixel(ix+x,iy+y,BtnFace);
           if (mask[iy,ix]=1) then putpixel(ix+x,iy+y,ls);
           if (mask[iy,ix]=2) then putpixel(ix+x,iy+y,ds);
           {if (mask[iy,ix]=3) then putpixel(ix+x,iy+y,WinColor);}
      end;
end;



procedure Line3D(x,y,l,light,dark:integer);
begin
     SetLineMode(light,0,0,0);
     line(x,y,x+l,y);
     SetLineMode(dark,0,0,0);
     line(x,y+1,x+l,y+1);
end;

Procedure Text3d;
{Put a "3d" drop shadow on some text}
begin
     setlinemode(0,0,0,2);
     setcolor(color1);
     moveto(x+2,y+2);
     outtext(what);
     setcolor(color2);
     SetLineMode(color2,0,0,0);
     moveto(x,y);
     outtext(what);
end;

Procedure FillPatern(patno:integer; R:TRect);
begin

end;

procedure RBevel;

{These make up the masks for the corners}
const left:TbSprite= ((03,03,03,03,03),
                      (03,03,03,01,01),
                      (03,03,01,00,00),
                      (03,01,00,00,00),
                      (03,01,00,00,00));

     right:TbSprite= ((03,03,03,03,03),
                      (01,02,03,03,03),
                      (00,00,02,03,03),
                      (00,00,00,02,03),
                      (00,00,00,02,03));

     bleft:TbSprite= ((03,01,00,00,00),
                      (03,01,00,00,00),
                      (03,03,02,00,00),
                      (03,03,03,02,02),
                      (03,03,03,03,03));

     bright:TbSprite= ((00,00,00,02,03),
                       (00,00,00,02,03),
                       (00,00,02,03,03),
                       (02,02,03,03,03),
                       (03,03,03,03,03));
begin

     SetLineMode(light,0,0,0);
     line(x+5,y,x1-5,y ); { top}
     line(x,y+5,x ,y1-5); {left}

     DrawSprite3d(x-1,y-1,Left,light,dark);
     DrawSprite3d(x1-5,y-1,right,light,dark);
     DrawSprite3d(x-1,y1-5,bleft,light,dark);
     DrawSprite3d(x1-5,y1-5,bright,light,dark);

     SetLineMode(dark,0,0,0);
     line (x1,y+5,x1,y1-5); {right}
     line (x+5 ,y1,x1-5,y1); {bottom}
end;

procedure Bevel;
begin

     SetLineMode(light,0,0,0);
     line(x,y,x1,y ); { top}
     line(x,y,x ,y1); {left}

     SetLineMode(dark,0,0,0);
     line (x1,y,x1,y1); {right}
     line (x ,y1,x1,y1); {bottom}
end;


Procedure TitleBar;
var i,p,row:integer;

{ "Windows XP" style corners... sort of :) }

const left:TbSprite= ((00,00,00,00,00),
                      (00,00,00,81,81),
                      (00,00,45,39,39),
                      (00,45,39,33,33),
                      (00,45,39,33,00));

     right:TbSprite= ((00,00,00,00,00),
                      (81,39,00,00,00),
                      (39,39,33,00,00),
                      (25,24,39,19,00),
                      (26,25,24,232,00));

begin
     fillrectangle(x+3,y+6,x1-1,y1,tbcolor);

     setlinemode(45,0,0,0);
     line(x+5,y,x1-5,y);

     setlinemode(TBcolor,0,0,0);
     line(x+3,y+3,x1-3,y+3);
     line(x+2,y+4,x1-2,y+4);
     line(x+1,y+5,x1-1,y+5);

     {DarkPart}
     setlinemode(232,0,0,0);
     line(x1,y+5,x1,y1);
     line(x+1,y1,x1-1,y1);

     setlinemode(24,0,0,0);
     line(x+1,y1-1,x1-1,y1-1);
     line(x1-1,y+5,x1-1,y1);{}

     setlinemode(25,0,0,0);
     line(x+1,y1-2,x1-1,y1-2);
     line(x1-2,y+5,x1-2,y1-2);{}

     setlinemode(26,0,0,0);
     line(x+1,y1-3,x1-1,y1-3);
     line(x+1,y1-4,x1-1,y1-4);
     line(x1-2,y+5,x1-2,y1-3);{}

     setlinemode(45,0,0,0);
     line(x,y+5,x,y1);

     setlinemode(39,0,0,0);
     line(x+5,y+1,x1-5,y+1);
     line(x+1,y+4,x+1,y1-1);

     setlinemode(33,0,0,0);
     line(x+3,y+2,x1-3,y+2);
     line(x+2,y+4,x+2,y1-2);

     DrawSprite(x-1,y-1,left);{}
     DrawSprite(x1-5,y-1,right);
end;


end.