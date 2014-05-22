{
ID: vkanapo001
PROG: crypt1
}

Program CRYPT1;

type
  Tmas = array [1 .. 9] of integer;
  Tpor = array [1 .. 81, 1 .. 2] of integer;
  Taib = set of 1 .. 9;

var
  viso, ilg2 : integer;
  ats : longint;
  aib : Taib;
  por : Tpor;
  mas : Tmas;

procedure nuskaitymas (var viso : integer; var aib : Taib; var mas : Tmas);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'crypt1.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    read (F, mas [ck]);
    aib := aib + [mas [ck]]
  end;
  close (f)
end;

procedure gen2 (gyl, sk1, sk2 : Integer; var ilg : Integer; var por : Tpor);
var
  ck : integer;
begin
  if gyl = 2 then
  begin
    inc (ilg);
    por [ilg, 1] := sk1;
    por [ilg, 2] := sk2;
    exit
  end;
  if gyl = 0 then
  for ck := 1 to viso do
  gen2 (gyl + 1, mas [ck], 0, ilg, por)
  else
  for ck := 1 to viso do
  gen2 (gyl + 1, sk1, mas [ck], ilg, por)
end;

function tikrink (sk : Longint) : boolean;
var
  ok : boolean;
begin
  ok := true;
  while ok and (sk <> 0) do
  begin
    if not (sk mod 10 in aib) then ok := false;
    sk := sk div 10
  end;
  tikrink := ok
end;

procedure gen3 (gyl, sk1, sk2, sk3 : integer; var ats : longint);
var
  ck : Integer;
  pg, pg1, pg2, pg3 : Longint;
begin
  if gyl = 3 then
  begin
    for ck := 1 to ilg2 do
    begin
      pg := sk1 * 100 + sk2 * 10 + sk3;
      pg1 := pg * por [ck, 1];
      pg2 := pg * por [ck, 2];
      pg3 := pg1 + 10 * pg2;
      if (pg1 < 1000) and (pg2 < 1000) and (pg3 < 10000) and
         tikrink (pg1) and tikrink (pg2) and tikrink (pg3)
      then inc (ats)
    end;
    exit
  end;

  if gyl = 2 then
  for ck := 1 to viso do
  gen3 (gyl + 1, sk1, sk2, mas [ck], ats)
  else
  if gyl = 1 then
  for ck := 1 to viso do
  gen3 (gyl + 1, sk1, mas [ck], 0, ats)
  else
  if gyl = 0 then
  for ck := 1 to viso do
  gen3 (gyl + 1, mas [ck], 0, 0, ats)
end;

procedure rasymas (ats : longint);
var
  f : Text;
begin
  assign (f, 'crypt1.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  aib := [];
  nuskaitymas (viso, aib, mas);
  ilg2 := 0;
  gen2 (0, 0, 0, ilg2, por);
  ats := 0;
  gen3 (0, 0, 0, 0, ats);
  rasymas (ats);
end.
