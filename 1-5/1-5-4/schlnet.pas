{
ID: vkanapo001
PROG: schlnet
}

Program SCHLENT;

type
  Tmas = array [1 .. 100, 0 .. 100] of integer;
  Tbuvo = array [1 .. 100] of boolean;
  Tjau = ARRAY [1 .. 100] of Tbuvo;
  Tpoz = array [1 .. 100] of record
    kiek, poz : integer
  end;

var
  mas, masT : Tmas;
  ats1, ats2, viso : integer;

procedure nuskaitymas (var viso : integer; var mas, masT : Tmas);
var
  f : text;
  ck, pg : integer;
begin
  for ck := 1 to viso do
  mast [ck, 0] := 0;

  assign (f, 'schlnet.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    mas [ck, 0] := 0;
    read (f, pg);
    while pg <> 0 do
    begin
      inc (mas [ck, 0]);
      mas [ck, mas [ck, 0]] := pg;
      inc (masT [pg, 0]);
      masT [pg, masT [pg, 0]] := ck;
      read (f, pg)
    end;
    readln (f)
  end;
  close (f)
end;

Procedure quicksort (r1, r2 : Integer; var kiek : Tpoz);
var
  v1, v2, v, pg : Integer;
begin
  v1 := r1;
  v2 := r2;
  v := kiek [(v1 + v2) div 2].kiek;
  repeat
    while kiek [v1].KIEK > v do inc (v1);
    while kiek [v2].kiek < v do dec (v2);
    if v1 <= v2 then
    begin
      pg := kiek [v1].KIEK; kiek [v1].kiek := kiek [v2].kiek; kiek [v2].kiek := pg;
      pg := kiek [v1].poz; kiek [v1].poz := kiek [v2].poz; kiek [v2].poz := pg;
      inc (v1);  dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then quicksort (v1, r2, kiek);
  if r1 < v2 then quicksort (r1, v2, kiek)
end;

procedure lisk (v : integer; var kiek : integer; var jau : Tbuvo; var mas : Tmas);
var
  ck : integer;
begin
  inc (kiek);
  jau [v] := true;
  for ck := 1 to mas[v, 0] do
  if not jau [mas[v,ck]] then
  lisk (mas[v,ck], kiek, jau, mas)
end;

procedure rask (viso : integer; var mas : Tmas; var atsA, atsB : INteger);
var
  ck, ck1 : Integer;
  kiek : Tpoz;
  buvo : Tbuvo;
  jau : Tjau;
begin
  fillchar (kiek, sizeof (kiek), 0);
  fillchar (jau, sizeof (jau), 0);
  for ck := 1 to viso do
  lisk (ck, kiek[ck].kiek, jau[ck], mas);

  for ck := 1 to viso do kiek [ck].poz := ck;
  quicksort (1, viso, kiek);

  fillchar (buvo, sizeof (buvo), 0);
  atsA := 0;
  for ck := 1 to viso do
  if not buvo [kiek [ck].poz] then
  begin
    inc (atsA);
    for ck1 := 1 to viso do
    buvo [ck1] := buvo [ck1] OR jau [kiek[ck].poz, ck1]
  end;

  atsB := 0;
  for ck := 1 to viso do
  if kiek[ck].kiek <> viso then
  begin
    atsB := 1;
    break
  end;
  if atsB = 0 then exit;

  fillchar (kiek, sizeof (kiek), 0);
  fillchar (jau, sizeof (jau), 0);
  for ck := 1 to viso do
  lisk (ck, kiek[ck].kiek, jau[ck], masT);

  for ck := 1 to viso do kiek [ck].poz := ck;
  quicksort (1, viso, kiek);

  fillchar (buvo, sizeof (buvo), 0);
  atsB := 0;
  for ck := 1 to viso do
  if not buvo [kiek [ck].poz] then
  begin
    inc (atsB);
    for ck1 := 1 to viso do
    buvo [ck1] := buvo [ck1] OR jau [kiek[ck].poz, ck1]
  end;

  if atsA > atsB then atsB := atsA
end;

procedure rasymas (ats1, ats2 : Integer);
var
  f : Text;
begin
  assign (f, 'schlnet.out');
  rewrite (f);
  writeln (f, ats1);
  writeln (f, ats2);
  close (f)
end;

begin
  nuskaitymas (viso, mas, masT);
  rask (viso, mas, ats1, ats2);
  rasymas (ats1, ats2)
end.
