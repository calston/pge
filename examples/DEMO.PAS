{
   The PGE Demo
}
uses {$I PGE.INC}


Var
   MyGui   :TGui;
   MyScreen:TScreen;
   DemoApp:TWin;
   OtherApp:TWin;

   TestBTN1:TButton;
   TestBTN2:TButton;
   TimerBtn:TButton;

   Timer1:TTimer;

   TestBar1:TProgress;
   TestBar2:TProgress;

   TestText1:TLable;
   TestText2:TLable;
   TestText3:TLable;

   Scroll:TScrollBar;

   clock:TClock;

   Edit1    :TEdit;

   TestChkBox:TChkBox;

   onum,num,lnum:longint;
   mynum:integer;
   running,done:boolean;


Procedure Make_;
begin
   DemoApp .Make(10,10,300,200,'PGE Demo',100,100);

   TestBTN1.Make(10,28,100,25,'Stop'   ,DemoApp);
   TestBTN2.Make(10,55,100,25,'Start'  ,DemoApp);
   TimerBtn.Make(150,160,100,25,'Timer',DemoApp);

   Timer1.Make(False,10);

   TestBar1 .Make(10,100,200,15,100,lightred,horizdir,DemoApp);
   TestBar2 .Make(220,50,25,100,100,lightblue,vertdir,DemoApp);

   TestText1.Make(10,155,red,0,'0%',DemoApp);
   TestText2.Make(50,155,red,0,'000',DemoApp);
   TestText3.Make(10,139,darkgray,0,'Text Here',DemoApp);

   TestChkBox.Make(10,170,'A Box',DemoApp);

   Edit1.Make( 92, 135 , 100,18,DemoApp);

   Scroll.Make(10,82,150,horizDir,50,100,DemoApp);

   clock.make(125,30,DemoApp,12);


end;

Procedure Draw_;
begin
   DemoApp   . Draw;
   TestBTN1  . Draw;
   TestBTN2  . Draw;
   TimerBtn  . Draw;
   TestBar1  . Draw;
   TestBar2  . Draw;
   TestText1 . Draw;
   TestText2 . Draw;
   TestText3 . Draw;
   TestChkBox. Draw;
   Scroll    .Draw;
   Edit1     .Draw;
   clock     .draw;
end;

Procedure ParentMove_;
begin
   TestBTN1 . ParentMove(DemoApp);
   TestBTN2 . ParentMove(DemoApp);
   TimerBtn . ParentMove(DemoApp);
   TestBar1 . ParentMove(DemoApp);
   TestBar2 . ParentMove(DemoApp);
   TestText1. ParentMove(DemoApp);
   TestText2. ParentMove(DemoApp);
   TestText3. ParentMove(DemoApp);
   TestChkBox. ParentMove(DemoApp);
   scroll.ParentMove(DemoApp);
   Edit1.ParentMove(DemoApp);
   clock.ParentMove(demoApp);

end;

Procedure EventLoop;
begin
     onum:=1;
     while done=false do
      begin

           if DemoApp.WindowClosed=true then done:=true;
           if DemoApp.Moved=true then ParentMove_;
           if DemoApp.resize=true then ParentMove_;

           if TestChkBox.Pushed=true then ;


           if TestBTN1.Pushed=true then begin Running:=false; end;

           if TestBTN2.Pushed=true then Running:=true ;

           If (TimerBtn.Pushed=true) then Timer1.Activate;

           if Edit1.Click then;

           if keypressed then if readkey=#27 then done:=true;

           If Timer1.Alarm=true then
              begin
                   Sound(1000);
                   wait(100);
                   Nosound;
              end;

           if Scroll.Change=true then
           begin
                TestBar2.Update(Scroll.Position);
                TestBar1.Update(Scroll.Position);
           end;

           if running=true then
           begin

                lnum:=lnum+1;

                if lnum=99 then
                begin
                     lnum:=0;
                end;

                if lnum=2 then
                begin
                     num:=num+onum;
                     TestBar1.Update(num);
                     if Edit1.Numeric > 0 then
                          TestBar1.Color:=Edit1.Numeric;


                     if TestChkBox.IsCheck=true then
                     begin
                          TestBar1.Color:=TestBar1.Color+1;
                          if TestBar1.Color=15 then TestBar1.Color:=1;

                     end;
                end;
                if num=100 then inc(mynum);

                TestBar2.Update(lnum);

                TestText1.Lable:=(inttostr(num))+'%';
                TestText1.Erase;
                TestText1.Draw;

                TestText2.Lable:=( inttostr({(}lnum*2){div 200)*100) });
                TestText2.Erase;
                TestText2.Draw;


                if (num=100) then onum:=-1;
                if (num=1) then onum:=1;
           end;
           clock.update;

      end;
end;

begin
myscreen.init;
myscreen.videoon;
Make_;
Draw_;
EventLoop;


end.

{ Object List }
{
   DemoApp . ;
   TestBTN1. ;
   TestBTN2. ;
   TestBar . ;
   TestText. ;


}