{
ID: vkanapo001
PROG: heritage
}

Program HERITAGE;

Type
  Teil = array [1 .. 26] of char;
  Tmas = array ['A' .. 'Z'] of integer;
  Tmed = array ['A' .. 'Z', 1 .. 2] of char;

var
  poz, ilg : integer;
  eil : Teil;
  mas : Tmas;
  med : Tmed;

procedure nuskaitymas (var ilg : Integer; var eil : Teil; var mas : Tmas);
var
  ck : Integer;
  c : char;
  f : Text;
begin
  assign (f, 'heritage.in');
  reset (f);
  ck := 0;
  while not eoln (f) do
  begin
    inc (ck);
    read (f, c);
    mas [c] := ck
  end;
  ilg := ck;
  readln (f);
  for ck := 1 to ilg do
  read (f, eil [ck]);
  close (f)
end;

procedure lisk (c : Char; var poz : integer; r1, r2 : integer; var med : Tmed);
begin
  if r1 >= r2 then exit;
  inc (poz);
  if not ((mas [eil [poz]] >= r1) and (mas [eil [poz]] <= r2)) then
  begin
    dec (poz);
    exit
  end;
  if mas [eil [poz]] < mas [c] then
  begin
    med [c, 1] := eil [poz];
    lisk (eil [poz], poz, r1, mas [c] - 1, med)
  end
  else dec (poz);
  inc (poz);
  if not ((mas [eil [poz]] >= r1) and (mas [eil [poz]] <= r2)) then
  begin
    dec (poz);
    exit
  end;
  if mas [eil [poz]] > mas [c] then
  begin
    med [c, 2] := eil [poz];
    lisk (eil [poz], poz, mas [c] + 1, r2, med)
  end
  else dec (poz)
end;

procedure rasyk (var f : Text; c : char);
begin
  if ord (med [c, 1]) <> 0 then rasyk (f, med [c, 1]);
  if ord (med [c, 2]) <> 0 then rasyk (f, med [c, 2]);
  write (f, c)
end;

procedure rasymas;
var
  f : Text;
begin
  assign (f, 'heritage.out');
  rewrite (f);
  rasyk (f, eil [1]);
  writeln (f);
  close (f)
end;

begin
  nuskaitymas (ilg, eil, mas);
  fillchar (med, sizeof (med), 0);
  poz := 1;
  lisk (eil [1], poz, 1, ilg, med);
  rasymas
end.
