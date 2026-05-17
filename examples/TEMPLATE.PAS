program Loader;
uses {$I PGE.INC}
var
   Desktop:TScreen;
   Wind:TWin;
   done:boolean;

procedure Draw;
begin
   Wind.draw;
end;

procedure MoveStuff;
begin
end;

procedure EvLoop;
begin
     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if Wind.WindowClosed=true then done:=true;
          if Wind.moved =true then movestuff;
          if Wind.resize=true then movestuff;

     end;


end;

begin
     Desktop.Init;
     Desktop.VideoOn;
     Wind.Make(100, 100, 300, 300, 'Program',100,100);

     draw;
     evloop;
     Desktop.VideoOff;
end.