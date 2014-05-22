{
ID: vkanapo001
PROG: agrinet
}

Program AGRINET;

type
  Tg = array [1 .. 100, 1 .. 100] of longint;
  Tmas = array [1 .. 100] of longint;

var
  ats : longint;
  viso : Integer;
  g : Tg;

procedure nuskaitymas (var viso : Integer; var G : Tg);
var
  f : Text;
  ckx, cky : Integer;
begin
  assign (f, 'agrinet.in');
  reset (f);
  readln (f, viso);
  for cky := 1 to viso do
  begin
    for ckx := 1 to viso do
    read (f, G [ckx, cky]);
    readln (f)
  end;
  close (f)
end;

function rask : Longint;
var
  atst : Tmas;
  jau : array [1 .. 100] of boolean;
  pg, dydis, ck : integer;
  kaina : longint;
begin
  for ck := 1 to viso do
  begin
    atst [ck] := maxlongint;
    jau [ck] := false
  end;
  atst [1] := 0;
  jau [1] := true;
  kaina := 0;
  dydis := 1;
  for ck := 1 to viso do
  if g [1, ck] > 0 then
  atst [ck] := g [1, ck];

  while dydis < viso do
  begin
    pg := -1;
    for ck := 1 to viso do
    if (not jau [ck]) and ((pg = -1) or (atst [ck] < atst [pg])) then pg := ck;

    inc (dydis);
    inc (kaina, atst [pg]);
    jau [pg] := true;

    for ck := 1 to viso do
    if not jau [ck] and (G [pg, ck] > 0) and (atst [ck] > G [pg, ck])
    then atst [ck] := G [pg, ck]
  end;

  rask := kaina
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'agrinet.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, g);
  ats := rask;
  rasymas (ats)
end.
