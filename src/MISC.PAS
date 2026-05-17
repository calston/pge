unit misc;

interface

uses
  dos,crt;

var
  startingtime, endingtime: real;

function inttostr(i:longint):string;
function realtostr(r:real; width,prec:byte):string;
function fileexists(fn:string; attr:word) : boolean;
function NotNumber(what:string):boolean;

implementation

function NotNumber(what:string):boolean;
var i,code:integer;
begin
    Val(ParamStr(1), I, Code);
    { Error during conversion to integer? IE. It containd non numeric
      data ...                                                         }
    if code <> 0 then NotNumber:=true;
end;

function inttostr(i:longint):string;
var s: string;
begin
  str(i,s);
  inttostr:=s
end;

function realtostr(r:real;width,prec:byte):string;
var s: string;
begin
  str(r:width:prec,s);
  realtostr:=s
end;

function fileexists(fn:string; attr:word):boolean;
{ attr=archive ($20) / directory ($10) }
var
  sr : searchrec;
begin
  findfirst(fn,attr,sr);
  fileexists := doserror = 0;
end;


end.
