uses {$I PGE.INC}

{Scrap program for testing stuff}

var
   MyGui   :Tgui;
   MyScreen:Tscreen;
   done    :boolean;
   demo2   :Twin;
   test:pointer;

   x,y,dx,dy:integer;

   c:char;

   m:integer;

begin

     MyScreen.Init;
     MyScreen.VideoOn;

     {Testing memory bitmap loading... seems to work..}
     {Um, this 64Kb limit sucks! in 256 colour that is realy easy to max!}


{     Loadbitmap(test,'pge.pcx');}

     TileBitmap(250,70,'pge2.pcx',test);
     readkey;
     EraseBitmap(test);
{     dx:=2; dy:=4;
     m:=1;

     while not keypressed do
     begin

          if x>800 then dx:=-1;
          if x<1 then dx:=1;
          if y>600 then dy:=-1;
          if y<1 then dy:=1;
          inc(x,dx);
          inc(y,dy);
          drawbackground;
          if m=1 then DrawBitmap(x,y,test);
          if m=2 then LoadPCXimageXY('pge.pcx',x,y,spriteblit,true,true,true);
          WaitTOF;
          wait(60);
     end;

     DrawBitmap(1,1,test);

     EraseBitmap(test);


     {
     demo2.make(1,1,150,150,'S-Crap',150,150);

     demo2.draw;

     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if demo2.windowClosed=true then done:=true;
          if demo2.moved=true then;
          if demo2.Resize=true then;

     end;}
end.