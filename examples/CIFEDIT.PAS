uses {$I PGE.INC}
var
   Desktop:TScreen;

   Wind:TWin;

   grid:array[1..32,1..32] of byte;

   FilePop:TMenu;

   x,y:integer;
   dx,dy:integer;
   cx,cy:integer;
   i:integer;

   done:boolean;
   color:byte;

Procedure Save(pathc:string);
var fx,fy:integer;
    c:integer;
    out:char;
    line_in:string[10];
    ImageStream:stream;
begin
     if pathc='' then exit;
     ImageStream.DefineIO(pathc);
     ImageStream.OpenW;

     Line_In:='32x32x256';

     ImageStream.PutLine(Line_in);

     {Rip it}
     for y:= 1 to 32 do
        begin
             for x:=1 to 32 do
                begin
                     c:=grid[x,y]; {read}
                     out:=chr(c);
                     ImageStream.PutBit(out);
                end;
              ImageStream.PutLine('|');
        end;
     imageStream.closes;
end;

Procedure openc(pathc:string);
var fx,fy:integer;
    c:char;
    out:integer;
    line_in:string[10];
    ImageStream:stream;
begin
     if pathc='' then exit;
     ImageStream.DefineIO(pathc);
     ImageStream.OpenS;
     ImageStream.Getline;
     {Rip it}
     for y:= 1 to 32 do
        begin
             for x:=1 to 32 do
                begin
                     c:=ImageStream.GetBit;
                     out:=ord(c);
                     grid[x,y]:=out; {read}
                end;
              Line_in:=ImageStream.getLine;
        end;
     imageStream.closes;
end;

procedure dgrid(sx,sy:integer);
begin
     killmouse;

     for x:=1 to 32 do
         for y:=1 to 32 do
         begin
              SetFillMode(grid[x,y],0,0);
              box(x*10+sx,y*10+sy,x*10+10+sx,y*10+10+sy);
              setlineMode(15,0,1,0);
              box(x*10+sx,y*10+sy,x*10+10+sx,y*10+10+sy);
         end;
     dispmouse;
end;

procedure cgrid(sx,sy:integer);
var xt,yt:integer;
    mx,my:integer;
begin
     if mousebuttonpressed=true then
     begin
          mx:=mousepx;
          my:=mousepy;

          xt:=mx - sx;
          yt:=my - sy;

          dx:=xt div 10;
          dy:=yt div 10;

          if (dx<33) and (dx>0) then
             if (dy<33) and (dy>0) then
             begin
                  killmouse;
                  grid[dx,dy]:=color;
                  setFillMode(grid[dx,dy],0,0);
                  box(dx*10+1+sx,dy*10+1+sy,dx*10+9+sx,dy*10+9+sy);
                  dispmouse;
                  while mtir(dx*10+1+sx,dy*10+1+sy,dx*10+9+sx,dy*10+9+sy) do;
             end;
     end;
end;

procedure Pallet;
begin
     killmouse;
  for i:= 0 to 50 do
   begin
        setlineMode(i,0,1,0);
        setfillMode(i,0,0);
        box(cx+400,(i*5)+cy+50,cx+405,(i*5)+cy+55);
   end;

  for i:= 50 to 100 do
   begin
        setlineMode(i,0,1,0);
        setfillMode(i,0,0);
        box(cx+405,((i-49)*5)+cy+50,cx+410,((i-49)*5)+cy+50+5);
   end;
  for i:= 100 to 150 do
   begin
        setlineMode(i,0,1,0);
        setfillMode(i,0,0);
        box(cx+410,((i-99)*5)+cy+50,cx+415,((i-99)*5)+cy+50+5);
   end;
  for i:= 150 to 200 do
   begin
        setlineMode(i,0,1,0);
        setfillMode(i,0,0);
        box(cx+415,((i-149)*5)+cy+50,cx+420,((i-149)*5)+cy+50+5);
   end;
  for i:= 200 to 250 do
   begin
        setlineMode(i,0,1,0);
        setfillMode(i,0,0);
        box(cx+420,((i-199)*5)+cy+50,cx+425,((i-199)*5)+cy+50+5);
   end;
    SetFillMode(color,0,0);
   Box(cx+400,cy+330,cx+440,cy+360);
   dispmouse;

end;

procedure Draw;
begin
   Wind.draw;
   dgrid(wind.w_x+5,wind.W_y+50);

   dx:=wind.w_x;
   dy:=wind.w_y;
   cx:=wind.w_x;
   cy:=wind.w_y;

   pallet;

   Filepop          .draw;
end;

procedure MoveButtons;
begin
   Wind.DrawModeOn;
   dgrid(wind.w_x+5,wind.W_y+50);
   dx:=wind.w_x;
   dy:=wind.w_y;
   cx:=wind.w_x;
   cy :=wind.w_y;
   pallet;

   filepop       .ParentMove(wind);
   Wind.DrawModeOff;
end;



procedure EvLoop;
begin
     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if Wind.WindowClosed=true then done:=true;
          if Wind.moved=true then movebuttons;
          if Wind.resize=true then movebuttons;
          cgrid(wind.w_x+5,wind.W_y+50);

          {Check color}
{          box(dx+400,dy+50,dx+450,dy+50+255);}

           If (mtir(cx+400,cy+50,cx+450,cy+50+255)=true)
             and (MouseButtonPressed=true)  then
          begin
               KillMouse;
               color:=GetPixel(mousepx,mousepy);
               SetFillMode(color,0,0);
               Box(cx+400,cy+330,cx+440,cy+360);
               setcolor(white);
               outnumxy(cx+400+3,cy+340,color);
               Dispmouse;
               while mousebuttonpressed=true do movemouse;
          end;

          if FilePop.Open=true then
           begin
                FilePop.Destroy;

                if Filepop.clicknum=6 then done:=true;
                if Filepop.clicknum=0 then
                 begin

                 end;

                if Filepop.clicknum=1 then
                 begin

                      OpenC(GetFileDLG('Open CIF'));
                 end;

                if Filepop.clicknum=3 then
                 begin

                      Save(GetFileDLG('Save CIF'));
                 end;

                if Filepop.clicknum=4 then
                 begin
                      draw;
                      killmouse;
                      SavePCXImage('CIFEDIT.pcx');
                      DispMouse;
                 end;
                draw;
           end;
     end;
end;

begin
     Desktop.Init;
     Desktop.VideoOn;
     Wind.Make(20, 20, 500, 400, 'CIF Edit',450,380);
     FilePop.Make   (2,100,'File',Wind);

     Filepop.AddItem(0,'New');
     Filepop.AddItem(1,'Open');
     Filepop.AddItem(2,Void);
     Filepop.AddItem(3,'Save');
     Filepop.AddItem(4,'Screen Shot');
     Filepop.AddItem(5,Void);
     Filepop.AddItem(6,'Exit');
     draw;
     evloop;
     Desktop.VideoOff;
end.
