{
PROG: apples
LANG: PASCAL
}

Program APPLES;

type
  Tmas = array [1 .. 5001, 1 .. 3] of longint;

var
  ats, viso, greit : integer;
  mas : Tmas;

procedure nuskaitymas (var viso, greit : integer; var mas : Tmas);
var
  F : Text;
  ck : Integer;
begin
  assign (f, 'apples.in');
  reset (f);
  readln (f, viso, greit);
  inc (viso);
  mas [1, 1] := 0;
  mas [1, 2] := 0;
  mas [1, 3] := 0;
  for ck := 2 to viso do
  readln (f, mas [ck, 1], mas [ck, 2], mas [ck, 3]);
  close (f)
end;

procedure rikiuok (r1, r2 : Integer; var mas : Tmas);
var
  pg, v, v1, v2 : integer;
begin
  v1 := r1;
  v2 := r2;
  v := mas [(v1 + v2) div 2, 3];
  repeat
    while mas [v1, 3] < v do inc (v1);
    while v < mas [v2, 3] do dec (v2);
    if v1 <= v2 then
    begin
      pg := mas [v1, 1];
      mas [v1, 1] := mas [v2, 1];
      mas [v2, 1] := pg;
      pg := mas [v1, 3];
      mas [v1, 3] := mas [v2, 3];
      mas [v2, 3] := pg;
      pg := mas [v1, 2];
      mas [v1, 2] := mas [v2, 2];
      mas [v2, 2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuok (v1, r2, mas);
  if r1 < v2 then rikiuok (r1, v2, mas)
end;

function min (sk1, sk2 : Integer) : integer;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

function max (sk1, sk2 : Integer) : integer;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

function laik (x1, x2 : integer) : real;
var
  x, y : Integer;
begin
  x := abs (mas [x2, 1] - mas [x1, 1]);
  y := abs (mas [x2, 2] - mas [x1, 2]);
  laik := min (x, y) * 0.41 + max (x, y)
end;

function rask : Integer;
var
  eil : array [1 .. 500000] of integer;
  ilg : array [1 .. 5000] of integer;
  ck, did, gal, uod : Integer;
begin
  fillchar (ilg, sizeof (ilg), 0);
  did := 1;
  gal := 1;
  uod := 2;
  eil [1] := 1;
  ilg [1] := 1;
  while gal < uod do
  begin
    for ck := eil [gal] + 1 to viso do
    if (ilg [ck] <= ilg [eil [gal]]) and
       (laik (eil [gal], ck) / greit <= (mas [ck, 3] - mas [eil [gal], 3])) then
    begin
      eil [uod] := ck;
      inc (uod);
      ilg [ck] := ilg [eil [gal]] + 1;
      if ilg [ck] > did then did := ilg [ck]
    end;
    inc (gal)
  end;
  rask := did - 1
end;

procedure rasymas (ats : integer);
var
  f : Text;
begin
  assign (f, 'apples.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, greit, mas);
  rikiuok (1, viso, mas);
  ats := rask;
  rasymas (ats)
end.
