unit ini;
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

                    INI Support Module

}
interface
uses io,crt,strings;
const debug=0;
type
      Config=object
            filename:string[100];
            inistream:stream;

            constructor Define(name:string);
            function GetData(param:string;term:char):string;
            function GetNum(param:string;term:char):integer;
            destructor CloseFile;
      end;

implementation
 constructor Config.Define;
  Begin
       filename:=name;  {Load File Name}
       inistream.DefineIO(filename); {Define Input Stream}
  End;

 function Config.GetNum(param:string;term:char):integer;
 var i,s,d:integer;
 begin
      val(Config.GetData(param,term),i,d);
      GetNum:=i;
 end;

 function Config.GetData(param:string;term:char):string; {Get a setting}
  var tmpdata:string;
      tmpbit:char;
      loop:boolean;
      i:integer;
      j:integer;
      stringd:string;
  Begin
       inistream.opens;

       while not eof(inistream.dataf) do
        begin
             stringd:='';                 {clear string contents}
             tmpdata:=inistream.GetLine;  {read line from file}
             if debug=1 then writeln('<DEBUGER> Read Data = ',tmpData);
             if debug=1 then readkey;
             if not (tmpdata[1]='#') then
             for i:= 1 to length(tmpdata) do {loop utill end of line }
              begin
                   tmpbit:=tmpdata[i]; {read bit}
                   if debug=1 then writeln('<DEBUGER> Read Bit = ',tmpBit);
                   if debug=1 then readkey;

                   if tmpbit=term then {if character is param teminator}
                   if stringd=param then {if string is parameter}
                   begin
                        stringd:=''; {clear string}
                        if debug=1 then writeln('<DEBUGER> Found Params Match');
                        if debug=1 then readkey;
                        for j:= i+1 to length(tmpdata) do {read last param contents}
                        begin
                             tmpbit:=tmpdata[j]; {readbit}
                             if debug=1 then writeln('<DEBUGER> Read Bit = ',tmpBit,' At pos',j);
                             if debug=1 then readkey;
                             stringd:=stringd+tmpbit;{add to buffer}
                        end;
                        getdata:=stringd;{save param data}
                        exit; {exit proc}
                   end; {else continue}
                   stringd:=stringd+tmpbit;
                   if debug=1 then writeln('<DEBUGER> "Stringd" currently = ',stringd);
                   if debug=1 then readkey;
              end;
        end;
        self.closeFile;
  End;

 destructor Config.CloseFile; {Close Stream}
  Begin
       inistream.closes;
       filename:='';
  End;

end.

