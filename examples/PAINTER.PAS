uses {$I PGE.INC}
var
   MyGui :Tgui;
   MyScreen:Tscreen;
   done:boolean;
   Slide:TScrollBar;
   image:TScrollBar;
   demo2:Twin;

   bounce:twin;

   lines:twin;

   size,size2:integer;
   cmode,dmode:integer;

   bx,by,i,bdx,bdy:integer;
   a,rx,ry:real;




begin
     MyScreen.Init;
     MyScreen.VideoOn;
     demo2.make(1,1,350,350,'Doodle',150,150);
     Demo2.DrawModeOn;
     slide.make(2,40,150,0,1,20,demo2);
     Image.make(2,60,150,0,1,5,demo2);
     Demo2.DrawModeOff;
     size:=50;
     cmode:=1;

     demo2.draw;
     slide.draw;
     image.draw;

     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if demo2.windowClosed=true then done:=true;
          if (demo2.moved=true) or (demo2.Resize=true) then
          begin
               slide.parentmove(demo2);
               image.parentmove(demo2);
          end;

          if slide.change then ;
          if image.change then ;
          if (mousebuttonpressed=true) and
          (mtir(demo2.w_x+30, demo2.w_y+60, demo2.w_x+demo2.w_l-30, demo2.w_y+demo2.w_h-30)) then
          begin
               killmouse;
               setlinemode(mousepx+mousepy,0,0,0);
               setfillmode(mousepx+mousepy,0,0);
               case image.value of
                    0:SavePCXImage('..\paint.pcx');
                    1:circle(mousepx,mousepy,slide.value);
                    2:box(mousepx-slide.value,
                          mousepy-slide.value,
                          mousepx+slide.value,
                          mousepy+slide.value);
                    3:line(mousepx-slide.value,
                         mousepy-slide.value,
                          mousepx+slide.value,
                          mousepy+slide.value);
                    4:line(mousepx-slide.value,
                         mousepy,
                          mousepx+slide.value,
                          mousepy);
               end;
               dispmouse;
          end;
{          _updown;
          bbounce;
          rotozoom;}


     end;

end.