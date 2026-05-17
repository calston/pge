unit advcrt;
interface
uses crt;


type
    FlyMenu=object
       y:integer;
       lists:array[1..50] of string;
       count,max:integer;
       constructor Create(x:integer);
       procedure Flyonleft;
       procedure Flyonright;
       procedure AddItem(s:string);
    end;
procedure Gather(txt:string;point:integer);
procedure TypeOn(txt:string);
procedure TypeOnXy(txt:string;x,y:integer);
procedure TypeOnColors(txt:string);
procedure FlyOnright(txt:string; start:integer);
procedure FlyOnLeft(txt:string; start:integer);
procedure FlyOffRight(txt:string; start:integer);
procedure FlyOffLeft(txt:string; start:integer);
procedure calibrate;
procedure BarH(w,len,c:integer);
procedure center(txt:string);
procedure idle(m:integer);{}
procedure bounceoff(s:string;posx,posy:integer);
procedure melt(s:string;x,y,d:integer);
procedure flicker(s:string;x,y,l:integer);
Procedure HLine(c:char);
function centers(txt:string):string;
function centerw(txt:string):integer;

implementation

procedure HLine;
var i:integer;
begin
     for i:=1 to 80 do
     write(c);

end;

constructor FlyMenu.Create;
begin
     y:=x;
end;

procedure FlyMenu.Flyonright;
var i,g:integer;
begin
     for i:= (80-max) downto max do
        begin
             for g:= 0 to count do
             begin
                  GotoXY(1,g+y);
                  Clreol;
                  Write(lists[g]:i);
             end;
             idle(5);
        end;
     writeln;
end;

procedure FlyMenu.Flyonleft;
var i,g:integer;
begin
     for i:= max to 75 do
        begin
             for g:= 0 to count do
             begin
                  GotoXY(1,g+y);
                  Clreol;
                  Write(lists[g]:i);
             end;
             idle(5);
        end;
     writeln;
end;

procedure FlyMenu.AddItem;
begin
     lists[count]:=s;
     inc(count);
     if length(s)>max then max:=length(s);
end;

procedure flicker(s:string;x,y,l:integer);
var i,g:integer;
begin
     for i:= 1to l do
     begin
          for g:= 1 to 15 do
          begin
               textcolor(g);
               gotoxy(x,y);
               write(s);
               idle(20);
          end
     end;
end;

procedure melt(s:string;x,y,d:integer);
var i,h,c,f,g:integer;
    chars:boolean;
begin
     randomize;
     write(s);
     while not(chars=true) do
     begin
          c:=random(length(s));
          if not(s[c]=' ') then
          begin
               inc(f);
               for i:= 1 to d do
               begin
                    gotoxy(c,i);
                    write(s[c]);
               end;
               s[c]:=' ';
               write(s);
               idle(20);
               clrscr;
          end;
          if f=length(s) then chars:=true;
     end;


end;

procedure bounceoff;
var i,dx,dy,x,y:integer;
begin
      i:=0;
      dx:=1;
      dy:=1;
      x:=posx;
      y:=posy;
      while (i=0) do
      begin
           if x<2 then dx:=1;
           if y<2 then dy:=1;
           if x>(80-length(s))then i:=1;
           if y>24 then dy:=-1;
           x:=x+dx;
           y:=y+dy;
           gotoxy(x,y);
           write(s);
           gotoxy(1,1);
           idle(30);
           clrscr;
      end;
end;

procedure idle(m:integer);
var j,t:integer;
    f,g,h:real;
begin

     for t:= 1 to m do
      for j:= 1 to 2000 do
      begin
           f:=g;
           g:=h;
           h:=t;
      end;
end;

procedure TypeOnColors;
var i,g,h:integer;
begin
     randomize;
     for i:= 1 to length(txt) do
     begin
          textcolor(random(15));
          write(txt[i]);
          if not (txt[i]=' ') then for g:= 1 to 2000 do sound(2000);
          nosound;
          idle(10);
     end;
end;

procedure TypeOn;
var i,g:integer;
begin
     for i:= 1 to length(txt) do
     begin
          write(txt[i]);
          if not (txt[i]=' ') then for g:= 1 to 2000 do sound(2000);
          nosound;
          idle(20);
     end;
end;
procedure TypeOnXY;
var i,g:integer;
begin
     gotoxy(x,y);
     for i:= 1 to length(txt) do
     begin
          write(txt[i]);
          if not (txt[i]=' ') then for g:= 1 to 2000 do sound(2000);
          nosound;
          idle(10);
     end;
end;

procedure FlyOffRight;
 var i:integer;
  begin
       for i:= (80-length(txt)) downto 1 do
        begin
             GotoXY(i,start);
             Clreol;
             Write(txt);
             idle(10);
        end;
        GotoXY(i,start);
        clreol;
        idle(10);
  end;
procedure FlyOffLeft(txt:string; start:integer);
 var i:integer;
  begin
       for i:= length(txt) to 80 do
        begin
             GotoXY(1,start);
             Clreol;
             Write(txt:i);
             idle(10);
        end;
        GotoXY(1,start);
        clreol;
        idle(10);
  end;

procedure FlyOnright;
 var i:integer;
  begin
       for i:= (80-length(txt)) downto length(txt) do
        begin
             GotoXY(1,start);
             Clreol;
             Write(txt:i);
             idle(10);
        end;
  end;

procedure FlyOnLeft;
 var i:integer;
  begin
       for i:= length(txt) to (80-length(txt)) do
        begin
             GotoXY(1,start);
             Clreol;
             Write(txt:i);
             idle(10);
        end;
  end;

procedure calibrate;
var i:integer;
begin
     for i:= 1 to 2000 do
     begin
          delay(0);

     end;

end;

procedure BarH(w,len,c:integer);
var d,i:integer;
begin
	gotoxy(1,w);
	textcolor(c);
	for i:= 1 to len do
	 write('Û');
   gotoxy(1,w);
end;

procedure center;
var d,s:integer;
    tmp1,tmp2:string;
begin
     d:=40-(length(txt) div 2);
     for s:= 1 to d do write(' ');
     writeln(txt);
end;

function centerw(txt:string):integer;
var d,s:integer;
begin
     d:=40-(length(txt) div 2);
     centerw:=d;
end;

function centers(txt:string):string;
var d,s:integer;
    sd:string;
begin
     d:=40-(length(txt) div 2);
     for s:= 1 to d do sd:=sd+' ';
     centers:=sd;

end;

procedure Gather(txt:string;point:integer);
var g,a,i,j:integer;
    c:char;
    temp:string;
begin
     g:=point;
     temp:='';
     for i:= 1 to length(txt) do
     begin
          c:=txt[i];
          if not(txt[i]=' ') then
          for a:= 80 downto length(temp) do
          begin
               gotoxy (1,g);
               write(txt[i]:a);
               gotoxy (1,g);
               write(temp);
               idle(1);
               clreol;
          end;

          temp:=temp+c;
     end;
     nosound;
     gotoxy (1,g);
     writeln(temp);
end;

begin


end.