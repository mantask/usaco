{
ID: vkanapo001
PROG: buylow
}

Program BUYLOW;

type
  Tmas = array [1 .. 5000] of longint;
  Tjau = array [1 .. 5000] of boolean;
  Tkiek = array [1 .. 100] of 0 .. 9;

var
  mas : Tmas;
  ilg1, ilg, viso : Integer;
  kiek : Tkiek;

procedure nuskaitymas (var viso : integer; var mas : Tmas);
var
  f : Text;
  min, ck : Integer;
  pg : longint;
begin
  min := 0;
  assign (f, 'buylow.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    read (f, pg);
    if (ck > 1) and (mas [ck - 1 - min] = pg) then inc (min)
                                              else mas [ck - min] := pg;
  end;
  dec (viso, min);
  close (f)
end;

function ok (kuris : Integer; var jau : Tjau) : boolean;
var
  ck : Integer;
begin
  for ck := kuris + 1 to viso do
  if jau [ck] and (mas [kuris] = mas [ck]) then
  begin
    ok := false;
    exit
  end;
  ok := true
end;

procedure pad (var ilg1, ilg2 : Integer; var sk1, sk2 : Tkiek);
var
  pg, ck : Integer;
begin
  pg := 0;
  if ilg2 > ilg1 then ilg1 := ilg2;
  for ck := 1 to ilg1 do
  begin
    pg := sk1 [ck] + sk2 [ck] + pg;
    sk1 [ck] := pg mod 10;
    pg := pg div 10
  end;
  if pg <> 0 then
  begin
    inc (ilg1, 1);
    sk1 [ilg1] := 1
  end
end;

procedure rask (var Maxilg, ilgis : integer; var kiek : Tkiek; viso : Integer; var mas : TMAS);
var
  pg, ck1, ck2, ck : Integer;
  prat : array [1 .. 5000] of Tkiek;
  ilg, ilg1 : array [1 .. 5000] of integer;
  jau : Tjau;
  oki : boolean;
begin
  fillchar (ilg, sizeof (ilg), 0);
  fillchar (prat, sizeof (ilg), 0);
  maxilg := 1;
  for ck1 := 1 to viso do
  begin
    pg := 0;
    prat [ck1, 1] := 1;
    ilg1 [ck1] := 1;
    for ck2 := ck1 - 1 downto 1 do
    if mas [ck1] < mas [ck2] then
    if ilg [ck2] > pg then
    begin
      pg := ilg [ck2];
      prat [ck1] := prat [ck2];
      ilg1 [ck1] := ilg1 [ck2]
    end
    else
    if (pg <> 0) and (ilg [ck2] = pg) then
    begin
      oki := true;
      for ck := ck2 + 1 to ck1 - 1 do
      if (mas [ck] = mas [ck2]) and (ilg [ck] = pg) then
      begin
        oki := false;
        break
      end;
      if oki then pad (ilg1 [ck1], ilg1 [ck2], prat [ck1], prat [ck2])
    end;

    if pg = 0 then ilg [ck1] := 1
              else ilg [ck1] := pg + 1;
    if ilg [ck1] > maxilg then maxilg := ilg [ck1]
  end;
  fillchar (kiek, sizeof (kiek), 0);
  ilgis := 0;
  fillchar (jau, sizeof (jau), 0);
  for ck1 := viso downto 1 do
  if (ilg [ck1] = maxilg) and ok (ck1, jau) then
  begin
    pad (ilgis, ilg1 [ck1], kiek, prat [ck1]);
    jau [ck1] := true
  end
end;

procedure rasymas (ilg, ilg1 : Integer; var kiek : Tkiek);
var
  f : TExt;
  ck : Integer;
begin
  assign (f, 'buylow.out');
  rewrite (f);
  write (f, ilg, ' ');
  for ck := ilg1 downto 1 do
  write (f, kiek [ck]);
  writeln (f);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  rask (ilg, ilg1, kiek, viso, mas);
  rasymas (ilg, ilg1, kiek)
end.
