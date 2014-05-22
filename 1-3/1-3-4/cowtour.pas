{
ID: vkanapo001
PROG: cowtour
}

Program COWTOUR;

Type
  Tg = array [1 .. 150, 1 .. 150] of boolean;
  Tilgiai = array [1 .. 150, 1 .. 150] of real;
  Tkoord = array [1 .. 150, 1 .. 2] of longint;
  Tkuris = array [1 .. 150] of integer;

var
  viso : Integer;
  g : Tg;
  koord : Tkoord;
  ilg : Tilgiai;
  ats : Real;

function atst (v1, v2 : Longint) : real;
begin
  atst := sqrt (sqr (koord [v2, 1] - koord [v1, 1]) + sqr (koord [v2, 2] - koord [v1, 2]))
end;

procedure nuskaitymas (var viso : Integer; var koord : Tkoord;
                       var g : tg; var ilg : Tilgiai);
var
  f : Text;
  ck, ckx, cky : Integer;
  pg : Char;
begin
  assign (f, 'cowtour.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  readln (f, koord [ck, 1], koord [ck, 2]);
  for cky := 1 to viso do
  begin
    for ckx := 1 to viso do
    begin
      read (f, pg);
      g [ckx, cky] := pg = '1';
      if g [ckx, cky]
      then ilg [ckx, cky] := atst (ckx, cky)
      else ilg [ckx, cky] := -1
    end;
    readln (f)
  end;
  close (f)
end;

procedure daryk (var dist : Tilgiai);
var
  ck, ck1, ck2 : integer;
begin
  for ck1 := 1 to viso do
  for ck2 := 1 to viso do
  if ilg [ck1, ck2] = -1 then dist [ck1, ck2] := 100000
                         else dist [ck1, ck2] := ilg [ck1, ck2];

  for ck := 1 to viso do
  For ck1 := 1 to viso do
  For ck2 := ck1 + 1 to viso do
  if dist [ck1, ck] + dist [ck, ck2] < dist [ck1, ck2] then
  begin
    dist [ck1, ck2] := dist [ck1, ck] + dist [ck, ck2];
    dist [ck2, ck1] := dist [ck1, ck2]
  end
end;

function matuok (r1, r2, lyg1, lyg2 : integer; dist : Tilgiai;
                 var kuris : Tkuris; var ilg : Tilgiai) : real;
var
  didz : real;
  ck1, ck2 : integer;
begin
  dist [r1, r1] := 0;
  dist [r2, r2] := 0;
  For ck1 := 1 to viso do
  if kuris [ck1] = LYG1 then
  For ck2 := ck1 + 1 to viso do
  if kuris [ck2] = lyg2 then
  if dist [ck1, r1] + dist [r2, ck2] + ilg [r1, r2] < dist [ck1, ck2]
  then
  begin
    dist [ck1, ck2] := dist [ck1, r1] + dist [r2, ck2] + ilg [r1, r2];
    dist [ck2, ck1] := dist [ck1, ck2]
  end;

  didz := 0;
  for ck1 := 1 to viso do
  for ck2 := ck1 + 1 to viso do
  if (dist [ck1, ck2] <> 100000) and (dist [ck1, ck2] > didz) then didz := dist [ck1, ck2];

  matuok := didz
end;

procedure junk (var lyg : integer; var kuris : Tkuris);
var
  gal, uod, ck, ck1 : Integer;
  eil : array [1 .. 1000] of integer;
begin
  lyg := 0;
  for ck1 := 1 to viso do
  if kuris [ck1] = 0 then
  begin
    inc (lyg);
    kuris [ck1] := lyg;
    eil [1] := ck1;
    gal := 1;
    uod := 2;
    while gal < uod do
    begin
      for ck := 1 to viso do
      if g [eil [gal], ck] and (kuris [ck] = 0) then
      begin
        kuris [ck] := lyg;
        eil [uod] := ck;
        inc (uod)
      end;
      inc (gal)
    end
  end
end;

function varyk : real;
var
  min, pg : real;
  ckLYG1, ckLYG2, visoLyg, ck1, ck2 : integer;
  kuris : Tkuris;
  dist : Tilgiai;
begin
  fillchar (kuris, sizeof (kuris), 0);
  junk (visoLyg, kuris);
  daryk (dist);

  min := 0;
  for ckLYG1 := 1 to visoLyg - 1 do
{}  for ckLYG2 := ckLYG1 + 1 to {visoLYG}ckLYG1+1 do { cia pasukciavau }
  for ck1 := 1 to viso do { pirmo elem virsunes }    { imdamas tik gretimus }
  if kuris [ck1] = ckLYG1 then                       { elementus }
  for ck2 := 1 to viso do { antro elem virsunes }
  if kuris [ck2] = ckLYG2 then
  begin
    g [ck1, ck2] := true;
    g [ck2, ck1] := true;
    ilg [ck1, ck2] := atst (ck1, ck2);
    ilg [ck2, ck1] := ilg [ck1, ck2];
    pg := matuok (ck1, ck2, ckLYG1, ckLYG2, DIST, kuris, ilg);
    if (min = 0) or (pg < min) then min := pg;
    g [ck1, ck2] := false;
    g [ck2, ck1] := false;
    ilg [ck1, ck2] := -1;
    ilg [ck2, ck1] := -1
  end;
  varyk := min
end;

procedure rasymas (ats : real);
var
  f : Text;
begin
  assign (f, 'cowtour.out');
  rewrite (f);
  writeln (f, ats :0 :6);
  close (f)
end;

begin
  nuskaitymas (viso, koord, g, ilg);
  ats := varyk;
  rasymas (ats)
end.
