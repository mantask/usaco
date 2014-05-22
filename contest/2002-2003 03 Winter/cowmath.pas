{
PROG: cowmath
LANG: PASCAL
}

Program COWMATH;

Type
  TG = Array [1 .. 25, 1 .. 25] of integer;

var
  G : Tg;
  viso : Integer;
  ats : longint;

Procedure nuskaitymas (var viso : INTeger; var G : Tg);
var
  f : Text;
  ck1, ck2 : integer;
begin
  assign (f, 'cowmath.in');
  reset (f);
  readln (f, viso);
  for ck1 := 1 to viso do
  begin
    for ck2 := 1 to viso do
    read (f, g [ck1, ck2]);
    readln (f)
  end;
  close (f)
end;

function DBD (x, y : Integer) : integer;
begin
  if x = 0 then dbd := y
           else dbd := dbd (y mod x, x)
end;

function rask : longint;
var
  mbk : longint;
  kiek, ck, gal, uod : INteger;
  eil : array [1 .. 1000] of integer;
  dal, atst : array [1 .. 25] of longint;
  jau : array [1 .. 25] of boolean;
begin
  fillchar (Atst, sizeof (atst), $FF);
  fillchar (jau, sizeof (jau), 0);
  kiek := 0;
  gal := 1;
  uod := 1;
  for ck := 1 to viso do
  if g [1, ck] <> 0 then
  begin
    if ck <> 2 then
    begin
      atst [ck] := g [1, ck];
      eil [uod] := ck;
      inc (uod)
    end
    else
    begin
      inc (kiek);
      dal [kiek] := g [1, 2]
    end
  end;
  jau [1] := true;

  while gal < uod do
  begin
    for ck := 1 to viso do
    if (g [eil [gal], ck] <> 0) and not jau [ck] then
    begin
      if ck <> 2 then
      begin
        atst [ck] := dbd (atst [eil [gal]], g [eil [gal], ck]);
        eil [uod] := ck;
        inc (uod)
      end
      else
      begin
        inc (kiek);
        dal [kiek] := dbd (atst [eil [gal]], g [eil [gal], 2])
      end
    end;
    inc (gal)
  end;
  mbk := dal [1];
  for ck := 2 to kiek do
  mbk := mbk * dal [ck] div dbd (mbk, dal [ck]);
  rask := mbk
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'cowmath.out');
  rewrite (f);
  writeln (f, ats );
  close (f)
end;

begin
  nuskaitymas (viso, g);
  ats := rask;
  rasymas (ats)
end.
