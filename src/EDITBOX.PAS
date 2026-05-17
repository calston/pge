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

                 Input Field Control Module

}
unit EditBox;
interface



uses crt,vesa256,pge,fx,mousei,objects,video;

const {InputColor= BTNFace;
      ETextColor =Blue;}
      EditCursor={'³';}'_';

var j,f,k:Word;
    NextBox,Certain:boolean;

type
   { PMemo=^TMemo;
    TMemo=Object(TWin)
       x,y,l,h:integer;
       ox,oy  :integer;

       Contents:string;
       BlankOut:Boolean;
       font    :Word;
       Numeric:longint;

       Constructor Make (rx,ry,rl,rh:Integer; parent:TWin);
       Procedure  GetInput;                     Virtual;
       Procedure  Draw;                         Virtual;
       Procedure  ParentMove(Parent:TWin);      Virtual;
       Procedure  Clear;                        Virtual;
       Function   Click:Boolean;                Virtual;
       Function   ReadText:String;
       Destructor  Destroy;
    end;                   }

    PEdit=^TEdit;
    TEdit=Object(TWin)
       x,y,l,h:integer;
       ox,oy  :integer;

       Contents:string;
       BlankOut:Boolean;
       font    :Word;
       Numeric:longint;
       Host:TWin;
       masked:boolean;

       Constructor Make (rx,ry,rl,rh:Integer; parent:TWin);
       Procedure  GetInput;                     Virtual;
       Procedure  Draw;                         Virtual;
       Procedure  ParentMove(Parent:TWin);      Virtual;
       Procedure  Clear;                        Virtual;
       Procedure  Mask;
       Function   Click:Boolean;                Virtual;
       Function   ReadText:String;
       function   ReadNum:integer;
       Destructor  Destroy;
    end;

Implementation



  Constructor TEdit.Make;
     Begin
          ox:=rx;
          oy:=ry;
          x:=rx+Parent.w_x;
          y:=ry+Parent.w_y;
          l:=rl;
          h:=rh;
          Contents:='';
          Numeric:=0;
          WinCopy(parent,host);
          Masked:=false;
     end;

  Procedure TEdit.Mask;
   begin
        Masked:=true;
   end;

  Procedure  TEdit.Draw;
     var i:integer; S:String;
     Begin
          Host.DrawModeOn;
          KillMouse;
          FillRectangle(x,y,x+l,y+h,BTNFace);

          Bevel(x,y,x+l,y+h,DarkShad,LightShad);
          s:='';
          setcolor(BtnFont);

          if masked=false then OutTextXy(x+3,y+4,Contents);
          if Masked=true then
          begin
               for i:= 1 to length(Contents) do
               begin
                    s:=s+'*';
               end;
               OutTextXy(x+3,y+4,s);
          end;
          Host.DrawModeOff;
          DispMouse;
     end;

{Its messy but it works realy well :) Serious hack }

  procedure  TEdit.GetInput;
  var i :integer;
      c : Char;
      S,t :string;
      loop:Boolean;
      Max:integer;
      x1,y1,posi:integer;
  procedure drawText;
  var i:integer;
  begin
       setcolor(BtnFont);
       if masked=false then OutTextXy(x+3,y+4,Contents);
       if Masked=true then
       begin
            t:='';
            for i:= 1 to length(Contents) do
            begin
                 t:=t+'*';
            end;
            OutTextXy(x+3,y+4,t);
       end;
  end;


   begin
        NextBox:=false;
        certain:=false;
        s:=contents;
        posi:=length(s);
        tedit.clear;
        killmouse;
        {outtextxy(x+3,y+4,s+EditCursor);}
        drawtext;
        OutTextXy(x+3+(8*posi),y+4,EditCursor);
        dispmouse;
        loop:=true;
        t:='';
        while loop=true do
        begin
             MoveMouse;

             if MouseButtonPressed=true then
               if mtir(x,y,x+l,y+h)=false then
                begin
                     killmouse;
                     Tedit.clear;
                     {outtextxy(x+3,y+4,s);}
                     Contents:=s;
                     DrawText;
                     Val(contents,numeric,j);
                     dispmouse;
                     Exit;
                end;

             if KeyPressed then
             begin
                  c:=readkey;
                  if (c=#26) or (c=#25) then exit;
                  if (c=#24) or (c=#23) then exit;

                  if (c=#9) then
                  begin
                     KillMouse;
                     Tedit.clear;
                     {outtextxy(x+3,y+4,s);}
                     NextBox:=true;
                     Contents:=s;
                     DrawText;
                     Val(contents,numeric,j);
                     DispMouse;
                     Exit;
                  end;

                  if (c=#13) or (c=#27) then
                  begin
                     KillMouse;
                     Tedit.clear;
                     {outtextxy(x+3,y+4,s);}
                     Contents:=s;
                     DrawText;
                     if c=#13 then certain:=true;
                     Val(contents,numeric,j);
                     DispMouse;
                     Exit;
                  end;

                  if c=#8 then
                  begin
                       if (length(s)>0) and (posi>0) then
                       begin
                            Delete(s,posi,1);
                            dec(posi);
                            Tedit.clear;
                       end;
                  end
                  else
                  If C=#0 then
                  begin
                       c:= Readkey;
                       if (ord(c)=75) then
                       begin
                            if (posi>0) then dec(posi) {left}
                       end
                       else
                       if (ord(c)=77) then
                       begin
                            if (posi<length(S)) then inc(posi) {left}
                       end
                       else

                       if (ord(c)=83) then {Delete}
                       begin
                            Delete(s,posi+1,1);
                       end
                       else
                       if (ord(c)=71) then {Home}
                       begin
                            posi:=0;
                       end
                       else
                       if (ord(c)=79) then {End}
                       begin
                            posi:=length(s);
                       end;
                  end
                  else
                  begin
                       {s:=s+c;}
                       inc(posi);
                       insert(c,s,posi);

                       if ((length(s)*8) > (l-12)) then
                       begin
                         Delete(s,length(s),1);
                         dec(posi);
                       end;
                  end;

                  killmouse;
                  tedit.clear;
                  setcolor(BtnFont);
                  {outtextxy(x+3,y+4,s+EditCursor);}
                  if masked=false then OutTextXy(x+3,y+4,s);
                  if Masked=true then
                  begin
                       t:='';
                       for i:= 1 to length(s) do
                       begin
                            t:=t+'*';
                       end;
                       OutTextXy(x+3,y+4,t);
                  end;

                  OutTextXy(x+3+(8*posi),y+4,EditCursor);

                  dispmouse;
              end;
        end;
        dispmouse;
        Val(s,numeric,j);
        Contents:=s;
        s:='';
     end;
  Procedure  TEdit.ParentMove;
     Begin
          x:=ox+Parent.w_x;
          y:=oy+Parent.w_y;
          WinCopy(parent,host);
          Self.Draw;
     end;

  Function   TEdit.Click:Boolean;
  var mdx,mdy,mbt:word;
      s:string;
     Begin
          if MouseButtonPressed=true then
            if mtir(x+2,y+2,x+l-2,y+h-2) = true then
            begin
                 Click:=True;
                 TEdit.GetInput;
                 Val(contents,numeric,j);
            end;

     end;

  Function   TEdit.ReadText:String;
     Begin
          ReadText:=Contents;
     end;
  Function   TEdit.ReadNum:integer;
     Begin
          ReadNum:=numeric;
     end;
  procedure  TEdit.Clear;
     BEgin
          FillRectangle(x+1,y+1,x+l-1,y+h-1,BTNFace);
     end;

  Destructor  TEdit.Destroy;
     Begin

     end;

end.
