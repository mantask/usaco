{
PROG: palpath
LANG: PASCAL
}

Program PALPATH;

type
  Tmas = array [1 .. 20, 1 .. 20] of 0 .. 9;
  Tpal = array [1 .. 18] of 0 .. 9;

var
  Ats : longint;
  xx, ilg : integer;
  mas : Tmas;

procedure nuskaitymas (var xx, ilg : Integer; var mas : Tmas);
var
  F : Text;
  ckx, cky : Integer;
begin
  assign (f, 'palpath.in');
  reset (f);
  readln (f, xx, ilg);
  for cky := 1 to xx do
  begin
    for ckx := 1 to xx do
    read (f, mas [ckx, cky]);
    readln (f)
  end;
  close (f)
end;

procedure lisk (il, x, y : Integer; var vid, pl : integer;
                var pal : Tpal; var kiek : longint);
var
  ind : integer;
begin
  if il = ilg then
  begin
    inc (kiek);
    exit
  end;
  inc (il);
  ind := 2 * vid - il + pl;
  if (x > 1) and (y > 1) then
  if (il <= vid) or (mas [x - 1, y - 1] = pal [ind]) then
  begin
    pal [il] := mas [x - 1, y - 1];
    lisk (il, x - 1, y - 1, vid, pl, pal, kiek)
  end;
  if y > 1 then
  if (il <= vid) or (mas [x, y - 1] = pal [ind]) then
  begin
    pal [il] := mas [x, y - 1];
    lisk (il, x, y - 1, vid, pl, pal, kiek)
  end;
  if (x < xx) and (y > 1) then
  if (il <= vid) or (mas [x + 1, y - 1] = pal [ind]) then
  begin
    pal [il] := mas [x + 1, y - 1];
    lisk (il, x + 1, y - 1, vid, pl, pal, kiek)
  end;
  if x < xx then
  if (il <= vid) or (mas [x + 1, y] = pal [ind]) then
  begin
    pal [il] := mas [x + 1, y];
    lisk (il, x + 1, y, vid, pl, pal, kiek)
  end;
  if (x < xx) and (y < xx) then
  if (il <= vid) or (mas [x + 1, y + 1] = pal [ind]) then
  begin
    pal [il] := mas [x + 1, y + 1];
    lisk (il, x + 1, y + 1, vid, pl, pal, kiek)
  end;
  if y < xx then
  if (il <= vid) or (mas [x, y + 1] = pal [ind]) then
  begin
    pal [il] := mas [x, y + 1];
    lisk (il, x, y + 1, vid, pl, pal, kiek)
  end;
  if (x > 1) and (y < xx) then
  if (il <= vid) or (mas [x - 1, y + 1] = pal [ind]) then
  begin
    pal [il] := mas [x - 1, y + 1];
    lisk (il, x - 1, y + 1, vid, pl, pal, kiek)
  end;
  if x > 1 then
  if (il <= vid) or (mas [x - 1, y] = pal [ind]) then
  begin
    pal [il] := mas [x - 1, y];
    lisk (il, x - 1, y, vid, pl, pal, kiek)
  end
end;

function rask : longint;
var
  vid, pl, ckx, cky : integer;
  kiek, viso : longint;
  pal : Tpal;
begin
  vid := ilg div 2 + ilg mod 2;
  if ilg mod 2 = 0 then pl := 1
                   else pl := 0;
  viso := 0;
  kiek := 0;
  for ckx := 1 to xx do
  for cky := 1 to xx do
  begin
    kiek := 0;
    pal [1] := mas [ckx, cky];
    lisk (1, ckx, cky, vid, pl, pal, kiek);
    inc (viso, kiek)
  end;
  rask := viso
end;

procedure rasymas (ats : longint);
var
  f : Text;
begin
  assign (f, 'palpath.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (xx, ilg, mas);
  ats := rask;
  rasymas (ats)
end.
