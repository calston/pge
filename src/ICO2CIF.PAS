program IconReader;
uses crt,advcrt,io,video,graph,xpge;


var
   ImageStream:Stream;
   x,y:integer;
   fpos:integer;
   line_in:string;
   usefull:array[1..10] of char;
   c:integer;

   temp:string;

   gm,gd:integer;
   r,rr :byte;
  f    :text;
  ox,oy,p,q  :integer;
  ch:char;


begin
     ImageStream.DefineIO(paramstr(2));

     initgraph(gm,gd,'C:\tp\bgi');
     ImageStream.OpenW;

     Line_In:='32x32x16';
     ImageStream.PutLine(Line_in);

     inc(fpos);
     outtextxy(100,100,line_in);
     {Draw graphic to rip}
     {it is posible to use the icon lib in bitmap.pas to read
      an icon and put it on the screen then rip it with this program}

  ox:=1;oy:=32;
  x:=ox; y:=oy;
  assign(f,paramstr(1));
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



     {Rip it}
     for y:= 1 to 32 do
        begin
             for x:=1 to 32 do
                begin
                     c:=getpixel(x,y); {read}
                     {Corect Colour perseption}
                     case c of
                        11:c:=14;
                        14:c:=11;
                        4: c:=1;
                        12:c:=9;
                        1: c:=4;
                        9: c:=12;
                     end;
                     temp[1]:=chr(c);
                     ImageStream.PutBit(temp[1]);
                end;
              ImageStream.PutLine('|');
        end;
     readkey;
     ImageStream.CloseS;

end.