{
ID: vkanapo001
PROG: fc
}

Program FC;

type
  Tmas = array [1 .. 10000, 1 .. 2] of real;
  Tkamp = array [1 .. 10000] of real;

var
  mas : Tmas;
  viso : Integer;
  ats : Real;

procedure nuskaitymas (var viso : Integer; var mas : Tmas);
var
  f : text;
  ck : integer;
begin
  assign (f, 'fc.in');
  reset (F);
  readln (f, viso);
  for ck := 1 to viso do
  readln (f, mas [ck, 1], mas [ck, 2]);
  close (f)
end;

procedure rikiuok (r1, r2 : integer; var mas : TMas; var kamp : Tkamp);
var
  v1, v2 : integer;
  pg, v : real;
begin
  v1 := r1;
  v2 := r2;
  v := kamp [(v1 + v2) div 2];
  repeat
    while kamp [v1] < v do inc (v1);
    while kamp [v2] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := mas [v1, 1];
      mas [v1, 1] := mas [v2, 1];
      mas [v2, 1] := pg;

      pg := mas [v2, 2];
      mas [v2, 2] := mas [v1, 2];
      mas [v1, 2] := pg;

      pg := kamp [v1];
      kamp [v1] := kamp [v2];
      kamp [v2] := pg;

      dec (v2);
      inc (v1)
    end
  until v1 > v2;
  if r1 < v2 then rikiuok (r1, v2, mas, kamp);
  if v1 < r2 then rikiuok (v1, r2, mas, kamp)
end;


procedure kampai (viso : Integer; var mas : TMas);
var
  kamp : Tkamp;
  ck : Integer;
  midx, midy : real;
begin
  midx := 0;
  midy := 0;
  for ck := 1 to viso do
  begin
    midx := midx + mas [ck, 1] / viso;
    midy := midy + mas [ck, 2] / viso
  end;

  for ck := 1 to viso do
  if mas [ck, 1] = midx then
  begin
    if mas [ck, 2] >= midy then kamp [ck] := pi / 2
                           else kamp [ck] := 3 * pi / 2
  end
  else
  if mas [ck, 1] > midx then
  begin
    if mas [ck, 2] >= midy then kamp [ck] := arctan (abs ((mas [ck, 2] - midy) / (mas [ck, 1] - midx)))
                           else kamp [ck] := 2 * pi - arctan ((abs (mas [ck, 2] - midy) / (mas [ck, 1] - midx)))
  end
  else
  if mas [ck, 2] >= midy then kamp [ck] := pi - arctan (abs ((mas [ck, 2] - midy) / (mas [ck, 1] - midx)))
                         else kamp [ck] := pi + arctan (abs ((mas [ck, 2] - midy) / (mas [ck, 1] - midx)));

  rikiuok (1, viso, mas, kamp)
end;

function galima (vx, vy, ux, uy : real) : boolean;
begin
  galima := (vx * uy - ux * vy) >= 0
end;

function atst (x1, y1, x2, y2 : real) : Real;
var
  dx, dy : real;
begin
  dx := x2 - x1;
  dy := y2 - y1;
  atst := sqrt (dx * dx + dy * dy)
end;

function rask (viso : Integer; var mas : Tmas) : real;
var
  hull : Tmas;
  nuo, ck, ilg : integer;
  ok : boolean;
  pg : real;
begin
  ilg := 2;
  hull [1, 1] := mas [1, 1];
  hull [1, 2] := mas [1, 2];
  hull [2, 1] := mas [2, 1];
  hull [2, 2] := mas [2, 2];

  for ck := 3 to viso do
  begin
    while (ilg >= 2) and not galima (hull [ilg, 1] - hull [ilg - 1, 1],
                                    hull [ilg, 2] - hull [ilg - 1, 2],
                                    mas [ck, 1] - hull [ilg, 1],
                                    mas [ck, 2] - hull [ilg, 2])
    do dec (ilg);

    inc (ilg);
    hull [ilg, 1] := mas [ck, 1];
    hull [ilg, 2] := mas [ck, 2]
  end;

  nuo := 1;
  ok := false;
  while not ok and (ilg - nuo >= 2) do
  begin
    ok := true;

    if not galima (hull [ilg, 1] - hull [ilg - 1, 1], hull [ilg, 2] - hull [ilg - 1, 2],
                   hull [nuo, 1] - hull [ilg, 1], hull [nuo, 2] - hull [ilg, 2]) then
    begin
      ok := false;
      dec (ilg)
    end;

    if not galima (hull [nuo, 1] - hull [ilg, 1], hull [nuo, 2] - hull [ilg, 2],
                   hull [nuo + 1, 1] - hull [nuo, 1], hull [nuo + 1, 2] - hull [nuo, 2]) then
    begin
      ok := false;
      inc (nuo)
    end

  end;

  pg := atst (hull [nuo, 1], hull [nuo, 2], hull [ilg, 1], hull [ilg, 2]);
  for ck := nuo to ilg - 1 do
  pg := pg + atst (hull [ck, 1], hull [ck, 2], hull [ck + 1, 1], hull [ck + 1, 2]);

  rask := pg
end;

procedure rasymas (ats : real);
var
  f : Text;
begin
  assign (f, 'fc.out');
  rewrite (f);
  writeln (f, ats :1 :2);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  kampai (viso, mas);
  ats := rask (viso, mas);
  rasymas (ats)
end.
