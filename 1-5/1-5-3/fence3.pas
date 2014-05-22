{
ID: vkanapo001
PROG: fence3
}

program FENCE3;

type
  tMas = array [1 .. 150, 1 .. 2] of integer;

var
  masx, masy : Tmas;
  xx, yy, ilg : real;
  viso : integer;

procedure flip (var sk1, sk2 : INTEGER);
var
  pg : integer;
begin
  pg := sk1;
  sk1 := sk2;
  sk2 := pg
end;

procedure nuskaitymas (var viso : integer; var masx, masy : Tmas);
var
  f : text;
  ck : integer;
begin
  assign (f, 'fence3.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    readln (f, masx [ck, 1], masy [ck, 1], masx [ck, 2], masy [ck, 2]);
    if masx [ck, 1] > masx [ck, 2] then flip (masx [ck, 1], masx [ck, 2]);
    if masy [ck, 1] > masy [ck, 2] then flip (masy [ck, 1], masy [ck, 2])
  end;
  close (f)
end;

function atst (sk : real; sk1, sk2 : integer) : real;
begin
  if sk < sk1 then atst := sk1 - sk
  else
  if sk > sk2 then atst := sk - sk2
              else atst := 0
end;

function ilgis (x, y : real; var masx, masY : Tmas) : real;
var
  ck : Integer;
  pg : real;
begin
  pg := 0;
  for ck := 1 to viso do
  pg := pg + sqrt (sqr (atst (x, masx [ck, 1], masx [ck, 2])) + sqr (atst (y, masy [ck, 1], masy [ck, 2])));
  ilgis := pg
end;

procedure lisk (var x, y, ilg : real; var masx, masy : Tmas);
var
  pg : REal;
begin
  if x > 0.1 then
  begin
    pg := ilgis (x - 0.1, y, masx, masy);
    if pg < ilg then
    begin
      ilg := pg;
      x := x - 0.1;
      lisk (x, y, ilg, masx, masy);
      exit
    end
  end;
  if x < viso then
  begin
    pg := ilgis (x + 0.1, y, masx, masy);
    if pg < ilg then
    begin
      ilg := pg;
      x := x + 0.1;
      lisk (x, y, ilg, masx, masy);
      exit
    end
  end;
  if y > 0.1 then
  begin
    pg := ilgis (x, y - 0.1, masx, masy);
    if pg < ilg then
    begin
      ilg := pg;
      y := y - 0.1;
      lisk (x, y, ilg, masx, masy);
      exit
    end
  end;
  if y < viso then
  begin
    pg := ilgis (x, y + 0.1, masx, masy);
    if pg < ilg then
    begin
      ilg := pg;
      y := y + 0.1;
      lisk (x, y, ilg, masx, masy);
      exit
    end
  end
end;

procedure rask (var xx, yy, ilg : Real; viso : integer; var masx, masy : Tmas);
var
  ck : integer;
  minx, maxx, miny, maxy : real;
begin
  minx := masx [1, 1];
  miny := masy [1, 1];
  maxx := masx [1, 2];
  maxy := masy [1, 2];
  for ck := 2 to viso do
  begin
    if masx [ck, 1] < minx then minx := masx [ck, 1];
    if masy [ck, 1] < miny then miny := masy [ck, 1];
    if masx [ck, 2] > maxx then maxx := masx [ck, 2];
    if masy [ck, 2] > maxy then maxy := masy [ck, 2]
  end;

  xx := (minx + maxx) / 2;
  yy := (miny + maxY) / 2;
  ilg := ilgis (xx, yy, masx, masy);
  lisk (xx, yy, ilg, masx, masy)
end;

procedure rasymas (xx, yy, ilg : real);
var
  f : text;
begin
  assign (F, 'fence3.out');
  rewrite (f);
  writeln (f, xx :0 :1, ' ', yy :0 :1, ' ', ilg :0 :1);
  close (f)
end;

begin
  nuskaitymas (viso, masx, masy);
  rask (xx, yy, ilg, viso, masx, masy);
  rasymas (xx, yy, ilg)
end.
