unit xpge;
{

                          .       .
                         / `.   .' \
                 .---.  <    > <    >  .---.
                 |    \  \ - ~ ~ - /  /    |
                  ~-..-~             ~-..-~
              \~~~\.'                    `./~~~/
    .-~~^-.    \__/                        \__/
  .'  O    \     /               /       \  \
 (_____,    `._.'               |         )  \/~~~/
  `----.          /       )     |        /    \__/
        `-.      |       /      |       /      `. ,~~|
            ~-.__|      /_ - ~ ^|      /- _      `..-'   :  :
                 |     /        |     /     ~-.     `-. _||_||_
                .|_____|       .|_____|         ~ - . _ _ _ _ _>

                           The
                Pascal Graphical Environment

                PGE Extended Controls Module

}
interface

uses vesa256,fx,video,pge,crt,mousei,dos;

const void='ID1015';

type PClock=^TClock;
     TClock=object(TWin)

           x,y:integer;
           L,H:integer;
           ox,oy:integer;

           clocktype:integer;

           ho,m,s,s100:word;
           th,tm,ts:word;
           ActivE:boolean;
           alarmed:boolean;

           constructor make(ix,iy:integer;parent:twin;WhatClock:byte);
           procedure Draw; Virtual;
           procedure ParentMove(win:twin); Virtual;
           Procedure Update;
           procedure NewTimer(ih,im,is:word);
           function  Alarm:boolean;
           destructor destroy;
     end;

     TTimer=object(TWin)
           Active:Boolean;
           LastT:Integer;
           AlarmT:integer;
           firstchk:boolean;
           Constructor Make(A:boolean;TimeI:integer);
           procedure Activate;
           Function Alarm:Boolean;
           Destructor Destroy;
     end;

     function WordToStr(words:word):string;
     procedure idle(l:integer);
     function OnTick(s:integer):boolean;

implementation

function OnTick;
var h2,m2,s2,s200:word;
begin
     gettime(h2,m2,s2,s200);
     if s200>s then ontick:=true
     else ontick:=false;
end;


function WordToStr(words:word):string;
var ws:word;
    int:longint;
    outs:string;
begin
     ws:=words;
     int:=ws;
     Str(Int, outs);
     WordToStr := outs;
end;

procedure Idle(l:integer);
var S:word;
    h2,m2,s2,s200:word;
begin
     gettime(h2,m2,s2,s200);
     s:=s2+l;
     if s>60 then s:=s-60;
     while not (s2=s+l) do
     begin
        gettime(h2,m2,s2,s200);
     end;
end;

{
nelson 0824042134
}
Constructor TTimer.Make;
 Var h,m,s,ss:word;
 begin
      Active:=A;
      AlarmT:=TimeI;
      GetTime(h,m,s,ss);
      if s=59 then s:=0;
      LastT:=S;
      firstchk:=true;
 end;

procedure TTimer.Activate;
Var h,m,s,ss:word;
 begin
      Active:=True;
      firstchk:=true;
      GetTime(h,m,s,ss);
      if s=59 then s:=0;
      LastT:=S;
 end;

Function TTimer.Alarm:Boolean;
 Var h,m,s,ss:word;
 begin

      If Active=true then
      Begin
           GetTime(h,m,s,ss);
           if firstchk=true then lastt:=s;

           if s=(LastT+AlarmT) then
              Begin
                   Alarm:=True;
                   LastT:=S;
              end;
           firstchk:=false;
      end;
 end;

Destructor TTimer.Destroy;
 begin
      {Nothing Much To Do Here}
      Active:=false;
 end;


constructor TClock.make;
 begin
      ClockType:=WhatClock;
      x :=parent.w_x+ix;
      y :=parent.w_y+iy;
      ox:=ix;
      oy:=iy;
      l:=90;
      h:=20;
 end;

procedure TClock.ParentMove;
begin
      x:=win.w_x+ox;
      y:=win.w_y+oy;
      Tclock.Draw;
end;

procedure TClock.Draw;
Var midy,Midx:integer;
    Hours,Seconds,Minutes:string;
    OutStr,PMAM:string;
begin
     KillMouse;
     gettime(ho,m,s,s100);
     fillrectangle(x,y,x+l,y+h,BTNFace);
     bevel(x,y,x+l,y+h,DarkShad,LightShad);

     Minutes:=wordtostr(m);
     Seconds:=wordtostr(s);

     if clocktype=12 then
        begin
             PMAM:='AM';
             if ho>12 then
               begin
                    ho:=ho-12;
                    PMAM:='PM';
               end;
        end;

     Hours:=wordtostr(ho);

     if m<10 then Minutes:='0'+Minutes;
     if s<10 then seconds:='0'+seconds;

     outstr:=''+Hours+':'+Minutes+'-'+Seconds+' '+PMAM;

     midx      :=  (x + (l div 2)) - ( (length(outstr) * 8) div 2);

     midy      :=  (y + (h div 2)) - 4;

     moveto (midx, midy);

     setcolor(BTNFont);
     outtext(outstr);

     restore;
     DispMouse;
end;

procedure TClock.NewTimer(ih,im,is:word);
begin
     alarmed:=false;
     th:=ih;
     tm:=im;
     ts:=is;
end;

function  TClock.Alarm:boolean;
begin
     if (alarmed=false) and (active=true) then
     if (th=ho) and (tm=m) then
     if (ts=s) then
     begin
          alarm:=true;
          alarmed:=true;
     end;
end;

procedure TClock.Update;
var h2,m2,s2,s200:word;
begin
     gettime(h2,m2,s2,s200);
     if s2=s then exit; {Dont change if time seconds hasnt changed}

     ho:=h2;
     m:=m2;
     s:=s2;
     s100:=s200;
     Tclock.Draw;
end;


destructor TClock.destroy;
 begin
      killmouse;
      DrawBackground;
      dispmouse;
 end;

end.