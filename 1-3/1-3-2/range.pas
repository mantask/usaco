{
ID: vkanapo001
PROG: range
}

Program RANGE;

type
  Ttalpa = array [1 .. 250] of longint;
  Tmas = array [1 .. 250, 1 .. 250] of boolean;
  Tkiek = array [1 .. 250, 1 .. 250] of byte;

var
  talpa : Ttalpa;
  mas : Tmas;
  kiek : Tkiek;
  ilg : Integer;

procedure nuskaitymas (var ilg : Integer; var mas : Tmas);
var
  f : Text;
  ckx, cky : Integer;
  c : char;
begin
  assign (f, 'range.in');
  reset (f);
  readln (f, ilg);
  for cky := 1 to ilg do
  begin
    for ckx := 1 to ilg do
    begin
      read (f, c);
      if c = '1' then mas [ckx, cky] := true
                 else mas [ckx, cky] := false
    end;
    readln (f)
  end;
  close (f)
end;

function max (x, y : Integer; var kiek : Tkiek) : byte;
var
  pg : byte;
begin
  pg := 0;
  if (x > 1) and (kiek [x - 1, y] > pg) then pg := kiek [x - 1, y];
  if y > 1 then
  begin
    y := y - 1;
    if (x > 1) and (kiek [x - 1, y] > pg) then pg := kiek [x - 1, y];
    if kiek [x, y] > pg then pg := kiek [x, y]
  end;
  if pg > 0 then max := pg - 1
            else max := 0
end;

function didink (x, y, kiek : Integer) : byte;
var
  ck, l : Integer;
  ok : boolean;
begin
  ok := true;
  l := kiek;
  while ok and (l + x - 1 < ilg) and (l + y - 1 < ilg) do
  begin
    inc (l);
    for ck := x to x + l - 1 do
    if not mas [ck, y + l - 1] then
    begin
      ok := false;
      break
    end;
    if ok then
    for ck := y to y + l - 1 do
    if not mas [x + l - 1, ck] then
    begin
      ok := false;
      break
    end
  end;
  if not ok then dec (l);
  didink := l
end;

procedure pildyk (var kiek : Tkiek);
var
  ckx, cky : Integer;
begin
  fillchar (kiek, sizeof (kiek), 0);
  for cky := 1 to ilg do
  for ckx := 1 to ilg do
  if mas [ckx, cky] then
  kiek [ckx, cky] := didink (ckx, cky, max (ckx, cky, kiek))
end;

procedure skaiciuok (var talpa : Ttalpa);
var
  ck, ckx, cky : Integer;
begin
  for ckx := 1 to ilg do
  for cky := 1 to ilg do
  for ck := 2 to kiek [ckx, cky] do
  inc (talpa [ck])
end;

procedure rasymas (var talpa : Ttalpa);
var
  f : text;
  ck : Integer;
begin
  assign (f, 'range.out');
  rewrite (f);
  ck := 2;
  while (ck <= ilg) and (talpa [ck] <> 0) do
  begin
    writeln (f, ck, ' ', talpa [ck]);
    inc (ck)
  end;
  close (f)
end;

begin
  nuskaitymas (ilg, mas);
  pildyk (kiek);
  skaiciuok (talpa);
  rasymas (talpa)
end.
