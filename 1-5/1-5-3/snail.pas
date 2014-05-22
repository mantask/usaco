{
ID: vkanapo001
PROG: snail
}

program SNAIL;

const
  xx : array [1 .. 4] of integer = (0, 1, 0, -1);
  yy : array [1 .. 4] of integer = (-1, 0, 1, 0);

Type
  Tmas = array [1 .. 120, 1 .. 120] of byte;

var
  mas : Tmas;
  ats, viso : Integer;

procedure nuskaitymas (var viso : Integer; var mas : TMas);
var
  f : Text;
  pg, ck, kiek : Integer;
  c : char;
begin
  fillchar (mas, sizeof (mas), 0);
  assign (f, 'snail.in');
  reset (f);
  readln (f, viso, kiek);
  for ck := 1 to kiek do
  begin
    readln (f, c, pg);
    mas [pg, ord (c) - ord ('A') + 1] := 1
  end;
  close (f)
end;

procedure lisk (x, y, kr, ilg : integer; var maxILG : integer);
var
  x1, y1, kr1 : integer;
label
  next;
begin
  x1 := x + xx [kr];
  y1 := y + yy [kr];
  while (1 <= x1) and (x1 <= viso) and
        (1 <= y1) and (y1 <= viso) and
        (mas [x1, y1] = 0) do
  begin
    x := x1;
    y := y1;
    mas [x, y] := 2;
    inc (ilg);
    x1 := x + xx [kr];
    y1 := y + yy [kr];
  end;

  if ilg > maxILG then maxILG := ilg;

  if (1 <= x1) and (x1 <= viso) and
     (1 <= y1) and (y1 <= viso) and
     (mas [x1, y1] = 2)
  then goto next;


  kr1 := kr mod 4 + 1;
  x1 := x + xx [kr1];
  y1 := y + yy [kr1];
  if (1 <= x1) and (x1 <= viso) and
     (1 <= y1) and (y1 <= viso) and
     (mas [x1, y1] = 0)
  then lisk (x, y, kr1, ilg, maxILG);

  kr1 := (kr + 2) mod 4 + 1;
  x1 := x + xx [kr1];
  y1 := y + yy [kr1];
  if (1 <= x1) and (x1 <= viso) and
     (1 <= y1) and (y1 <= viso) and
     (mas [x1, y1] = 0)
  then lisk (x, y, kr1, ilg, maxILG);

next:
  x1 := x - xx [kr];
  y1 := y - yy [kr];
  while (1 <= x1) and (x1 <= viso) and
        (1 <= y1) and (y1 <= viso) and
        (mas [x1, y1] = 2) do
  begin
    mas [x, y] := 0;
    dec (ilg);
    x := x1;
    y := y1;
    x1 := x - xx [kr];
    y1 := y - yy [kr];
  end
end;

function rask (viso : Integer; var mas : Tmas) : Integer;
var
  maxILG : Integer;
begin
  maxILG := 0;
  mas [1, 1] := 2;
  lisk (1, 1, 2, 1, maxilg);
  lisk (1, 1, 3, 1, maxilg);
  rask := maxilg
end;

procedure rasymas (ats : Integer);
var
  f : text;
begin
  assign (f, 'snail.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  ats := rask (viso, mas);
  rasymas (ats)
end.
