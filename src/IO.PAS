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

                       File IO Core

}
unit io;
interface

uses vesa256,dos,fx,video,crt,memory,strings;

var Nul:Integer;

type
    stream=object
          iofilename:string[100];
          data:string;
          dataf:text;

          procedure DefineIO(name:string);

          function GetBit:char;
          function GetLine:string;

          procedure PutBit(n:char);
          procedure PutLine(n:string);

          procedure Opens;
          procedure OpenW;
          Procedure Closes;
    end;
    Procedure Execute(name:string);
    function FExists(FileName: String): Boolean;

implementation
uses pge,xpge;

 function FExists(FileName: String): Boolean;
 var F: file;
 begin
      {$I-}
      Assign(F, FileName);
      FileMode := 0;  {Set file access to read only}
      Reset(F);
      Close(F);
      {$I+}
      FExists := (IOResult = 0) and (FileName <> '');
 end;


 Procedure Execute(name:string);
  Var comm1,d:string;
  Begin
       Comm1 := '/C ' + name;

       SwapVectors;
         Exec(GetEnv('COMSPEC'), Comm1);
       SwapVectors;

       if DosError <> 0 then
          begin
               Setcolor(lightred);
               outtextxy(1,getmaxy-50, 'Error Executing File, Press any key to continue');
               outtextxy(1,getmaxy-40, 'Error Number ->' + wordtostr(DosError));
               outtextxy(1,getmaxy-30, 'Free Memory T:'+ wordtostr(MaxAvail)+'Bytes  B:'+wordtostr(MaxBufMem)+'Bytes.');
               GetDir(0,d);
               outtextxy(1,getmaxy-20, 'Current Directory'+d);
               readkey;
               Setcolor(bkcolor);
               outtextxy(1,getmaxy-50, 'Error Executing File, Press any key to continue');
               outtextxy(1,getmaxy-40, 'Error Number ->' + wordtostr(DosError));
               outtextxy(1,getmaxy-30, 'Free Memory T:'+ wordtostr(MaxAvail)+'Bytes  B:'+wordtostr(MaxBufMem)+'Bytes.');
               GetDir(0,d);
               outtextxy(1,getmaxy-20, 'Current Directory'+d);
               restore;
          end;
  end;

 procedure stream.DefineIO;
  var p:pchar;
  Begin
       iofilename:=name;
  end;

 function stream.GetBit:char;
  var tmpbit:char;
  Begin
       read(dataf, tmpbit);
       getbit:=tmpbit;
  end;

 function stream.GetLine:string;
  var S:string;
  Begin
       readln(dataf, s);
       data:=s;
       getline:=s;
  end;

 procedure stream.PutBit;
  Begin
       Write(dataf, n);
  end;

 procedure stream.PutLine;
  Begin
       Writeln(dataf, n);
  end;

 procedure stream.OpenS;
  Begin
       Assign(dataf, IOfilename);
       reset(dataf);
  end;

 procedure stream.OpenW;
  Begin
       Assign(dataf, IOfilename);
       rewrite(dataf);
  end;

 Procedure stream.CloseS;
  Begin
       close(dataf);
  end;

end.


{Eof.PAS}

{Sample code for the Eof, Read, and Write functions (text files).}

{ For Windows: }
{ uses WinCrt, WinDos;

var
  F: Text;
  Ch: Char;
begin
  Assign(F, ParamStr(1));
  Reset(F);
  while not Eof(F) do
  begin
    Read(F, Ch);
    Write(Ch);
  end;
end.


{Sample code for the GetEnv function.}

{$M 8192,0,0} {
uses Dos;

var Command: string[79];
begin
  Write('Enter DOS command: ');
  Readln(Command);
  if Command <> '' then
    Command := '/C ' + Command;
  SwapVectors;
  Exec(GetEnv('COMSPEC'), Command);
  SwapVectors;
  if DosError <> 0 then
    Writeln('Could not execute COMMAND.COM');
end.


}