{
ID: vkanapo001
PROG: castle
}

Program CASTLE;

type
  Tmas = array [1 .. 50, 1 .. 50, 1 .. 2] of integer;
  Tats = record
    c : char;
    nr, didz, max, x, y : integer;
  end;

const
  bits : array [1 .. 4] of byte = (1, 2, 4, 8);

var
  xx, yy : integer;
  mas : Tmas;
  ats : Tats;
procedure nuskaitymas (var xx, yy : integer; var mas : Tmas);
var
  F : text;
  ckx, cky : integer;
begin
  assign (f, 'castle.in');
  reset (f);
  readln (f, xx, yy);
  for cky := 1 to yy do
  begin
    for ckx := 1 to xx do
    read (f, mas [ckx, cky, 1]);
    readln (f)
  end;
  close (f)
end;

procedure fill (nr, x, y : integer; var max : integer; var mas, Cmas : Tmas);
var
  eil : array [1 .. 25000, 1 .. 2] of integer;
  ck, pgx, pgy, gal, uod : integer;
begin
  gal := 1;
  uod := 2;
  eil [1, 1] := x;
  eil [1, 2] := y;
  mas [x, y, 1] := -1;

  while gal < uod do
  begin
    pgx := eil [gal, 1];
    pgy := eil [gal, 2];
    if (pgx > 1) and (mas [pgx - 1, pgy, 1] <> -1) and
       ((Cmas [pgx, pgy, 1] and bits [1]) <> 1) then
    begin
      eil [uod, 1] := pgx - 1;
      eil [uod, 2] := pgy;
      mas [pgx - 1, pgy, 1] := -1;
      inc (uod)
    end;
    if (pgy > 1) and (mas [pgx, pgy - 1, 1] <> -1) and
       ((Cmas [pgx, pgy, 1] and bits [2]) <> 2) then
    begin
      eil [uod, 1] := pgx;
      eil [uod, 2] := pgy - 1;
      mas [pgx, pgy - 1, 1] := -1;
      inc (uod)
    end;
    if (pgx < xx) and (mas [pgx + 1, pgy, 1] <> -1) and
       ((Cmas [pgx, pgy, 1] and bits [3]) <> 4) then
    begin
      eil [uod, 1] := pgx + 1;
      eil [uod, 2] := pgy;
      mas [pgx + 1, pgy, 1] := -1;
      inc (uod)
    end;
    if (pgy < yy) and (mas [pgx, pgy + 1, 1] <> -1) and
       ((Cmas [pgx, pgy, 1] and bits [4]) <> 8) then
    begin
      eil [uod, 1] := pgx;
      eil [uod, 2] := pgy + 1;
      mas [pgx, pgy + 1, 1] := -1;
      inc (uod)
    end;
    inc (gal)
  end;
  dec (uod);
  for ck := 1 to uod do
  begin
    mas [eil [ck, 1], eil [ck, 2], 1] := uod;
    mas [eil [ck, 1], eil [ck, 2], 2] := nr
  end;
  if uod > max then max := uod
end;

procedure skaiciuok (xx, yy : integer; var ats : Tats; var Cmas : Tmas);
var
  mas : Tmas;
  nr, ckx, cky : integer;
begin
  fillchar (mas, sizeof (mas), 0);
  ats.max := 0;
  ats.didz := 0;
  nr := 0;
  for cky := 1 to yy do
  for ckx := 1 to xx do
  if mas [ckx, cky, 1] = 0 then
  begin
    inc (nr);
    fill (nr, ckx, cky, ats.didz, mas, Cmas)
  end;

  for ckx := xx downto 1 do
  for cky := 1 to yy do
  begin
    if (ckx < xx) and (mas [ckx, cky, 2] <> mas [ckx + 1, cky, 2]) and
       (mas [ckx, cky, 1] + mas [ckx + 1, cky, 1] >= ats.max) then
    begin
      ats.x := ckx;
      ats.y := cky;
      ats.max := mas [ckx, cky, 1] + mas [ckx + 1, cky, 1];
      ats.c := 'E'
    end;
    if (cky > 1) and (mas [ckx, cky, 2] <> mas [ckx, cky - 1, 2]) and
       (mas [ckx, cky, 1] + mas [ckx, cky - 1, 1] >= ats.max) then
    begin
      ats.x := ckx;
      ats.y := cky;
      ats.max := mas [ckx, cky, 1] + mas [ckx, cky - 1, 1];
      ats.c := 'N'
    end;
  end;
  ats.nr := nr
end;

procedure rasyk (ats : Tats);
var
  F : text;
begin
 assign (f, 'castle.out');
 rewrite (f);
 writeln (f, ats.nr);
 writeln (f, ats.didz);
 writeln (f, ats.max);
 writeln (f, ats.y, ' ', ats.x, ' ', ats.c);
 close (f);
end;

begin
  nuskaitymas (xx, yy, mas);
  skaiciuok (xx, yy, ats, mas);
  rasyk (ats)
end.
