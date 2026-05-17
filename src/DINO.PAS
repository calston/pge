Unit dino;
interface
uses crt;
         procedure Screen;
implementation

procedure Screen;
begin
CLRSCR;
textcolor(lightgreen);
writeln ('                          .       .                              ' );
writeln ('                         / `.   .'' \                             ');
writeln ('                 .---.  <    > <    >  .---.                     ' );
writeln ('                 |    \  \ - ~ ~ - /  /    |                     ' );
writeln ('                  ~-..-~             ~-..-~                      ' );
writeln ('              \~~~\.''    PGE             `./~~~/                 ');
writeln ('    .-~~^-.    \__/                         \__/                  ' );
writeln ('  .''  O    \     /    Version 4  /       \  \                    ');
writeln (' (_____,    `._.''               |         }  \/~~~/              ');
writeln ('  `----.          /       }     |        /    \__/               ' );
writeln ('        `-.      |       /      |       /      `. ,~~|           ' );
writeln ('            ~-.__|      /_ - ~ ^|      /- _      `..-''   :  :    ');
writeln ('                 |     /        |     /     ~-.     `-. _||_||_  ' );
writeln ('                .|_____|       .|_____|         ~ - . _ _ _ _ _> ' );
textcolor(lightgray);
end;
end.