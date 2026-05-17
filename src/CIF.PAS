unit cif;
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

              C.I.F. Icon Image Support Module

}
interface
uses io,vesa256,video,crt,{advcrt,}xpge,pge,mousei,fx,strings;

Type

      TCIF=object(twin)
           x,y:integer;
           ox,oy:integer;
           ImageStream:Stream;
           PSelected:boolean;

           Image:pointer;

           caption:string[50];

           Constructor Make(ix,iy:integer; Filename,iCaption:string; parent:twin);

           Procedure Draw; Virtual;
           Procedure Redraw; virtual;
           Function Selected:boolean;
           procedure ParentMove(parent:twin) ;Virtual;

           Destructor Destroy;
      end;

Implementation

Constructor TCIF.Make;
begin
     x:=ix+Parent.w_x;
     y:=iy+Parent.w_y;
     ox:=ix;
     oy:=iy;
     caption:=icaption;
     ImageStream.DefineIO(filename);
end;

Function TCIF.Selected:boolean;
begin
     if mtir(x,y,x+32,y+32)=true then
     if MouseButtonPressed=true then
     begin
          if Pselected=true then
            begin
                 Pselected:=false;
                 Selected:=true;
            end
          else
            PSelected:=true;
          TCIF.reDraw;
          while MouseButtonPressed=true do;
     end;
end;

procedure TCIF.Redraw;
begin
     ckillmouse(x-1,y-1,x+33,y+33);
     TCIF.Draw;
     Outtextxy(x,y+34,caption);
     cdispmouse(x-1,y-1,x+33,y+33);
end;

procedure TCIF.ParentMove;
begin
     x:=ox+Parent.w_x;
     y:=oy+Parent.w_y;
     TCif.Draw;
end;

Procedure TCIF.Draw;
var
   fx,fy:integer;
   fpos:integer;
   line_in:string;
   usefull:array[1..3] of char;
   c:integer;
   size:integer;
   temp:string;
   i:integer;
begin
     killmouse;

     ImageStream.OpenS; {Open stream}

     Line_In:=ImageStream.GetLine; {read first line, throw it away}

     inc(fpos);

     for fx:= 1 to 32 do
     begin
          for fy:=1 to 32 do
          begin
               {Read Pixel Data}
                usefull[1]:=ImageStream.GetBit;
               c:=ord(usefull[1]);
               if (c<>0) then putpixel(x+fy,y+fx,c);{Output}
          end;
          Line_In:=ImageStream.GetLine;{Next Line}
     end;

{     Size := ImageSize(x, y, x+32, y+32);
     GetMem(Image, Size);
     GetImage(x, y, x+32, y+32, Image^);}

     i:= x+(16-(GetTextWidth(caption,true,1)div 2));
     {S:string;Proportional:BOOLEAN;FontNr:BYTE)}

     text3d(i,y+34,caption,17,fontcolor);

     restore;
     dispmouse;

     ImageStream.CloseS; {Close Stream}
end;


Destructor TCIF.Destroy;
begin
     FillRectangle(x-1,y-1,x+33,y+33,bkcolor);
end;



end.