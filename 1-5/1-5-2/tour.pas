{
ID: vkanapo001
PROG: tour
}

Program TOUR;

type
  Tpav = array [1 .. 100] of string;
  Tmas = array [1 .. 100, 0 .. 100] of boolean;

var
  viso, ats : integer;
  mas : Tmas;

function poz (eil : string; viso : Integer; var pav : Tpav) : integer;
var
  cK : integer;
begin
  for ck := 1 to viso do
  if pav [ck] = eil then break;
  poz := ck
end;

procedure nuskaitymas (var viso : Integer; var mas : Tmas);
var
  f : Text;
  tarpas, poz1, poz2, kiek, ck : INteger;
  eil : string;
  pav : Tpav;
begin
  fillchar (mas, sizeof (mas), 0);
  assign (f, 'tour.in');
  reset (f);
  readln (f, VISO, kiek);
  for ck := 1 to viso do
  readln (f, pav [ck]);
  for ck := 1 to kiek do
  begin
    readln (f, eil);
    tarpas := pos (' ', eil);
    poz1 := poz (copy (eil, 1, tarpas - 1), viso, pav);
    poz2 := poz (copy (eil, tarpas + 1, length (eil) - tarpas), viso, pav);

    mas [poz1, poz2] := true;
    mas [poz2, poz1] := true

  end;
  close (f)
end;

function rask (var mas : Tmas) : Integer;
var
  eil : array [1 .. 100000, 1 .. 3] of integer;
  jau : array [1 .. 100, 1 .. 100] of integer;
  ilg, ck, uod, gal : longint;
begin
  fillchar (jau, sizeof (jau), 0);
  ilg := 1;
  gal := 1;
  uod := 1;
  for ck := 1 to viso do
  if mas [1, ck] then
  begin
    jau [1, ck] := 2;
    jau [ck, 1] := 2;
    eil [uod, 1] := 1;
    eil [uod, 2] := ck;
    eil [uod, 3] := 2;
    inc (uod);
  end;

  while gal < uod do
  begin
    if eil [gal, 1] < eil [gal, 2] then
    begin
      for ck := eil [gal, 1] + 1 to viso do
      if (ck <> eil [gal, 2]) and mas [eil [gal, 1], ck] and (jau [ck, eil [gal, 2]] < eil [gal, 3] + 1) then
      begin
        jau [ck, eil [gal, 2]] := eil [gal, 3] + 1;
        jau [eil [gal, 2], ck] := eil [gal, 3] + 1;
        eil [uod, 1] := ck;
        eil [uod, 2] := eil [gal, 2];
        eil [uod, 3] := eil [gal, 3] + 1;
        inc (uod)
      end;
      if (eil [gal, 2] = viso) and mas [eil [gal, 1], viso] and (eil [gal, 3] > ilg)
      then ilg := eil [gal, 3]
    end
    else
    begin
      for ck := eil [gal, 2] + 1 to viso do
      if (ck <> eil [gal, 1]) and mas [eil [gal, 2], ck] and (jau [ck, eil [gal, 2]] < eil [gal, 3] + 1) then
      begin
        jau [ck, eil [gal, 1]] := eil [gal, 3] + 1;
        jau [eil [gal, 1], ck] := eil [gal, 3] + 1;
        eil [uod, 1] := eil [gal, 1];
        eil [uod, 2] := ck;
        eil [uod, 3] := eil [gal, 3] + 1;
        inc (uod)
      end;
      if (eil [gal, 1] = viso) and mas [eil [gal, 2], viso] and (eil [gal, 3] > ilg)
      then ilg := eil [gal, 3]
    end;
    inc (gal)
  end;

  rask := ilg
end;

procedure rasymas (ats : Integer);
var
  f : Text;
begin
  assign (f, 'tour.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  ats := rask (mas);
  rasymas (ats)
end.
