program GUI;
uses {$I PGE.INC}
Var
    {DeskStuff}
     Desktop:TScreen;
     MyGUI:TGui;

    {DeskItems}
     Desk:TWin; {Fake Window}
     clock:TClock;
     MenuButton:TPCXButton;
     Ico:TCif;
     Menu:TPopup;

     TaskBar:TButton;

     running,done:boolean;

     ThisApp:TWin;
     Ok:TButton;
     Cancel:TButton;

     done1:boolean;

procedure DrawStuff;
begin
     retrace;
     TaskBar.Draw;
     clock.draw;
     menubutton.draw;
     ico.draw;
     killmouse;
     dispmouse;
     restore;
end;


procedure _Loop;
begin
     while done=false do
     begin
          if keypressed then if readkey=#27 then Done:=true;
          If MenuButton.Pushed=true then
           begin
                menu.popup(3,getmaxy-190);
                Menu.Destroy;
                If menu.clicknum=10 then Done:=true;

                DrawBackground;
                DrawStuff;
           end;
     end;
end;

var
  Int1CSave : Pointer;


begin

     DeskTop.init;
     DeskTop.VideoOn;
     {Create Desktop}
      Desk      .Make (0  ,0  ,getmaxx,getmaxy,'',0,0);
      clock     .make (getmaxx-94,getmaxy-25  ,Desk   ,12);
      MenuButton.make (2  ,getmaxy-26 ,75     ,23     ,'pge2.pcx',Desk);
      TaskBar   .make (0  ,getmaxy-28 ,getmaxx-1,26,''  ,Desk);
      Menu      .Make (100,200,Desk);

      ico.make(25,25,'pc.cif','Hello',desk);

      Menu.AddItem(0 ,'Run Command' );
      Menu.AddItem(1 ,'Set Alarm');
      Menu.AddItem(2 ,'Screen Saver');
      Menu.AddItem(3 ,Void          );
      Menu.AddItem(4 ,'PGE Editor'  );
      Menu.AddItem(5 ,'PGE Demo'    );
      Menu.AddItem(6 ,'Calculator'  );
      Menu.AddItem(7 ,'CD Player'   );
      Menu.AddItem(8 ,'Animation'   );
      Menu.AddItem(9 ,VOID          );
      Menu.AddItem(10,'Shutdown'    );

      DrawStuff;


      _loop;
      Desktop.videooff;

end.
