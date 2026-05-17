{
   A Cool CD Player

   I like it a lot!
}
{
PCX Button Loading takes an unfortunatly long amount of time...

Does anyone know if it is posible to read a PCX file into memory
with out drawing it first?

}

uses cdaudio,{$I PGE.INC}

var
   CdPlayerApp:TGUi;
   Screen     :TScreen;
   eject_btn  : TPCXButton; { Buttons}
   play_btn   : TPCXButton;
   stop_btn   : TPCXButton;
   pause_btn  : TPCXButton;
   next_btn   : TPCXButton;
   back_btn   : TPCXButton;

   vols       : TScrollBar;

   volumedisp :Tprogress; {Volume Progres bar}
   level      :Tprogress;

   cdplayer   :TWin; {Main Window}
   monitor    :TWin; {Monitor Window}

   My_Lable   :TLable;
   track      :TLable;
   Time       :TLable;

   done       :boolean; {Loop control}

   tracknum   :longint;

   curr_track:byte; {current track}
   vol    :byte;    {Volume level}

begin
     screen.Init;
     screen.VideoOn;
     CDPlayer .Make(10 ,10 ,195,120,'PGE CDPlayer',180,110);

     {Create Buttons}
     back_btn .Make(10 ,85,25 ,20 ,'.\CDPlayer\back.pcx' ,CDPlayer);
     play_btn .Make(40 ,85,25 ,20 ,'.\CDPlayer\play.pcx' ,CDPlayer);
     stop_btn .Make(70 ,85,25 ,20 ,'.\CDPlayer\stop.pcx' ,CDPlayer);
     pause_btn.Make(100 ,85,25 ,20 ,'.\CDPlayer\pause.pcx' ,CDPlayer);
     eject_btn.Make(130 ,85,25 ,20 ,'.\CDPlayer\eject.pcx' ,CDPlayer);
     next_btn .Make(160,85,25 ,20 ,'.\CDPlayer\next.pcx'    ,CDPlayer);
     {Create volume progress bar}
     VolumeDisp.make(10,52,175,20,256,blue,horizdir,CDPlayer);
     vol := audvolume;
     VolumeDisp.pposition:=vol;
     VolumeDisp.Draw;
     level     .make(10,30,150,10,10,green,horizdir,monitor);
     {Scroll BArs YAY!!!}
     VolS.Make(10,30,175,horizdir,vol,254,CDPlayer);
    {Draw items}
     CDPlayer .Draw;
     eject_btn.Draw;
     play_btn .Draw;
     stop_btn .Draw;
     pause_btn.Draw;
     next_btn .Draw;
     back_btn .Draw;
     VolS     .Draw;
     volumedisp.draw;

while done=false do
begin
     if DrvBusy=true then
     begin
     end;

     if keypressed then if readkey=#27 then done:=true; {Exit on escape}

     if Vols.Change=true then
     begin
          vol:=Vols.Value;
          setvolume(vol);
          VolumeDisp.Update(vol);
     end;

     if CDPlayer.WindowClosed=true then done:=true; {Destroy loop}

     {CD Player window}
     if CDPlayer.Moved=true then
     begin
          {Redraw child items}
           eject_btn.ParentMove(CDPlayer);
           play_btn .ParentMove(CDPlayer);
           stop_btn .ParentMove(CDPlayer);
           pause_btn.ParentMove(CDPlayer);
           next_btn .ParentMove(CDPlayer);
           back_btn .ParentMove(CDPlayer);
           vols   .ParentMove(CDPlayer);
           VolumeDisp.ParentMove(CDPlayer);
     end;
     if CDPlayer.Resize=true then
     begin
          {Redraw child items}
          eject_btn.ParentMove(CDPlayer);
           play_btn .ParentMove(CDPlayer);
           stop_btn .ParentMove(CDPlayer);
           pause_btn.ParentMove(CDPlayer);
           next_btn .ParentMove(CDPlayer);
           back_btn .ParentMove(CDPlayer);
           vols   .ParentMove(CDPlayer);

           VolumeDisp.ParentMove(CDPlayer);
     end;


     {Eject button}
     if eject_btn.Pushed=true then
        begin
             if NoDisc=true then EjectDoor;
             if DoorOpen then InsertDoor else EjectDoor; {if tray is out push it in else eject}
        end;

     {Play button}
     if play_btn .Pushed=true then
        begin
             curr_track:=1;
             if NoDisc=false then  {If there is no disk then ignore button}
             if DrvBusy=false then PlayTrack(curr_track); {if already playing then ignore button else start playing}
        end;

     {Stop button}
     if stop_btn .Pushed=true then
        begin
             curr_track:=1;  {reset current track to beging}
             PauseAudio;     {Pause cd player (interface has no stop)}
        end;

     {Pause button}
     if pause_btn.Pushed=true then
        begin
             {if it is paused then resume else pause audio}
             if InPause=true then ResumeAudio else PauseAudio;
        end;

     {Next button}
     if next_btn .Pushed=true then
        begin
             curr_track:=curr_track+1; {increment track}
             PlayNextTrk               {play next}
        end;

     {Back button}
     if back_btn .Pushed=true then
        begin

             curr_track:=curr_track -1;{decrement track}
             PlayPrevTrk;              {play previous track}
        end;
end;

end.


{Thats it! Simple eh? Enjoy!}
