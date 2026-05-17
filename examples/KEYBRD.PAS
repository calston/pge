program Loader;
uses {$I PGE.INC}
var
   Desktop:TScreen;

   Wind:TWin;

   on:tbutton;
   off:tbutton;

   hz:tedit;
   out:tlable;

   s:word;

   i:integer;

   sounds:boolean;

   done:boolean;

   Keys:array[1..30] of TButton;


procedure Draw;
begin
   Wind.draw;
   on.draw;
   off.draw;
   Hz.draw;
   out.draw;
   for i:= 1 to 30 do
     begin
          Keys[i].Draw;
     end;
end;

procedure MoveButtons;
begin
   on.ParentMove(wind);
   off.ParentMove(wind);
   Hz.ParentMove(wind);
   out.ParentMove(wind);
   for i:= 1 to 30 do
     begin
          Keys[i].ParentMove(wind);
     end;
end;




procedure EvLoop;
begin
     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if Wind.WindowClosed=true then done:=true;
          if Wind.moved=true then movebuttons;

          if on.pushed=true then
          begin
               out.erase;
               out.Lable:=int2str(s)+'Hz';
               out.draw;
               sound(s);
               sounds:=true;
               for i:= 1 to 30 do
               begin
                    Keys[i].Tapon:=false;
               end;
          end;

          if off.pushed=true then
          begin
               nosound;
               sounds:=false;
               for i:= 1 to 30 do
               begin
                    Keys[i].Tapon:=true;
               end;
          end;
          for i:= 1 to 30 do
          begin
               if Keys[i].pushed=true then
               begin
                    s:=i*66;
                    out.erase;
                    out.Lable:=int2str(s)+'Hz';
                    out.draw;
                    sound(s);
                    While Keys[i].pushed=true do;
                    if keys[i].tapon=true then nosound;
               end;
          end;

          if (hz.click=true) then
          begin
               s:=hz.ReadNum;
               out.erase;
               out.Lable:=int2str(s)+'Hz';
               out.draw;
               if sounds=true then sound(s);
          end;

     end;


end;

begin
     Desktop.Init;
     Desktop.VideoOn;
     Wind.Make(2, 2, 610, 220, 'Key Board',200,200);

     On.Make(10,30,100,25,'On',wind);
     off.make(10,60,100,25,'Off',wind);
     out.make(130,38,red,0,'1000Hz',wind);

     for i:= 1 to 30 do
     begin
          Keys[i].Make(5+(i-1)*20,150,18,50,'',wind);
          Keys[i].Tapon:=true;
     end;

     hz.make(130,60,100,25,wind);

     s:=10000;

     draw;
     evloop;
     Desktop.VideoOff;
end.