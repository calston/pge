unit Dialog;
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

                   Basic Dialog Controls

}

interface
uses PGE,fx,graph,video,crt,mousei,editbox;

type
    TDialog=object

           Line1:TLable;
           Line2:TLable;
           Win:TWin;
           Ok  :TButton;

           ico1,ico2:pchar;

           Text1,Text2:string;
           cap:string;

           constructor make(caption:string;icon1,icon2:pchar);
           destructor  Destroy;

           procedure AddLines(string1,string2:string);
           procedure Draw;
           procedure Switch;
    end;

    TFileSelection=object
    end;

    function GetFileDLG(title:string):String;

    function PGEMsg(code,what:string):char;

implementation

function PGEMsg(code,what:string):char;
var MDlg:TWin;
    done:boolean;
    i:integer;
    Num,x:integer;
    yes,no,apply,cancel,ok:Tbutton;
    texl,winl:integer;

    x1,y1:integer;

procedure DrawButtons;
var i:integer;
begin
     for i:=1 to length(code) do
     begin
          Case code[i] of
           'Y': Yes.ParentMove(MDlg);
           'N': No.ParentMove(MDlg);
           'O': Ok.ParentMove(MDlg);
           'A': Apply.ParentMove(MDlg);
           'C': Cancel.ParentMove(MDlg);
          end;
     end;
     AddText(texL,40,what,1,MDlg);
end;

begin
     drawbackground;

     {Calculate some important specs}
     winL:=length(what)*10;
     winL:=winL+50;
     if (winL<(Length(code)*60)) then WinL:=(Length(code)*60)+50;

     TexL:=(winl div 2) - ((Length(what)*10) div 2 );

     num:=(winl div 2)-((length(code)*60)div 2);

     for i:=1 to length(code) do
     begin
          x:=num+((i-1)*60);

          Case code[i] of
           'Y': Yes.Make   (x,60,50,25,'Yes',MDlg);
           'N': No.Make    (x,60,50,25,'No',MDlg);
           'O': Ok.Make    (x,60,50,25,'Ok',MDlg);
           'A': Apply.Make (x,50,60,25,'Apply',MDlg);
           'C': Cancel.Make(x,60,50,25,'Cancel',MDlg);
          end;
     end;

     MDlg.Make(400-(winl div 2),300-50, winl, 100, '',0,0);
     MDlg.Draw;

     DrawButtons;
     Done:=false;

     while done=false do
     begin
          if keypressed then if readkey=#27 then done:=true;
          if MDlg.windowClosed=true then done:=true;
          if MDlg.moved=true then drawbuttons;
          if MDlg.resize=true then drawbuttons;

     for i:=1 to length(code) do
     begin
        Case code[i] of
          'Y':IF Yes.Pushed=true then begin PGEMsg:='Y'; Done:=true;  end;
          'C':IF Cancel.Pushed=true then begin PGEMsg:='C'; Done:=true; end;
          'O':IF Ok.Pushed=true then begin PGEMsg:='O';Done:=true;end;
          'N':IF No.Pushed=true then begin PGEMsg:='N'; Done:=true;  end;
          'A':IF Apply.Pushed=true then begin PGEMsg:='A'; Done:=true; end;
        end;
     end;
     end;
     MDlg.destroy;
end;

function GetFileDLG(title:string):String;
var dlg:TWin;
    ok,cancel:tbutton;
    text:tlable;
    fin:boolean;
    fname:Tedit;
begin
     dlg    .Make(200, 200, 220,110, title,150,100);
     ok     .Make(5  , 70 , 100, 25, 'Ok'       ,dlg       );
     cancel .Make(115  , 70 , 100, 25, 'Cancel' ,dlg       );
     fname  .Make(10,40,200,20,dlg);
     DrawBackground;
     dlg.draw;
     fname.draw;
     ok.draw;
     cancel.draw;
     fin:=false;
     while not fin=true do
     begin
          if dlg.windowclosed=true then fin:=true;
          if dlg.moved=true then
          begin
               fname.parentmove(dlg);
               ok.parentmove(dlg);
               cancel.parentmove(dlg);
          end;
          if fname.click=true then NulCmd;

          if cancel.pushed=true then
          begin
               GetFileDLG:='';
               exit;
          end;

          if OK.pushed=true then
          begin
               fin:=true;
          end;
     end;
     DrawBackground;
     GetFileDLG:=fname.contents;
{     text   .make(}

end;






constructor TDialog.make;
 Begin
      cap:=caption;
      ico1:=icon1;
      ico2:=icon2;
      Win  .make(150,200,350,100,'   '+cap,100,100);
      Line1.make(60,35,16,0,text1, Win);
      Line2.make(60,50,16,0,text2, Win);
      OK   .make(170,65,60,25,'Ok',win);
 end;

procedure TDialog.AddLines(string1,string2:string);
 Begin
      text1:=string1;
      text2:=string2;
      Line1.Lable:=text1;
      Line2.Lable:=text2;
 end;

procedure TDialog.Draw;
 Begin
      Win  .draw;
      Line1.draw;
      Line2.draw;
      OK   .draw;
 end;

procedure TDialog.Switch;
var done123:boolean;
 Begin
      Win  .draw;
      Line1.draw;
      Line2.draw;
      OK   .draw;

      AddPCX(ico1,3,4,Win);
      AddPCX(ico2,5,35,Win);
      done123:=false;

      while done123=false do
      begin
           if Win.WindowClosed=true then done123:=true;
           if win.Moved=true then
           begin
                Line1.ParentMove(win);
                Line2.ParentMove(win);
                OK   .ParentMove(win);
                AddPCX(ico1,3,4,Win);
                AddPCX(ico2,5,35,Win);
           end;
           if Ok.Pushed=true then done123:=true;
      end;

      TDialog.Destroy;
 end;

destructor  TDialog.Destroy;
 Begin
      Win.Destroy;
 end;

end.