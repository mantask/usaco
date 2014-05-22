{
ID: vkanapo001
PROG: betsy
}

Program BETSY;

const
  xx : array [1 .. 4] of integer = (0, +1, 0, -1);
  yy : array [1 .. 4] of integer = (-1, 0, +1, 0);

Type
  Tmas = array [1 .. 7, 1 .. 7] of boolean;
  Tliko = array [1 .. 7, 1 .. 7] of integer;

var
  viso, viso2 : integer;
  ats : Longint;

procedure nuskaitymas (var viso : Integer);
var
  f : text;
begin
  assign (f, 'betsy.in');
  reset (f);
  readln (f, viso);
  close (f)
end;

procedure rasymas (ats : Longint);
var
  f : text;
begin
  assign (f, 'betsy.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

function valid (x, y, ck : integer) : boolean;
begin
  valid :=  (x + xx[ck] >= 1) and (x + xx[ck] <= viso) and
            (y + yy[ck] >= 1) and (y + yy[ck] <= viso)
end;


procedure lisk (gylis, x, y : integer; var kiek : longint; var mas : Tmas; var liko : Tliko);
var
  ck, ck1, pgx, pgy, buvo : integer;
  ok : boolean;
begin
  if gylis = viso2 then
  begin
    inc (kiek);
    exit
  end;

  if mas [1, viso] then exit;

  buvo := 0;
  for ck := 1 to 4 do
  if valid (x, y, ck) and not mas [x + xx[ck], y + yy[ck]] and
     not ((x+xx[ck] = 1) and (y+yy[ck] = viso)) and (liko [x + xx[ck], y + yy[ck]] = 1)
  then inc (buvo);

  if buvo > 1 then exit;

  for ck := 1 to 4 do
  if valid (x, y, ck) and not mas[x + xx[ck], y + yy[ck]] and
     ((buvo = 0) or (buvo = 1) and (liko[x + xx[ck], y + yy[ck]] = 1)) then
  begin

    ok := true;
    for ck1 := 1 to 4 do
    if valid (x + xx[ck], y + yy[ck], ck1) then
    begin
      pgx := x + xx[ck] + xx[ck1];
      pgy := y + yy[ck] + yy[ck1];
      dec (liko [pgx, pgy]);
      if not mas [pgx, pgy] and (liko [pgx, pgy] = 0) and
         not ((pgx = 1) and (pgy = viso)) then ok := false
    end;

    if ok then
    begin
      mas [x + xx[ck], y + yy[ck]] := true;
      lisk (gylis + 1, x + xx[ck], y + yy[ck], kiek, mas, liko);
      mas [x + xx[ck], y + yy[ck]] := false
    end;

    for ck1 := 1 to 4 do
    if valid (x + xx[ck], y + yy[ck], ck1)
      then inc (liko [x + xx[ck] + xx[ck1], y + yy[ck] + yy[ck1]])

  end
end;

function rask : longint;
var
  pg : longint;
  mas : Tmas;
  liko : tliko;
  ckx, cky : Integer;
begin
  for ckx := 2 to viso - 1 do
  for cky := 2 to viso - 1 do
  liko [ckx, cky] := 4;
  for ckx := 2 to viso - 1 do
  begin
    liko [ckx, 1] := 3;
    liko [ckx, viso] := 3;
    liko [1, ckx] := 3;
    liko [viso, ckx] := 3;
  end;
  liko [viso, viso] := 2;
  liko [1, viso] := 2;
  liko [viso, 1] := 2;
  liko [1, 1] := 2;

  for ckx := 1 to 4 do
  if valid (1, 1, ckx) then
  dec (liko [1 + xx[ckx], 1 + yy[ckx]]);

  fillchar (mas, sizeof (mas), 0);
  mas [1, 1] := true;
  pg := 0;
  viso2 := viso * viso;
  lisk (1, 1, 1, pg, mas, liko);
  rask := pg
end;

begin
  nuskaitymas (viso);
  ats := rask;
  rasymas (ats)
end.
