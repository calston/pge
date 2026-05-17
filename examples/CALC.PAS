program calc;

uses {$I PGE.INC}
var
   MyGUI       :TGui;
   MyScreen    :TScreen;
   ncim,done   :boolean;
   CalcApp:TWin;

   b0, b1, b2, b3, b4, b5, b6, b7, b8, b9 : TButton;

   answer:TButton;

   plus, minus, divide, times :Tbutton;

   screen:TButton;
   clear :TButton;

   display:TLable;

   number1,number2,mem:real;

   opperator:integer;
   screennum:string;
   number:real;
   tmp,tmp1:integer;

Procedure _move;
begin

   b0     . ParentMove(calcapp);
   b1     . ParentMove(calcapp);
   b2     . ParentMove(calcapp);
   b3     . ParentMove(calcapp);
   b4     . ParentMove(calcapp);
   b5     . ParentMove(calcapp);
   b6     . ParentMove(calcapp);
   b7     . ParentMove(calcapp);
   b8     . ParentMove(calcapp);
   b9     . ParentMove(calcapp);

   answer . ParentMove(calcapp);

   plus   . ParentMove(calcapp);
   minus  . ParentMove(calcapp);
   divide . ParentMove(calcapp);
   times  . ParentMove(calcapp);

   screen . ParentMove(calcapp);

   display. ParentMove(calcapp);
   clear .ParentMove(calcapp);


end;

procedure _update;
begin
     if length(screennum)<20 then
     begin
     display.Erase;
     display.lable:=screennum;
     display.draw;
     end;
end;

Procedure _draw;
begin

   CalcApp.draw;

   b0     .draw;
   b1     .draw;
   b2     .draw;
   b3     .draw;
   b4     .draw;
   b5     .draw;
   b6     .draw;
   b7     .draw;
   b8     .draw;
   b9     .draw;

   answer .draw;
   plus   .draw;
   minus  .draw;
   divide .draw;
   times  .draw;

   screen .draw;

   display.draw;
   clear .draw;

end;

Procedure _Make;
begin
   CalcApp.Make (20,20,215,200,'Calculator',200,200);

   b0     .Make (128 ,152, 40, 40,'0',CalcApp);
   clear  .Make (180,30,30,30,'CA',calcapp);

   b1     .Make (5  , 70, 40, 40, '1',CalcApp);
   b2     .Make (46 , 70, 40, 40, '2',CalcApp);
   b3     .Make (87 , 70, 40, 40, '3',CalcApp);

   b4     .Make (5  , 111, 40, 40,'4',CalcApp);
   b5     .Make (46 , 111, 40, 40,'5',CalcApp);
   b6     .Make (87 , 111, 40, 40,'6',CalcApp);

   b7     .Make (5  , 152, 40, 40,'7',CalcApp);
   b8     .Make (46 , 152, 40, 40,'8',CalcApp);
   b9     .Make (87 , 152, 40, 40,'9',CalcApp);

   plus   .Make (128  , 70 , 40, 40,'+',CalcApp);
   minus  .Make (169  , 70 , 40, 40,'-',CalcApp);
   divide .Make (128  , 111, 40, 40,'ö',CalcApp);
   times  .Make (169  , 111, 40, 40,'x',CalcApp);
   answer .Make (169  , 152, 40, 40,'=',CalcApp);

   screen .Make (5,30,168,30,'',CalcApp);

   screen.ispushed:=true;

   display.Make (10,37,Blue,0,'0',CalcApp);

end;

procedure Convert;
var tmp:string;
    i:integer;
    d:integer;
begin
     {find out how many digits after the decimel place}
     tmp:=realtostr(frac(number),10,10);

     {Count away trailing 0's untill we find the last real digit}
     i:=9;{start at the end}
     while (tmp[i]='0') do
     begin
          i:=i-1;
     end;
     d:=i-2; {string has [0][.] in the begining so we take that off}

     if frac(number)<>0 then
     screennum:=realtostr(number,d,d)

     else
         screennum:=realtostr(number,0,0);

     mem:=number;
end;

Procedure _calc;
begin
     val(screennum, tmp, tmp1);
     number2:=tmp;

     if opperator=1 then {add}
     begin
          number:=number1+number2;
          convert;
     end;

     if opperator=2 then {minus}
     begin
          number:=number1-number2;
          convert;
     end;

     if opperator=3 then {div}
     begin
          if number2 = 0 then
                screennum:='Can''t Divide by 0!'
          else
           begin
                number:=number1 / number2;
                convert;
           end;
     end;

     if opperator=4 then {mul}
     begin
          number:=number1*number2;
          convert;
     end;

     _update;

{     number1:=0;
     number2:=0;}
end;



procedure _nextnum;
begin
     val(screennum, tmp, tmp1);
     number1:=tmp;
     _calc;
     screennum:='';
     _update;
end;

Procedure _loop;
begin

     while done=false do
     begin
          if clear.pushed=true then
          begin
               display.Erase;
               display.lable:='0';
               display.draw;
               screennum:='';
               number1:=0;
               number2:=0;
               ncim:=false;
               _update;
          end;

          if calcapp.WindowClosed=true then done:=true;

          if calcapp.moved=true then
          begin
               _move;
          end;

          if keypressed then if readkey=#27 then done:=true;

          if b0.pushed=true then
          begin
          screennum:=screennum+'0';
          _update;
          end;

          if b1.pushed=true then
          begin
          screennum:=screennum+'1';
          _update;
          end;

          if b2.pushed=true then
          begin
          screennum:=screennum+'2';
          _update;
          end;

          if b3.pushed=true then
          begin
          screennum:=screennum+'3';
          _update;
          end;

          if b4.pushed=true then
          begin
          screennum:=screennum+'4';
          _update;
          end;

          if b5.pushed=true then
          begin
          screennum:=screennum+'5';
          _update;
          end;

          if b6.pushed=true then
          begin
          screennum:=screennum+'6';
          _update;
          end;

          if b7.pushed=true then
          begin
          screennum:=screennum+'7';
          _update;
          end;

          if b8.pushed=true then
          begin
          screennum:=screennum+'8';
          _update;
          end;

          if b9.pushed=true then
          begin
          screennum:=screennum+'9';
          _update;
          end;

          if plus.pushed=true then
          begin
               opperator:=1;

               _nextnum;

          end;

          if minus.pushed=true then
          begin
               opperator:=2;

               _nextnum;

          end;

          if divide.pushed=true then
          begin
               opperator:=3;

               _nextnum;
          end;

          if times.pushed=true then
          begin
               opperator:=4;
               _nextnum;
          end;

          if answer.pushed=true then
          begin
               _calc;
               ncim:=false;
          end;


     end;

end;

begin
MyScreen.Init;
MyScreen.VideoOn;
_make;
_Draw;
_loop;

end.

{ item list}
{
   CalcApp.

   b0     .
   b1     .
   b2     .
   b3     .
   b4     .
   b5     .
   b6     .
   b7     .
   b8     .
   b9     .

   plus   .
   minus  .
   divide .
   times  .

   exit   .

   screen .

   display.

}
