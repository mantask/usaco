{
PROG: captives
LANG: PASCAL
}

Program CAPTIVES;

TYpe
  TMas = array [1 .. 1000, 1 .. 2] of longint;

var
  x, y : longint;
  ats, viso : Integer;
  mas : Tmas;

Procedure nuskaitymas (var viso : integer; var x, y : longint; var mas : Tmas);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'captives.in');
  reset (f);
  readln (f, viso, x, y);
  for ck := 1 to viso do
  readln (f, mas [ck, 1], mas [ck, 2]);
  close (f)
end;

function rask : integer;
var
  pg : real;
begin
  pg := viso;
  rask := round (pg / 4)
end;

Procedure rasymas (ats : Integer);
var
  f : Text;
begin
  assign (f, 'captives.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, x, y, mas);
  ats := rask;
  rasymas (ats)
end.
