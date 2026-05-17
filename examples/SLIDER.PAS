uses {$I PGE.INC}
var
   Desktop:TScreen;
   Wind:TWin;
   Slider:TScrollBar;
   Val:TLable;
   list:Tlistbox;
   i:integer;
   c:char;
   ds:string;
   test:text;
   done:boolean;
   Line,tmp:Pchar;
procedure Draw;
begin
   Wind.draw;
   Slider.Draw;
   Val.Draw;
   list.draw;
end;

procedure MoveButtons;
begin
     slider.ParentMove(Wind);
     val.parentmove(wind);
     list.ParentMove(Wind);
end;

procedure EvLoop;
begin
     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if Wind.WindowClosed=true then done:=true;
          if Wind.moved=true then movebuttons;

          if Slider.Change=true then
          begin
               val.erase;
               Val.lable:=int2str(Slider.Value);
               val.draw;
          end;
          if list.change=true then;
     end;
end;

begin

     Desktop.Init;

     Desktop.VideoOn;

     Wind .Make(2,2,520,400,'Slider and Listbox Demo',100,100);

     Slider.Make(10,40,300,horizdir,2,10000,Wind);
     Val.Make(400,45,Blue,0,'2',Wind);
     list.make(10,60,wind.w_l-20,wind.w_h-70,wind);

     assign(test, 'D:\pascal\project1\help.txt');
     reset(test);

     while not Eof(test) do
     begin
          Readln(test, ds);
          Line:=StrPCopy(tmp, ds);
          List.add(line);
     end;

     Close(test);

     draw;
     evloop;
     Desktop.VideoOff;
end.