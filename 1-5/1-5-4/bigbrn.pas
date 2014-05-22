{
ID: vkanapo001
PROG: bigbrn
}

Program BIGBRN;

type
  Tmed = array [1 .. 10000] of record
    x, y : integer
  end;
  Tmas = array [0 .. 1000, 0 .. 1000] of integer;

var
  med : Tmed;
  ats, ilg, viso : integer;

procedure nuskaitymas (var ilg, viso : integer; var med : Tmed);
var
  f : text;
  ck : integer;
begin
  assign (f, 'bigbrn.in');
  reset (f);
  readln (f, ilg, viso);
  for ck := 1 to viso do
  readln (f, med [ck].x, med[ck].y);
  close (f)
end;

Procedure quicksort (r1, r2 : Integer; var mas : Tmed);
var
  v1, v2, v, pg : Integer;
begin
  v1 := r1; v2 := r2; v := mas [(v1 + v2) div 2].y;
  repeat
    while mas [v1].y < v do inc (v1);
    while mas [v2].y > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := mas [v1].y; mas [v1].y := mas [v2].y; mas [v2].y := pg;
      pg := mas [v1].x; mas [v1].x := mas [v2].x; mas [v2].x := pg;
      inc (v1); dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then quicksort (v1, r2, mas);
  if r1 < v2 then quicksort (r1, v2, mas)
end;

function rask (ilg, viso : Integer; var med : Tmed) : Integer;
var
  mas : ^Tmas;
  ats, pg, ck, ckx, cky : Integer;
begin
  ck := 1;
  new (mas);
  fillchar (mas^, sizeof (Tmas), 0);
  ats := 0;
  for cky := 1 to ilg do
  begin
    while (ck <= viso) and (med [ck].y = cky) do
    begin
      mas^ [med[ck].x, cky] := -1;
      inc (ck)
    end;
    for ckx := 1 to ilg do
    if mas^ [ckx, cky] = -1 then mas^ [ckx, cky] := 0
    else
    begin
      pg := mas^ [ckx - 1, cky];
      if mas^ [ckx - 1, cky - 1] < pg then pg := mas^ [ckx - 1, cky - 1];
      if mas^ [ckx, cky - 1] < pg then pg := mas^ [ckx, cky - 1];
      mas^ [ckx, cky] := pg + 1;

      if pg + 1 > ats then ats := pg + 1
    end
  end;

  dispose (mas);

  rask := ats
end;

procedure rasymas (ats : integer);
var
  f : text;
begin
  assign (f, 'bigbrn.out');
  rewrite (f);
  writeln (f, ats);
  close (F)
end;

begin
  nuskaitymas (ilg, viso, med);
  quicksort (1, viso, med);
  ats := rask (ilg, viso, med);
  rasymas (ats)
end.
