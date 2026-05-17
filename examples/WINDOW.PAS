uses {$I PGE.INC}
var
   MyGui   :Tgui;
   MyScreen:Tscreen;
   done    :boolean;
   demo2   :Twin;

begin
     MyScreen.Init;
     MyScreen.VideoOn;
     demo2.make(1,1,150,150,'Window',150,150);

     demo2.draw;

     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if demo2.windowClosed=true then done:=true;
          if demo2.moved=true then;
          if demo2.Resize=true then;
     end;
end.