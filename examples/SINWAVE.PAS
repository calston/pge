program PopupWindow;

uses {$I PGE.INC}

var
   MyApp:TGui;
   Desktop:TScreen;

   Window1:TWin;
    Button:TButton;
   PopWindow:TWin;
   stop:boolean;

procedure SineW;
var x,y,x1,y1:integer;
    ox,oy:integer;
    sx,sy:real;
begin
     x1:=window1.w_x;
     y1:=window1.w_y;
     killmouse;
     ox:=0;
     oy:=0;
     for x:= 1 to 256 do
     begin
          sy:=sin(x/10);
          y:=round(sy*50);
          line(20+x1+ox,y1+100+oy,20+x1+x,100+y1+y);
          ox:=x; oy:=y;
     end;
     dispmouse;

end;

procedure loop;
begin
      while stop=false do
      begin
           if keypressed=true then if readkey=#27 then stop:=true;

           if Window1.WindowClosed=true then stop:=true;

           if Window1.Moved=true then
           begin
                killmouse;
                Window1.Draw;
                SineW;
                dispmouse;
           end;
      end;
end;
begin
      Desktop.Init;
      Desktop.VideoOn;
      Window1.Make(20,20,400,200,'Sine Wave',150,100);
      killmouse;
      drawbackground;
      dispmouse;

      Window1.draw;
      sinew;

      loop;
end.

