unit Bitmap;
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

                    Image Support Module

}

interface

uses crt, graph, video, mousei,io;

type
    TIcon = object
          ico_x       : integer;
          ico_y       : integer;
          ico_lable   : string;
          ico_haslable: boolean;
          ico_isdblclk: boolean;
          ico_filename: string;

          constructor make(x,y:integer; icofile:string; txt:string; dblclick:boolean );

          procedure draw;
          procedure drag;
          procedure moveto(x,y:integer);
          function Pushed:boolean;
          destructor erase(backcol:integer);
    end;




implementation
uses pge;



destructor TIcon.erase(backcol:integer);
begin
     fillrectangle(ico_x,ico_y,ico_x+32,ico_y+32,backcol);
end;

procedure TIcon.moveto(x,y:integer);
begin
     ico_x:=x;
     ico_y:=y;
     TIcon.Draw;
end;
procedure TIcon.drag;
var mx,my,mt:word;
begin
     mx:=mousepx; my:=mousepy;
     while MouseButtonPressed=true do
     begin
     end;
     TIcon.moveto(ico_x-(mx-mousepx),ico_y-(my-mousepy))
end;
constructor TIcon.make(x,y:integer;icofile,txt:string;dblclick:boolean);
begin
     ico_x       :=x;
     ico_y       :=y;
     ico_lable   :=txt;
     if (length(txt) > 0) then ico_haslable:= true;
     ico_isdblclk:=dblclick;
     ico_filename:=icofile;
end;

function TIcon.Pushed:boolean;
var mbt,mdx,mdy:word;
    x1,y1:integer;

   begin
        x1:=ico_x+32;
        y1:=ico_y+32;

        if MouseButtonPressed=true then

        {what button}
        if mtir(ico_x,ico_y,x1,y1) then
         begin                           {if so return TRUE }
              pushed:=true;
         end;

   end;


procedure TIcon.Draw;

var
  r,rr :byte;
  f    :text;
  ox,oy,x,y,p,q  :integer;
  ch:char;

begin
  ox:=ico_x;oy:=ico_y;
  x:=ico_x; y:=ico_y;
  assign(f,ico_filename);
  {$I-} reset(f); {$I+}

  if ioresult =0 then
  begin
       for p :=1 to 766 do
       begin
            read(f,ch);q :=ord(ch);
            if (p >126) and (p <639) then
            begin
                 r :=q shr 4;rr :=q-r div 16;
                 putpixel(x,y,r);putpixel(x+1,y,rr);
                 inc(x,2);
                 if x =ox+32 then
                 begin
                      x :=ox;dec(y);
                 end;
            end;
       end;
    close(f);
  end;
end;


end.