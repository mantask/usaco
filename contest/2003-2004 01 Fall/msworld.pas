{
PROG: msworld
LANG: PASCAL
}

Program MSWORLD;

Type
  Tmas = array [1 .. 50000, 1 .. 2] of integer;

var
  ats, viso : longint;
  mas : Tmas;

Procedure nuskaitymas (var viso : longint; var mas : Tmas);
var
  f : Text;
  ck : longint;
begin
  assign (f, 'msworld.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  readln (f, mas [ck, 1], mas [ck, 2]);
  close (f)
end;

function rask : longint;
var
  ck2, ck1 : integer;
  max, d : longint;
begin
  max := 0;
  for ck1 := 1 to viso - 1 do
  for ck2 := ck1 + 1 to viso do
  begin
    d := (mas [ck1, 1] - mas [ck2, 1]) * (mas [ck1, 1] - mas [ck2, 1]) +
         (mas [ck1, 2] - mas [ck2, 2]) * (mas [ck1, 2] - mas [ck2, 2]);
    if d > max then max := d
  end;
  rask := max
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'msworld.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  ats := rask;
  rasymas (ats)
end.
