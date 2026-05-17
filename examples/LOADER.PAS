 program Loader;
{$M $8000,$1000,$18000 }   { 16K stack, big heap }
uses {$I PGE.INC}
var
   LoaderApp:TGui;
   LoaderDesktop:TScreen;

   LoaderWindow:TWin;

   PopDemo:TButton;
   SineWave:TButton;
   CIFEditor:TButton;
   Demo   :TButton;
   Demo2  :TButton;
   Calc   :TButton;
   CD     :TButton;
   edit     :TButton;
   quit   :Tbutton;

   i:integer;
   c:char;
   strs:string;

   done:boolean;
{
   LoaderWindow
   PopDemo
   Demo
   Demo2
   Calc
   CD
}
procedure Draw;
begin
   LoaderWindow.draw;
   SineWave.draw;
   CIFEditor.draw;
   PopDemo.Draw;
   Demo   .Draw;
   Demo2  .Draw;
   Calc   .Draw;
   CD     .Draw;
   quit   .Draw;
   edit    .Draw;
end;
procedure execute(name:string);
begin
     killmouse;
     LoaderDesktop.VideoOff;
     SwapVectors;
     Exec(GetEnv('COMSPEC'), ' /C ' + name);
     SwapVectors;
     LoaderDesktop.init;
     LoaderDesktop.VideoOn;
     DrawBackground;
     draw;
end;

procedure MoveButtons;
begin
   PopDemo.ParentMove(LoaderWindow);
   Demo   .ParentMove(LoaderWindow);
   Demo2  .ParentMove(LoaderWindow);
   Calc   .ParentMove(LoaderWindow);
   CD     .ParentMove(LoaderWindow);
   quit   .ParentMove(LoaderWindow);
   edit   .ParentMove(LoaderWindow);
   SineWave.ParentMove(LoaderWindow);
   CIFEditor.ParentMove(LoaderWindow);
end;




procedure EvLoop;
begin
     while done=false do
     begin
	  Done:=false;
          if keypressed then if readkey=#27 then done:=true;
          if LoaderWindow.WindowClosed=true then done:=true;

          if PopDemo.Pushed=true then execute('.\painter.exe');
          if Demo   .Pushed=true then execute('.\demo.exe');
          if Demo2  .Pushed=true then execute('.\demo2.exe');
          if Calc   .Pushed=true then execute('.\calc.exe');
          if CD     .Pushed=true then execute('.\cdplayer.exe');
          if Edit   .Pushed=true then execute('.\editor.exe');
          if CIFEditor.Pushed=true then execute('.\cifedt.exe');
          if SineWave.Pushed=true then execute('.\sinewave.exe');
          if quit   .Pushed=true then done:=true;
          if loaderwindow.moved=true then movebuttons;
     end;


end;

begin
     LoaderDesktop.Init;
     LoaderDesktop.VideoOn;
     LoaderWindow .Make(200, 150, 100, 230, 'PGE Demo',100,200);
     PopDemo      .Make(5,31,90,20,'Painter',LoaderWindow);
     Demo         .Make(5,53,90,20,'Demo'      ,LoaderWindow);
     Demo2        .Make(5,75,90,20,'Animation' ,LoaderWindow);
     Calc         .Make(5,97,90,20,'Calculator',LoaderWindow);
     CD           .Make(5,119,90,20,'CD Player',LoaderWindow);
     edit         .Make(5,141,90,20,'Editor'   ,LoaderWindow);
     SineWave     .Make(5,163,90,20,'Sine Wave'   ,LoaderWindow);
     CIFEditor    .Make(5,185,90,20,'CIF Editor'   ,LoaderWindow);
     quit          .Make(5,207,90,20,'Quit'    ,LoaderWindow);
     draw;
     evloop;
     killmouse;
     LoaderDesktop.VideoOff;
end.