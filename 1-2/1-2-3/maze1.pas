{
ID: vkanapo001
PROG: maze1
}

Program MAZE1;

type
  Tmas = array [1 .. 38, 1 .. 100] of 0 .. 15;
  Tilg = array [1 .. 38, 1 .. 100] of integer;
  Tin = array [1 .. 2, 1 .. 2] of integer;

var
  ats, xx, yy : Integer;
  mas : Tmas;
  inn : Tin;
  ilg : Tilg;

procedure nuskaitymas (var xx, yy : integer; var inn : Tin; var mas : Tmas);
var
  f : text;
  pg : 0 .. 15;
  pgx, pgy,
  ckx, cky : Integer;
  mas1 : array [1 .. 77, 1 .. 201] of char;
begin
  assign (f, 'maze1.in');
  reset (f);
  readln (f, xx, yy);
  for cky := 1 to 2 * yy + 1 do
  begin
    for ckx := 1 to 2 * xx + 1 do
    read (f, mas1 [ckx, cky]);
    readln (f)
  end;
  close (f);
  for ckx := 1 to xx do
  for cky := 1 to yy do
  begin
    pg := 0;
    pgx := 2 * ckx;
    pgy := 2 * cky;
    if (ckx >= 1) and (mas1 [pgx - 1, pgy] = ' ') then inc (pg, 8);
    if (cky >= 1) and (mas1 [pgx, pgy - 1] = ' ') then inc (pg, 1);
    if (ckx <= xx) and (mas1 [pgx + 1, pgy] = ' ') then inc (pg, 2);
    if (cky <= yy) and (mas1 [pgx, pgy + 1] = ' ') then inc (pg, 4);
    mas [ckx, cky] := pg;

    if ((ckx = 1) and ((pg and 8) = 8)) or ((ckx = xx) and ((pg and 2) = 2)) or
       ((cky = 1) and ((pg and 1) = 1)) or ((cky = yy) and ((pg and 4) = 4)) then
    begin
      if inn [1, 1] = 0
      then
      begin
        inn [1, 1] := ckx;
        inn [1, 2] := cky
      end
      else
      begin
        inn [2, 1] := ckx;
        inn [2, 2] := cky
      end
    end
  end
end;

procedure varyk (gyl, x, y : integer; var ilg : Tilg);
begin
  ilg [x, y] := gyl;

  if (x > 1) and ((mas [x, y] and 8) = 8) and
     ((ilg [x - 1, y] = 0) or (ilg [x - 1, y] > gyl + 1))
  then varyk (gyl + 1, x - 1, y, ilg);
  if (y > 1) and ((mas [x, y] and 1) = 1) and
     ((ilg [x, y - 1] = 0) or (ilg [x, y - 1] > gyl + 1))
  then varyk (gyl + 1, x, y - 1, ilg);
  if (x < xx) and ((mas [x, y] and 2) = 2) and
     ((ilg [x + 1, y] = 0) or (ilg [x + 1, y] > gyl + 1))
  then varyk (gyl + 1, x + 1, y, ilg);
  if (y < yy) and ((mas [x, y] and 4) = 4) and
     ((ilg [x, y + 1] = 0) or (ilg [x, y + 1] > gyl + 1))
  then varyk (gyl + 1, x, y + 1, ilg)
end;

function rask (x, y : integer; var ilg : Tilg) : integer;
var
  ckx, cky, max : Integer;
begin
  max := 0;
  for ckx := 1 to x do
  for cky := 1 to y do
  if ilg [ckx, cky] > max then max := ilg [ckx, cky];
  rask := max
end;

procedure rasyk (ats : integer);
var
  f : Text;
begin
  assign (f, 'maze1.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (xx, yy, inn, mas);
  fillchar (ilg, sizeof (ilg), 0);
  varyk (1, inn [1, 1], inn [1, 2], ilg);
  if inn [2, 1] <> 0 then varyk (1, inn [2, 1], inn [2, 2], ilg);
  ats := rask (xx, yy, ilg);
  rasyk (ats)
end.
