uses {$I PGE.INC}
{$i-}
{$M 8192,0,0}
var
   TPDIR:string;
   dest:string;
   srcdir:string;
   compiler:string;

   paramsd:string;
   tmp1,tmp2:string;

   ok:boolean;
   ins:char;
   S: PathStr;

Procedure CompileS;
begin
     {C:\tp\bin\tpc.exe .\pge\dog.pas}
    TMP1:= compiler+' -B .\'+tmp2+' '+paramsd;
     Typeon(' ');
      wait(30);
      swapvectors;
       Exec(GetEnv('COMSPEC'), '/C '+TMP1);
      swapvectors;
     if DosError <> 0 then
        Writeln('Could not execute COMMAND.COM :',DosError);
End;


Procedure CompileD;
begin
     {C:\tp\bin\tpc.exe -uC:\pge\pge C:\pge\dog.pas}
    TMP1:= compiler+' -B -U.\PGE .\'+tmp2+' '+paramsd;
     Typeon(' ');
      wait(30);
      swapvectors;
       Exec(GetEnv('COMSPEC'), '/C '+TMP1);
      swapvectors;
     if DosError <> 0 then
        Writeln('Could not execute COMMAND.COM :',DosError);
End;

begin
     textbackground(Blue);
     textColor(white);
     clrscr;

     FlyOnRight('Welcome To PGE Setup',1);
     wait(300);
     writeln;
     writeln;
     typeon('Enter Turbo Pascal Directory (ie C:\tp): ');
     readln(TPDIR);
     Typeon('Thanks, Verifying...');

     S := FSearch('tpc.exe',tpdir+';'+tpdir+'\bin');
     if S = '' then
        begin
             TypeOn('Compiler not found');
             writeln;
             TypeOn('Please Enter Path to Compiler: ');
             readln(tpdir);
             typeon('Ok...');
             writeln;
        end
     else
         { Show full path }
         typeon('Found as '+FExpand(S));
     writeln;
     compiler:=''+FExpand(s);
     writeln;

     Typeon('Enter Directory to install PGE: ');
     readln(dest);
     typeon('Thanks, Verifying...');
     ChDir(dest);
     if IOResult <> 0 then
      begin
           TypeOn('Cannot find directory, Ok to Create (Y/N): ');
           while not ok=true do
           begin
                ins:=readkey;
                ins:=upcase(ins);
                writeln;
                if (ins='Y') or (ins='N') then ok:= true;

           end;
           if ins='N' then
              begin
                   typeon('No');
                   writeln;
                   typeon('Ok, I wont. But i cant continue!');
                   writeln;
                   typeon('Good Bye');
                   wait(500);
                   clrscr;
                   halt;
              end;

           if ins='Y' then
              begin
                   typeon('Yes');
                   writeln;
                   typeon('Ok, ill make it then...');
                   mkdir(dest);
                   typeon('Done!');
              end;
      end
     else typeon('OK!');
      {begin copying}
     writeln;
     writeln;

     typeon('Please Enter Source Directory: ');
     readln(srcdir);
     typeon('Thanks, Verifiying...');

     S := FSearch('pge.pas',srcdir+'\pge');
       if S = '' then
          typeon('I cant be sure but ill try!')
       else
          typeon('Ok It Looks Authentic!');
     writeln;

     writeln;
     Typeon('Press Any key to Begin Copying');
     readkey;
     writeln;
     writeln;
     Typeon('Getting Ready To Copy...');


     writeln;

     typeon('Copying PGE...');
     ChDir(dest+'\pge');
     if IOResult <> 0 then
      begin
           mkdir(dest+'\PGE');
      end;

     chdir(srcdir+'\PGE');

     paramsd:=' > NUL';

     { Copy E:\PGE\PGE\*.* C:\PGE\PGE}
     TMP1:= 'Copy '+srcdir+'\pge\'+'*.* '+dest+'\PGE'+paramsd;



      wait(30);
      swapvectors;
       Exec(GetEnv('COMSPEC'), '/C '+TMP1);
      swapvectors;

     if DosError <> 0 then
      Writeln('Could not execute COMMAND.COM :',DosError);
     Typeon('DONE!!!');
     writeln;
     typeon('Copying PGE Demos & Examples...');

     { Copy E:\PGE\*.* C:\PGE\}
     TMP1:= 'Copy '+srcdir+'\'+'*.* '+dest+''+paramsd;



      wait(30);
       swapvectors;
        Exec(GetEnv('COMSPEC'), '/C '+TMP1);
       swapvectors;

     if DosError <> 0 then
        Writeln('Could not execute COMMAND.COM :',DosError);


     Typeon('DONE!!!');
     writeln;
     writeln;
     Typeon('Ok To Compile?');

     ok:=false;

     while not ok=true do
         begin
                ins:=readkey;
                ins:=upcase(ins);
                if (ins='Y') or (ins='Y') then ok:= true;

           end;
           if ins='N' then
              begin
                   typeon('No');
                   writeln;
                   typeon('Ok, I wont. Enjoy Using PGE!');
                   writeln;
                   typeon('Good Bye');
                   wait(500);
                   clrscr;
                   halt;
              end;

           if ins='Y' then
              begin
                   typeon('Yes');
                   writeln;
                   typeon('Ok, ill do it then...');
              end;

     chdir(dest+'\');
     {Compile PGE Stuff}

     paramsd:=' > NUL';
     clrscr;

     Write('Compiling ');
     textbackground(cyan);
     write('                  ');
     gotoxy(11,1);
     textbackground(green);
     TMp2:= 'vesa256.pas';
     compiled;
     TMp2:= 'pge\fx.pas';
     compiled;
     TMp2:= 'pge\bitmap.pas';
     compiled;
     TMp2:= 'pge\io.pas';
     compiled;
     TMp2:= 'pge\video.pas';
     compiled;
     TMp2:= 'pge\ini.pas';
     compiled;
     TMp2:= 'pge\mousei.pas';
     compiled;
     TMp2:= 'pge\pge.pas';
     compiled;
     {Compile Demos}
     TMp2:= 'CIFEdit.pas';
     compiled;
     tMp2:= 'window.pas';
     compiled;
     TMp2:= 'editor.pas';
     compiled;
     TMp2:= 'demo.pas';
     compiled;
     TMp2:= 'demo2.pas';
     compiled;
     TMp2:= 'loader.pas';
     compiled;
     TMp2:= 'popwin.pas';
     compiled;
     TMp2:= 'gui.pas';
     compiled;
     TMp2:= 'calc.pas';
     compiled;
     TMp2:= 'cdplayer.pas';
     compiled;

     textbackground(blue);

     Writeln;
     Typeon('DONE!');
     writeln;
     TypeOn('ENJOY USING PGE!');
     readkey;
end.

