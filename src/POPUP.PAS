unit popup;
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

                     Pop-Up Menu Module

}
interface

uses vesa256,fx,video,pge,crt,mousei;

const void='ID1015';
      ItemHT=15;

type PPopup=^TPopup;
     TPopup=object(TWin)
           x,y:integer;
           L,H:integer;
           entries:integer;
           ClickNum:integer;
           lines:array[0..25] of string;
           highlight:integer;

           constructor make(il,ih:integer;parent:twin);
           procedure Draw; Virtual;
           procedure redraw; virtual;
           procedure AddItem(id:integer;Name:string);Virtual;
           procedure SelectItem(i:integer);
           procedure RedrawItem(i:integer);
           procedure Popup(ix,iy:integer);
           function Open(parent:twin):boolean;Virtual;
           function ItemClick(parent:twin):integer;        Virtual;
           destructor destroy;
     end;

     PMenu=^TMenu;
     TMenu=object(TWin)
           bx,by:integer;
           bL,bH:integer;
           x,y:integer;
           ox:integer;
           L,H:integer;
           name:string;
           entries:integer;
           ClickNum:integer;
           lines:array[0..25] of string;
           highlight:integer;
           click:boolean;

           constructor make(ix,il:integer;namei:string;var parent:twin);
           procedure DrawBox; Virtual;
           procedure Draw; Virtual;
           procedure AddItem(id:integer;iName:string);Virtual;
           procedure SelectItem(i:integer);
           procedure RedrawItem(i:integer);
           procedure ParentMove(var win:twin);
           function Open:boolean;Virtual;
           function ItemClick(var parent:twin):integer;        Virtual;
           destructor destroy;
     end;


implementation

constructor TMenu.make;
 begin
      name:=namei;
      l:=il;
      bx :=parent.w_x+ix;
      ox:=ix;
      by :=parent.w_y+30;
      bl :=(length(name)*8)+16;
      bh :=15;
      click:=false;
 end;

procedure TMenu.ParentMove;
begin
      bx :=win.w_x+ox;
      by :=win.w_y+30;
      Tmenu.Draw;
end;

procedure TMenu.Draw;
Var midy,Midx:integer;
begin
     KillMouse;
     if click=true then
      begin
	   fillRectangle(Bx,By,Bx+Bl,By+Bh,MenuOn);
           bevel(bx,by,bx+bl,by+bh,darkshad,lightshad);
      end
     else
      begin
           fillRectangle(Bx,By,Bx+Bl,By+Bh,MenuOff);
           bevel(bx,by,bx+bl,by+bh,lightshad,darkshad);
      end;
     midx      :=  (bx + (bl div 2)) - ( (length(name) * 8) div 2);
     midy      :=  (by + (bh div 2)) - 4;
     moveto (midx, midy);
     setcolor(BTNFont);
     outtext(name);
     restore;
     DispMouse;
end;

procedure TMenu.DrawBox;
 var i,d,f:integer;
 begin
      KillMouse;
                h:=entries*ItemHT;
                FillRectangle(x,y-1,x+l,Y+h+1,btnface);
                bevel(x,y-1,x+l,y+h+1,lightshad,darkshad);

                for i:= 0 to entries do
                begin
                     d:=i*ItemHT;
{                     if I=highlight then fillrectangle(x+1,y+d,x+l,y+10,darkgray,false);}

                     setcolor(btnfont);
                     if lines[i]='ID1015' then Line3d(x+1,y+d+(ItemHT div 2),l-2,darkshad,lightshad)
                     else outtextxy(x+3,y+d+3,lines[i]);
                end;
      DispMouse;
 end;

procedure TMenu.AddItem;
 begin
      inc(entries);
      lines[id]:=iname;
      h:=entries*ItemHT;
 end;

function TMenu.Open;
var i,pi,d,f,g,DownAlready:integer;
 begin

 {Rundown}
{
 if the button is pressed we open the menu. If the button is held down
 then we remember that and open the menu anyway. While the mouse button
 is released or still held down, we respond to movement. If the mouse
 button was held down and is now released, recognise that it is now up.
 If the mouse button is pressed after this, then save the selected item
 and exit.
 If we dont do this, then if you press the menu button, it is outside
 the menu, and it closes itself, and u get a flashing menu
 But instead we have silky smooth menus :)
}
      if MouseButtonPressed=true then
      begin
            X:=bx+1;
            y:=by+bh;
            if mtir(bx,by,bx+bl,by+bh)=true then
               begin
                    click:=true;
                    Tmenu.draw;
                    click:=false;
                    TMenu.DrawBox;
                    Open:=true;
                    pi:=1;
                    If MouseButtonPressed=true then DownAlready:=100;
                    {while MouseButtonPressed=true do;{}

                    while (MouseButtonPressed=false) or (DownAlready>99) do
           for i:= 0 to entries do
              begin
                   if (downalready>99) then
                    if mousebuttonpressed=false then downalready:=0;

                   d:=i*ItemHT;
                   if (mtir(x,y+d,x+l,y+d+ItemHT)=true) and (mousepy<y+h) then
                   begin
                        highlight:=i;
                        clicknum:=i;
                        if pi<>i then Tmenu.RedrawItem(pi);
                        Tmenu.SelectItem(i);
                        pi:=i;
                        while mtir(x,y+d,x+l,y+d+ItemHT)=true do
                        begin
                         if (downalready>99) then
                         if mousebuttonpressed=false then downalready:=0;
                         if (MouseButtonPressed=true) and (downalready<99) then exit;
                        end;
                   end;
                   if (MouseButtonPressed=true) and (downalready<99) then
                   begin
                        if mtir(x,y,x+l,y+h)=false then clicknum:=-1;
                        Tmenu.Destroy;
                        exit;
                   end;
               end;

              end;


      end;

 end;

procedure TMenu.SelectItem;
 var d:integer;
 begin
      {TMenu.DrawBox;}
      KillMouse;
      d:=i*ItemHT;
      if lines[i]='ID1015' then Line3d(x+1,y+d+(ItemHT div 2),l-2,darkshad,lightshad)
      else
      begin
           fillrectangle(x+1,y+d,x+l-1,y+d+ItemHT,lightgray);
	        bevel(x+1,y+d,x+l-1,y+d+ItemHT,darkshad,lightshad);
           setcolor(btnfont);
           outtextxy(x+3,y+d+2,lines[i]);
      end;
      DispMouse;
 end;

function TMenu.ItemClick;
 begin


 end;

destructor TMenu.destroy;
 begin
      killmouse;
      DrawBackground;
      dispmouse;
 end;


procedure TMenu.RedrawItem;
 var d:integer;
 begin
      KillMouse;

      d:=i*ItemHT;
      if lines[i]='ID1015' then Line3d(x+1,y+d+(ItemHT div 2),l-2,darkshad,lightshad)
      else
      begin
{           fillrectangle(x+1,y+d,x+l,y+d+ItemHT,darkgray);}
           fillrectangle(x+1,y+d,x+l-1,y+d+ItemHT,lightgray);
      	  {bevel(x+1,y+d,x+l-1,y+d+ItemHT,darkshad,lightshad);}
           setcolor(btnfont);
           outtextxy(x+2,y+d+1,lines[i]);
      end;
      DispMouse;
 end;




constructor TPopup.make;
 begin
      l:=il;
      h:=ih;
 end;

procedure TPopup.redraw;
 var i,d,f:integer;
 begin
      KillMouse;
                h:=entries*ItemHT;
                FillRectangle(x+1,y+1,x+l-1,Y+h-1,btnface);

                setcolor(btnfont);
                for i:= 0 to entries do
                begin
                     d:=i*ItemHT;
{                    if I=highlight then fillrectangle(x+1,y+d,x+l,y+10,darkgray,false);}

                     if lines[i]='ID1015' then Line3d(x+1,y+d+3,l-2,darkshad,lightshad)
                     else outtextxy(x+2,y+d+1,lines[i]);
                end;
      DispMouse;
 end;


procedure TPopup.Draw;
 var i,d,f:integer;
 begin
      KillMouse;
      h:=entries*ItemHT;
      FillRectangle(x,y-1,x+l,Y+h+1,btnface);
      bevel(x,y-1,x+l,y+h+1,lightshad,darkshad);

      for i:= 0 to entries do
      begin
           d:=i*ItemHT;
{          if I=highlight then fillrectangle(x+1,y+d,x+l,y+10,darkgray,false);}

           setcolor(btnfont);
           if lines[i]='ID1015' then Line3d(x+1,y+d+3,l-2,darkshad,lightshad)
           else outtextxy(x+2,y+d+2,lines[i]);
      end;
      DispMouse;
 end;

procedure TPopup.AddItem(id:integer;Name:string);
 begin
      inc(entries);
      lines[id]:=name;
      h:=entries*ItemHT;
 end;

Procedure TPopup.Popup;
var i,pi,d,f,g:integer;
 begin
      X:=ix;
      y:=iy;
      TPopup.Draw;
      pi:=1;
      while MouseButtonPressed=false do
           for i:= 0 to entries do
              begin
                   d:=i*ItemHT;
                   if (mtir(x,y+d,x+l,y+d+ItemHT)=true) and (mousepy<y+h) then
                   begin
                        highlight:=i;
                        clicknum:=i;
                        if pi<>i then Tpopup.RedrawItem(pi);
                        TPopup.SelectItem(i);
                        pi:=i;
                        while mtir(x,y+d,x+l,y+d+ItemHT)=true do
                         if MouseButtonPressed=true then exit;
                   end;
                   if MouseButtonPressed=true then
                   begin
                        if mtir(x,y,x+l,y+h)=false then clicknum:=-1;
                        TPopup.Destroy;
                        exit;
                   end;
               end;
           TPopup.Destroy;

 end;


function TPopup.Open;
var i,pi,d,f,g:integer;
 begin
      if MouseButtonPressed=true then
      begin
            X:=MousePX;
            y:=MousePY;
            if mtir( parent.w_x+1,
                     parent.w_y+20,
                     parent.W_x+parent.w_l,
                     parent.w_y+parent.w_h
                   )=true then
               begin
                    {TPopup.Draw;}
                    Open:=true;
                    pi:=1;
                    while MouseButtonPressed=true do
                    for i:= 0 to entries do
                    begin
                         d:=i*ItemHT;
                         if (mtir(x,y+d,x+l,y+d+ItemHT)=true) and (mousepy<y+h) then
                         begin
                              highlight:=i;
                              clicknum:=i;
                              if pi<>i then Tpopup.RedrawItem(pi);
                              TPopup.SelectItem(i);
                              pi:=i;
                              {retrace;}
                              while mtir(x,y+d,x+l,y+d+ItemHT)=true do
                              if MouseButtonPressed=false then exit;
                         end;
                         if MouseButtonPressed=false then
                         begin
                              {retrace;}
                              if mtir(x,y,x+l,y+h)=false then clicknum:=-1;
                              TPopup.Destroy;
                              exit;
                         end;
                    end;
                    TPopup.Destroy;
                    retrace;
               end;


      end;

 end;
procedure TPopup.RedrawItem;
 var d:integer;
 begin
      KillMouse;

      d:=i*ItemHT;
      if lines[i]='ID1015' then Line3d(x+1,y+d+3,l-2,darkshad,lightshad)
      else
      begin
{           fillrectangle(x+1,y+d,x+l,y+d+ItemHT,darkgray);}
           fillrectangle(x+1,y+d,x+l-1,y+d+ItemHT,lightgray);
      	  {bevel(x+1,y+d,x+l-1,y+d+ItemHT,darkshad,lightshad);}
           setcolor(btnfont);
           outtextxy(x+2,y+d+2,lines[i]);
      end;
      DispMouse;
 end;

procedure TPopup.SelectItem;
 var d:integer;
 begin
      KillMouse;

      d:=i*ItemHT;
      if lines[i]='ID1015' then Line3d(x+1,y+d+3,l-2,darkshad,lightshad)
      else
      begin
{           fillrectangle(x+1,y+d,x+l,y+d+ItemHT,darkgray);}
           fillrectangle(x+1,y+d,x+l-1,y+d+ItemHT,lightgray);
      	  bevel(x+1,y+d,x+l-1,y+d+ItemHT,darkshad,lightshad);
           setcolor(btnfont);
           outtextxy(x+2,y+d+2,lines[i]);
      end;
      DispMouse;
 end;

function TPopup.ItemClick;
 begin


 end;

destructor TPopup.destroy;
 begin
      killmouse;
      DrawBackground;
      dispmouse;
 end;





end.