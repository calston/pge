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

                   List Box Control Module

}
unit ListBox;

interface

uses crt,vesa256,pge,fx,mousei,video,strings;


type

    LineList=Array[0..60] of pchar;


    PListBox=^TListBox;
    TListBox=Object(TWin)

       x,y,l,h :integer;
       ox,oy   :integer;

       Lines   :LineList;
       num     :integer;
       Position:integer;

       Slide:TScrollbar;


       Constructor Make (rx,ry,rl,rh:Integer; parent:TWin);
       Procedure  Draw;                         Virtual;
       Procedure  ReDraw;                       Virtual;
       Procedure  Empty;                       Virtual;
       Procedure  SelectItem;                   Virtual;
       Procedure  Add(texts:pchar);
       function   Change:Boolean;               Virtual;
       function   SelectedText:String;          Virtual;
       Procedure  ParentMove(Parent:TWin);      Virtual;

       Destructor  Destroy;
    end;

Implementation

{START OF CODE}

  Constructor TListBox.Make;
     var i:integer;
     Begin
          ox:=rx;
          oy:=ry;
          x:=rx+Parent.w_x;
          y:=ry+Parent.w_y;
          l:=rl;
          h:=rh;
          Slide.Make(rx+l-15,ry,h,vertdir,0,1,parent);
          slide.max:=num;
          slide.increment:=num;
     end;

  Procedure TListBox.Draw;
  var i,yi,temp:integer;
      f:string;
     Begin
          killmouse;
          {fillrectangle(x+1,y+1,x+l-1,y+h-1,wincolor);}
          Bevel(x,y,x+l-15,y+h,darkshad,lightshad);
          Slide.Draw;
          killmouse;
          yi:=0;
          SetViewPort(x+1, y+1, x+l-16, y+h-1, ClipOn);
          setcolor(btnfont);
          temp:=(position+(h div 12)-1);

          for i:=position to temp do
          begin
               outtextxy(2,yi*12,StrPas(Lines[i]));
               inc(yi);
          end;
          SetViewPort(0, 0, getmaxx, getmaxy, ClipOff);
          dispmouse;
     end;

  Procedure TListBox.Empty;
  var i,yi,temp:integer;
     Begin
          yi:=0;
          fillrectangle(x+1, y+1, x+l-16, y+h-1,btnface);
     end;

  Procedure TListBox.ReDraw;
  var i,yi,temp:integer;
      f:string;
     Begin
          {fillrectangle(x+1,y+1,x+l-16,y+h-1,wincolor);}
          {Slide.Draw;}
          yi:=0;
          SetViewPort(x+1, y+1, x+l-16, y+h-1, ClipOn);
          setcolor(btnfont);
          temp:=(position+(h div 12) -1);
          for i:=position to temp do
          begin
               outtextxy(2,yi*12,StrPas(Lines[i]));
               inc(yi);
          end;
          SetViewPort(0, 0, getmaxx, getmaxy, ClipOff);
     end;


  Procedure TListBox.SelectItem;
     Begin

     end;

  Procedure TListBox.Add;
     var p:pchar;
     Begin
          inc(num);
          slide.max:=num;
          Lines[num]:=texts;
          slide.increment:=8;
     end;

  function TListBox.Change:Boolean;
     Begin
          if slide.change=true then
          begin
               tlistbox.empty;
               position:=slide.value;
               tlistbox.redraw;
               Change:=true;
          end;
     end;

  function TListBox.SelectedText:String;
     Begin

     end;

  Procedure TListBox.ParentMove;
     Begin
          x:=ox+Parent.w_x;
          y:=oy+Parent.w_y;
          slide.x:= slide.orx + parent.w_x;{x is relevent to position in parent}
          slide.y:= slide.ory + parent.w_y;{y "..." }
          TListbox.draw;
     end;

  Destructor TListBox.Destroy;
     Begin
          fillrectangle(x,y,x+l,y+h,wincolor)
     end;

{END OF CODE}

end.
