{generate a theme.ini file}
uses {$I PGE.INC}

var ic,bk,tb,wc,bf,bfnt,ds,ls,fc,mo,moff,res:integer;
    wp:string;

   Desktop:TScreen;

   Wind:TWin;

   buttons:array[1..11] of TButton;

   FilePop:TMenu;

   x,y:integer;
   dx,dy:integer;
   cx,cy:integer;
   i:integer;

   done:boolean;
   color:byte;


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

   dx:=wind.w_x;
   dy:=wind.w_y;
   cx:=wind.w_x;
   cy:=wind.w_y;

   pallet;

   for i:= 1 to 11 do Buttons[i].Draw;

end;

procedure MoveButtons;
begin

   dx:=wind.w_x;
   dy:=wind.w_y;
   cx:=wind.w_x;
   cy :=wind.w_y;
   pallet;
   for i:= 1 to 11 do Buttons[i].ParentMove(Wind);

end;

procedure WriteTheme;
var them:text;
begin
     assign(them,'theme.ini');
     rewrite(them);


     writeln(them,'InsetColors=',InsetColors  );
     writeln(them,'BKColor='    ,BKColor  );
     writeln(them,'TBColor='    ,TBColor  );
     writeln(them,'WinColor='   ,WinColor );
     writeln(them,'BTNFace='    ,BTNFace  );
     writeln(them,'BTNFont='    ,BTNFont  );
     writeln(them,'DarkShad='   ,DarkShad );
     writeln(them,'LightShad='  ,LightShad);
     writeln(them,'FontColor='  ,FontColor);
     writeln(them,'MenuOn='     ,MenuOn   );
     writeln(them,'MenuOff='    ,MenuOff  );
     writeln(them,'WallPaper='  ,wp  );
     writeln(them,'Res='        ,res );

     close(them);

end;

var item:integer;

Procedure SetItem(n,w:integer);
begin

     case n of
          1:  insetcolors:=w;
          2:  BKColor    :=w;
          3:  TBColor    :=w;
          4:  WinColor   :=w;
          5:  BTNFace    :=w;
          6:  BTNFont    :=w;
          7:  DarkShad   :=w;
          8:  LightShad  :=w;
          9:  FontColor  :=w;
          10: MenuOn     :=w;
          11: MenuOff    :=w;
     end;
end;

function GetItem(n:integer):integer;
begin

     case n of
          1: GetItem:= insetcolors;
          2: GetItem:= BKColor    ;
          3: GetItem:= TBColor    ;
          4: GetItem:= WinColor   ;
          5: GetItem:= BTNFace    ;
          6: GetItem:= BTNFont    ;
          7: GetItem:= DarkShad   ;
          8: GetItem:= LightShad  ;
          9: GetItem:= FontColor  ;
          10: GetItem:= MenuOn    ;
          11: GetItem:= MenuOff   ;
     end;

end;

procedure EvLoop;
begin
     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if Wind.WindowClosed=true then done:=true;
          if Wind.moved=true then movebuttons;
          if Wind.resize=true then movebuttons;

          {Check color}
{          box(dx+400,dy+50,dx+450,dy+50+255);}

           for i:= 1 to 11 do if Buttons[i].pushed=true then
           begin
                Item:=i;
                Color:=getitem(item);
                KillMouse;
                SetFillMode(color,0,0);
                Box(cx+400,cy+330,cx+440,cy+360);
                setcolor(white);
                outnumxy(cx+400+3,cy+340,color);
                Dispmouse;
           end;

           If (mtir(cx+400,cy+50,cx+450,cy+50+255)=true)
             and (MouseButtonPressed=true)  then
          begin
               KillMouse;
               color:=GetPixel(mousepx,mousepy);
               SetItem(item,color);
               SetFillMode(color,0,0);
               Box(cx+400,cy+330,cx+440,cy+360);
               setcolor(white);
               outnumxy(cx+400+3,cy+340,color);
               Dispmouse;
               draw;
               while mousebuttonpressed=true do movemouse;
          end;

     end;
end;

begin
     Desktop.Init;
     Desktop.VideoOn;
     Wind.Make(20, 20, 500, 400, 'CIF Edit',450,380);

     Buttons[1].Make(20,50,200,25,'Inset Color',Wind);
     Buttons[2].Make(20,80 ,200,25,'Back Colour',Wind);
     Buttons[3].Make(20,110,200,25,'Titlebar Colour',Wind);
     Buttons[4].Make(20,140,200,25,'Window Colour',Wind);
     Buttons[5].Make(20,170,200,25,'Button Colour',Wind);
     Buttons[6].Make(20,200,200,25,'Button Font',Wind);
     Buttons[7].Make(20,230,200,25,'Dark Shadow',Wind);
     Buttons[8].Make(20,260,200,25,'Light',Wind);
     Buttons[9].Make(20,290,200,25,'Font Colour',Wind);
     Buttons[10].Make(20,320,200,25,'Menu Active',Wind);
     Buttons[11].Make(20,350,200,25,'Menu Inactive',Wind);

     wp:=Wallpaper;
     res:=DesktopRes;

     draw;
     evloop;

  if PGEMsg('YN','Would You Like To Save Your Changes?')='Y' then WriteTheme;

     Desktop.VideoOff;
end.


insetcolors
BKColor
TBColor
WinColor
BTNFace
BTNFont
DarkShad
LightShad
FontColor
MenuOn
MenuOff

InsetColors=7
BKColor=0
TBColor=27
WinColor=7
BTNFace=7
BTNFont=17
DarkShad=8
LightShad=15
FontColor=15
MenuOn=7
MenuOff=7
WallPaper=razor.pcx
Res=3

#Resolutions are
# 1: 640x480
# 2: 800x600
# 3: 1024x768
# 4: 1280x1024
