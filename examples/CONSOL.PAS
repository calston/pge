uses crt,pge,video,vesa256,fx,mousei
;
var
   MyGui   :Tgui;
   MyScreen:Tscreen;
   done    :boolean;
   demo2   :Twin;
   test:string;
begin
     MyScreen.Init;
     MyScreen.VideoOn;

     Test:=StrEdit(100,100,100,'What??');
     Test:=StrEdit(40,50,100,'AGAIN?');


     demo2.make(1,1,150,150,'Consol',150,150);

     demo2.draw;

     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if demo2.windowClosed=true then done:=true;
          if demo2.moved=true then;
          if demo2.Resize=true then;

     end;
end.