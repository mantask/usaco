{
PROG:mtwalk
LANG:PASCAL
}

Program MTWALK;

Type
  tmas = array [1 .. 100, 1 .. 100] of integer;

var
  mas : Tmas;
  ats, viso : Integer;

Procedure nuskaitymas (var viso : integer; var mas : TMas);
var
  f : Text;
  ckx, cky : integer;
begin
  assign (f, 'mtwalk.in');
  reset (f);
  readln (f, viso);
  for cky := 1 to viso do
  begin
    for ckx := 1 to viso do
    read (f, mas [ckx, cky]);
    readln (f)
  end;
  close (f)
end;

function max (sk1, sk2 : Integer) : integer;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

function rask (viso : Integer; var mas : TMas) : integer;
var
  pg : Tmas;
  ckx, cky : integer;
begin
  fillchar (pg, sizeof (pg), $FF);
  pg [1, 1] := 0;
  for ckx := 1 to viso do
  for cky := 1 to viso do
  begin
    if (cky > 1) and ((pg [ckx, cky - 1] = -1) or
       (max (pg [ckx, cky], abs (mas [ckx, cky] - mas [ckx, cky - 1])) < pg [ckx, cky - 1]))
    then pg [ckx, cky - 1] := max (pg [ckx, cky], abs (mas [ckx, cky] - mas [ckx, cky - 1]));
    if (ckx > 1) and ((pg [ckx - 1, cky] = -1) or
       (max (pg [ckx, cky], abs (mas [ckx - 1, cky] - mas [ckx - 1, cky])) < pg [ckx - 1, cky]))
    then pg [ckx - 1, cky] := max (pg [ckx, cky], abs (mas [ckx, cky] - mas [ckx - 1, cky]));
    if (cky < viso) and ((pg [ckx, cky + 1] = -1) or
       (max (pg [ckx, cky], abs (mas [ckx, cky] - mas [ckx, cky + 1])) < pg [ckx, cky + 1]))
    then pg [ckx, cky + 1] := max (pg [ckx, cky], abs (mas [ckx, cky] - mas [ckx, cky + 1]));
    if (ckx < viso) and ((pg [ckx + 1, cky] = -1) or
       (max (pg [ckx, cky], abs (mas [ckx, cky] - mas [ckx + 1, cky])) < pg [ckx + 1, cky]))
    then pg [ckx + 1, cky] := max (pg [ckx, cky], abs (mas [ckx, cky] - mas [ckx + 1, cky]))
  end;
  rask := pg [viso, viso]
end;

procedure rasymas (ats : integer);
var
  f : text;
begin
  assign (f, 'mtwalk.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  ats := rask (viso, mas);
  rasymas (ats)
end.
