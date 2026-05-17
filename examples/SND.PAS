program Loader;
uses {$I PGE.INC}
var
   Desktop:TScreen;

   Wind:TWin;

   on:tbutton;
   off:tbutton;

   hz:tedit;
   hzs:tscrollbar;
   out:tlable;

   s:word;

   sounds:boolean;

   done:boolean;
procedure Draw;
begin
   Wind.draw;
   on.draw;
   off.draw;
   Hz.draw;
   hzs.draw;
   out.draw;
end;

procedure MoveButtons;
begin
   on.ParentMove(wind);
   off.ParentMove(wind);
   Hz.ParentMove(wind);
   hzs.ParentMove(wind);
   out.ParentMove(wind);
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
          end;

          if off.pushed=true then
          begin
               nosound;
               sounds:=false;
          end;

          if (hz.click=true) then
          begin
               s:=hz.ReadNum;
               out.erase;
               out.Lable:=int2str(s)+'Hz';
               out.draw;
               if sounds=true then sound(s);
          end;

          if hzs.change=true then
          begin
               s:=hzs.value;
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
     Wind.Make(2, 2, 250, 150, 'Tone Machine',200,200);

     On.Make(10,30,100,25,'On',wind);
     off.make(10,60,100,25,'Off',wind);

     out.make(130,38,red,0,'10000Hz',wind);

     hz.make(130,60,100,25,wind);
     Hzs.make(10,100,220,horizdir,10000,20000,wind);

     s:=10000;

     draw;
     evloop;
     Desktop.VideoOff;
end.