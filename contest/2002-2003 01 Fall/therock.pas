{
PROG: therock
LANG: PASCAL
}

Program THEROCK;

type
  Tmas = array [1 .. 100, 1 .. 5] of integer;

var
  mas : Tmas;
  ats, viso, xx, yy : Integer;

procedure nuskaitymas (var viso, xx, yy : integer; var mas : Tmas);
var
  F : Text;
  ck : Integer;
begin
  assign (f, 'therock.in');
  reset (f);
  readln (f, viso, xx, yy);
  for ck := 1 to viso do
  readln (f, mas [ck, 1], mas [ck, 2], mas [ck, 3], mas [ck, 4], mas [ck, 5]);
  close (f)
end;

function ok (nr, s : integer; turi : boolean) : boolean;
var
  pg : boolean;
begin
  if s = 1 then
  pg := ((xx - mas [nr, 1]) * (mas [nr, 4] - mas [nr, 2]) -
         (yy - mas [nr, 2]) * (mas [nr, 3] - mas [nr, 1])) < 0
  else
  pg := ((xx - mas [nr, 3]) * (mas [nr, 2] - mas [nr, 4]) -
         (yy - mas [nr, 4]) * (mas [nr, 1] - mas [nr, 3])) < 0;
  ok := pg = turi
end;

function puse (nr1, nr2 : integer) : boolean;
var
  pg : boolean;
begin
  if (mas [nr1, 1] = mas [nr2, 1]) or (mas [nr1, 1] = mas [nr2, 3]) then
  begin
    xx := mas [nr1, 3];
    yy := mas [nr1, 4]
  end
  else
  begin
    xx := mas [nr1, 1];
    yy := mas [nr2, 2]
  end;
  puse := ((xx - mas [nr2, 1]) * (mas [nr2, 4] - mas [nr2, 2]) -
           (yy - mas [nr2, 2]) * (mas [nr2, 3] - mas [nr2, 1])) < 0;
end;


procedure lisk (kain, x, y, ne, px, py : integer; var max : integer; var turi, jau, p : boolean);
var
  ck : integer;
begin
  if (x = px) and (y = py) then
  begin
    if kain < max then max := kain;
    exit
  end;
  for ck := 1 to viso do
  if (ck <> ne) then
  begin
    if (mas [ck, 1] = x) and (mas [ck, 2] = y) then
    begin
      if ok (ck, 1,turi) and (not jau or (puse (ne, ck) = p)) then
      begin
        if not jau then
        begin
          jau := true;
          p := puse (ne, ck)
        end;
        lisk (kain + mas [ck, 5], mas [ck, 3], mas [ck, 4], ck, px, py, max, turi, jau, p)
      end
    end;
    if (mas [ck, 3] = x) and (mas [ck, 4] = y) then
    begin
      if ok (ck, 2, turi) and (not jau or (p = puse (ne, ck))) then
      begin
        if not jau then
        begin
          jau := true;
          p := puse (ne, ck)
        end;
        lisk (kain + mas [ck, 5], mas [ck, 1], mas [ck, 2], ck, px, py, max, turi, jau, p)
      end
    end
  end
end;

function rask : Integer;
var
  jau, p, turi : boolean;
  ck, max : integer;
begin
  max := maxint;
  for ck := 1 to viso do
  begin
    turi := ((xx - mas [ck, 1]) * (mas [ck, 4] - mas [ck, 2]) -
             (yy - mas [ck, 2]) * (mas [ck, 3] - mas [ck, 1])) < 0;
    jau := false;
    lisk (mas [ck, 5], mas [ck, 3], mas [ck, 4], ck, mas [ck, 1], mas [ck, 2], max, turi, jau, p)
  end;
  rask := max
end;

procedure rasymas (ats : integer);
var
  f : Text;
begin
  assign (f, 'therock.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, xx, yy, mas);
  ats := rask - 1;
  rasymas (ats)
end.
