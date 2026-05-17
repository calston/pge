uses {$I PGE.INC}
var
   MyGui :Tgui;
   MyScreen:Tscreen;
   done:boolean;
   demo2:Twin;

   bounce:twin;

   lines:twin;

   size,size2:integer;
   cmode,dmode:integer;

   bx,by:array[1..100]of integer;
   i,d:integer;
   bdx,bdy:integer;
   a,rx,ry:real;
   x,y:integer;
   num:integer;


procedure bbounce;
begin
{      ckillmouse( demo2.w_x+1,demo2.w_y+21,
              demo2.w_x+demo2.w_l-3,
              demo2.w_y+demo2.w_h-3);}

     setlinemode(lightgray,0,0,0);
     setfillmode(lightgray,0,8);

     circle(bx[num],by[num],11);

     i:=num+1;

     for d:= 1 to num-1 do
     begin
          dec(i);
          bx[i]:=bx[i-1];
          by[i]:=by[i-1];
     end;

     if (bx[1]<demo2.w_x+20) then bdx:=1;
     if (bx[1]>demo2.w_x+demo2.w_l-20) then bdx:=-1;
     if (by[1]<demo2.w_y+40) then bdy:=1;
     if (by[1]>demo2.w_y+demo2.w_h-20) then bdy:=-1;

     by[1]:=by[1]+bdy;
     bx[1]:=bx[1]+bdx;

     d:=0;

     for i:= 2 to num do
     begin
          inc(d);

          if d=1 then setlinemode(black,0,0,0);
          if d=2 then setlinemode(green,0,0,0);
          if d=3 then setlinemode(lightgreen,0,0,0);
          if d=4 then setlinemode(white,0,0,0);
          if d=5 then setlinemode(lightgreen,0,0,0);
          if d=6 then
          begin
               setlinemode(green,0,0,0);
               d:=0;
          end;
          circle(bx[i],by[i],10);
     end;
     wait(10);

end;


begin
     num:=100;
     MyScreen.Init;
     MyScreen.VideoOn;
     demo2.make(1,1,150,150,'Demo',150,150);
     size:=50;
     cmode:=1;
     for i:= 1 to num do
     begin
          bx[i]:=demo2.w_x+50;
          by[i]:=demo2.w_y+50;
     end;
     bdx:=1;
     bdy:=1;
     demo2.draw;
     randomize;

     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if demo2.windowClosed=true then done:=true;
          if demo2.moved=true then
             for i:= 1 to num do
                 begin
                      bx[i]:=demo2.w_x+50;
                      by[i]:=demo2.w_y+50;
                 end;
          if demo2.Resize=true then ;

          bbounce;

     end;

end.