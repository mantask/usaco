{
PROG: popular
LANG: PASCAL
}

Program POPULAR;

type
  Tmas = array [1 .. 50000, 1 .. 2] of integer;

var
  ats : longint;

function maz (sk11, sk12, sk21, sk22 : integer) : boolean;
begin
  if (sk11 < sk21) or ((sk11 = sk21) and (sk12 < sk22))
  then maz := true
  else maz := false
end;

function lygu (sk11, sk12, sk21, sk22 : integer) : boolean;
begin
  if (sk11 = sk21) and (sk12 = sk22)
  then lygu := true
  else lygu := false
end;

function yra (sk1, sk2 : integer; ilg : integer; var mas : Tmas) : integer;
var
  v1, v2, v : integer;
begin
  v1 := 1; v2 := ilg;
  v := (v1 + v2) div 2;
  while v1 < v2 do
  begin
    if maz (sk1, sk2, mas [v, 1], mas [v, 2])
    then v2 := v
    else v1 := v;
    v := (v1 + v2) div 2
  end;
  yra := lygu (sk1, sk2, mas [v, 1], mas [v, 2])
end;

Procedure nuskaitymas (var ats : longint);
var
  f : Text;
  ck, kiek : longint;
  sum : array [1 .. 10000] of integer;
  sk1, sk2, pg : integer;
begin
  assign (f, 'popular.in');
  reset (f);
  readln (f, viso, kiek);
  fillchar (sum, sizeof (sum), 0);
  for ck := 1 to kiek do
  begin
    readln (f, sk1, sk2);
    if (viso = 0) or not yra (sk1, sk2, viso, mas) then
    begin
      inc (viso);
      prijunk (sk1, sk2, viso, mas);
      pg := mas [sk1];
      sum [sk1] := sum [sk1] + 1 + sum [sk2];
      sum [sk2] := sum [sk2] + 1 + sum [sk2]
    end;
  end;
  close (f);

  kiek := 0;
  for ck := 1 to viso do
  if sum [ck] = viso - 1 then inc (kiek);
  ats := kiek
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'popular.out');
  rewrite (f);
  writeln (f, popular);
  close (f)
end;

begin
  nuskaitymas (ats);
  rasymas (ats)
end.
