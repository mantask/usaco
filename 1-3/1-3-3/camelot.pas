{
ID: vkanapo001
PROG: camelot
}

Program CAMELOT;

const
  kel : array [1 .. 8, 1 .. 2] of integer =
        ((1, -2), (2, -1), (2, 1), (1, 2),
         (-1, 2), (-2, 1), (-2, -1), (-1, -2));

type
  TATS = array [1 .. 26, 1 .. 40, 1 .. 2] of longint; { su kar }
  Tmas = array [1 .. 26, 1 .. 40] of longint; { be kar }
  Tkar = array [1 .. 26, 1 .. 40] of integer;

var
  f : text;
  ats : Tats;
  kar : Tkar;
  c : char;
  ckx, cky, xx, yy, y : Integer;
  sk : longint;

function max (sk1, sk2 : longint) : longint;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

function min (sk1, sk2 : longint) : longint;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

procedure pildykKAR (x, y : Integer; var kar : Tkar);
var
  ckx, cky : integer;
begin
  for ckx := 1 to xx do
  for cky := 1 to yy do
  kar [ckx, cky] := max (abs (ckx - x), abs (cky - y))
end;

procedure pildyk (x, y, nx, ny : integer; var masBE, masSU : Tmas);
var
  gal, uod,
  pgKAR, pgx, pgy, ck : Integer;
  eil : array [1 .. 10000, 1 .. 3] of integer;
begin
  eil [1, 1] := x;
  eil [1, 2] := y;
  eil [1, 3] := kar [x, y];
  gal := 1;
  uod := 2;
  while gal < uod do
  begin
    for ck := 1 to 8 do
    begin
      pgx := kel [ck, 1] + eil [gal, 1];
      pgy := kel [ck, 2] + eil [gal, 2];
      if (pgx <= xx) and (pgx >= 1) and (pgy <= yy) and (pgy >= 1) and
         ((masBE [pgx, pgy] = 0) or
          (masBE [pgx, pgy] > masBE [eil [gal, 1], eil [gal, 2]] + 1) or
          ((masBE [pgx, pgy] = masBE [eil [gal, 1], eil [gal, 2]] + 1) and
           (masSU [pgx, pgy] > masBE [eil [gal, 1], eil [gal, 2]] + min (eil [gal, 3], kar [pgx, pgy]) + 1))) then
      begin
        if (pgx = nx) and (pgy = ny) then continue;
        masBE [pgx, pgy] := masBE [eil [gal, 1], eil [gal, 2]] + 1;
        pgKAR := min (eil [gal, 3], kar [pgx, pgy]);
        masSU [pgx, pgy] := masBE [eil [gal, 1], eil [gal, 2]] + pgKAR + 1;
        eil [uod, 1] := pgx;
        eil [uod, 2] := pgy;
        eil [uod, 3] := pgKAR;
        inc (uod)
      end
    end;
    inc (gal)
  end
end;
procedure tvarkyk (x, y : integer; var ATS : Tats);
var
  masbe, masSU : Tmas;
  ckx, cky : Integer;
  delta : longint;
begin
  fillchar (masSU, sizeof (masSU), 0);
  fillchar (masBE, sizeof (masBE), 0);
  pildyk (x, y, x, y, masBE, masSU);
  masSU [x, y] := kar [x, y];
  for ckx := 1 to xx do
  for cky := 1 to yy do
  begin
    delta := masSU [ckx, cky] - masBE [ckx, cky];
    if (ats [ckx, cky, 1] = 0) or (delta < ats [ckx, cky, 2])
    then ats [ckx, cky, 2] := delta;
    ats [ckx, cky, 1] := ats [ckx, cky, 1] + masBE [ckx, cky]
  end
end;

begin
  assign (f, 'camelot.in');
  reset (f);
  readln (f, yy, xx);
  readln (f, c, y);
  pildykKAR (ord (c) - 64, y, kar);
  fillchar (ats, sizeof (ats), 0);
  while not eof (f) do
  begin
    c := #0;
    while not (c in ['A' .. 'Z']) do read (f, c);
    read (f, y);
    tvarkyk (ord (c) - 64, y, ats);
    if eoln (f) then readln (f)
  end;
  close (f);

  sk := maxlongint;
  for ckx := 1 to xx do
  for cky := 1 to yy do
  if ((ats [ckx, cky, 1] > 0) or (ats [ckx, cky, 2] > 0)) and
     (ats [ckx, cky, 1] + ats [ckx, cky, 2] < sk)
  then sk := ats [ckx, cky, 1] + ats [ckx, cky, 2];
  if sk = maxlongint then sk := 0;

  assign (f, 'camelot.out');
  rewrite (f);
  writeln (f, sk);
  close (f)
end.
