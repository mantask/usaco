{
ID: vkanapo001
PROG: telecow
}

Program TELECOW;

type
  Tmas = array [1 .. 200, 1 .. 200] of integer;
  Tats = array [1 .. 100] of integer;
  Tgalima = array [1 .. 100] of boolean;

var
  viso, atsKIEK, v1, v2 : Integer;
  mas : Tmas;
  ats : Tats;

procedure nuskaitymas (var viso, v1, v2 : Integer; var mas : Tmas);
var
  f : text;
  ck, kiek, pg1, pg2 : Integer;
begin
  assign (f, 'telecow.in');
  reset (f);
  readln (f, viso, kiek, v1, v2);
  for ck := 1 to viso do
  begin
    mas [2 * ck, 2 * ck - 1] := 1;
    mas [2 * ck - 1, 2 * ck] := 1;
  end;
  for ck := 1 to kiek do
  begin
    readln (f, pg1, pg2);
    mas [2 * pg1, 2 * pg2 - 1] := 1;
    mas [2 * pg2, 2 * pg1 - 1] := 1
  end;
  close (f)
end;

procedure rasymas (atskiek : Integer; var ats : Tats);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'telecow.out');
  rewrite (f);
  writeln (f, atskiek);
  for ck := 1 to atskiek - 1 do
  write (f, ats [ck], ' ');
  writeln (f, ats [atskiek]);
  close (f)
end;

function min (sk1, sk2 : Integer) : Integer;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

function maxsrautas (var galima : Tgalima; mas : Tmas) : Integer;
var
  ck, pg, srautas : integer;
  sr, ish : array [1 .. 200] of integer;
  jau : array [1 .. 200] of boolean;
begin
  srautas := 0;

  while true do
  begin
    for ck := 1 to viso do
    begin
      jau [2 * ck] := not galima [ck];
      jau [2 * ck - 1] := not galima [ck]
    end;
    fillchar (ish, sizeof (ish), 0);
    fillchar (sr, sizeof (sr), 0);
    sr [2 * v1] := maxint;

    while true do
    begin
      pg := 0;
      for ck := 1 to 2 * viso do
      if not jau [ck] and ((pg = 0) or (sr [ck] > sr[pg])) and (sr[ck] > 0) then pg := ck;

      if (pg = 0) or (pg = 2 * v2 - 1) then break;

      jau [pg] := true;

      for ck := 1 to 2 * viso do
      if (mas [pg, ck] <> 0) and (sr [ck] < min (sr[pg], mas[pg, ck])) then
      begin
        ish [ck] := pg;
        sr [ck] := min (sr[pg], mas[pg, ck])
      end
    end;

    if (pg = 0) then break;

    srautas := srautas + sr[pg];

    while pg <> 2 * v1 do
    begin
      mas[pg, ish[pg]] := mas[pg, ish[pg]] + srautas;
      mas[ish[pg], pg] := mas[ish[pg], pg] - srautas;
      pg := ish[pg]
    end
  end;

  maxsrautas := srautas
end;

procedure rask (var atskiek : Integer; var ats : Tats);
var
  ck, v, naujas, senas : integer;
  galima : Tgalima;
begin
  for ck := 1 to viso do
  galima [ck] := true;

  senas := maxsrautas (galima, mas);

  v := 0;
  while senas <> 0 do
  begin

    repeat
      inc (v);
      while (v = v1) or (v = v2) do inc (v);
      galima [v] := false;
      naujas := maxsrautas (galima, mas);
      galima [v] := true
    until senas <> naujas;

    senas := naujas;
    galima [v] := false;

    inc (atsKIEK);
    ats[atsKIEK] := v
  end
end;


begin
  nuskaitymas (viso, v1, v2, mas);
  rask (atskiek, ats);
  rasymas (atsKIEK, ats)
end.
