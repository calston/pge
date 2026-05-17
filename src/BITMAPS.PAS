unit Bitmaps;
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

                    Bitmap Support Module

}

interface

uses crt, video, mousei,io,vesa256;

type
    TIcon = object {This is tacky!, im working on a memory bitmap loader}
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


    Bitmap=pointer;

 procedure LoadBitmap(var bit:pointer;name:pchar);
 procedure EraseBitmap(var bit:pointer);
 procedure DrawBitmap(x,y:integer;bit:pointer);
 Procedure TileBitmap(x,y:integer;name:pchar;var bit:pointer);

implementation
uses pge;

Procedure TileBitmap;
var temp:pointer;
    w,h:integer;
    tx,ty:integer;
    dx,dy:integer;
begin
     {ok.. This nifty procedure will (hopefuly) tile a PCX.. read the
      specified size into another bitmap and keep it there.. or something}
     GetPCXImageSize(name,W,H);
     tx:=x div w;
     ty:=y div h;

     for dx:= 1 to tx do
      for dy:= 1 to ty do
      begin
           LoadPCXimageXY(name,(dx-1)*w,(dy-1)*h,0,true,true,true);
      end;
     bit:=AllocAndGetImage(0,0,x,y);
end;

procedure DrawBitmap;
begin
     PutImage(X,Y,bit,spriteblit);
end;

procedure Loadbitmap;
var w,h:integer;
begin
     LoadPCXimageXY(name,0,0,0,true,true,true);
     GetPCXImageSize(name,W,H);
     bit:=AllocAndGetImage(0,0,W,H);
end;

Procedure EraseBitmap;
begin
     ForgetImage(bit);
end;


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