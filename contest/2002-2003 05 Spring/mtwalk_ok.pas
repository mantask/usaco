{
PROG:mtwalk
LANG:PASCAL
}

{ neina 5 ir 10 testai }

Program MTWALK;

Type
  tmas = array [1 .. 100, 1 .. 100] of integer;
  tpg = array [1 .. 100, 1 .. 100, 1 .. 2] of integer;

var
  mas : Tmas;
  ats, viso : Integer;

Procedure nuskaitymas (var viso : integer; var mas : TMas);
var
  f : Text;
  ckx, cky : integer;
begin
  assign (f, 'mtwalk.in');
  reset (f);
  readln (f, viso);
  for cky := 1 to viso do
  begin
    for ckx := 1 to viso do
    read (f, mas [ckx, cky]);
    readln (f)
  end;
  close (f)
end;

function max (sk1, sk2 : Integer) : integer;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

function min (sk1, sk2 : Integer) : integer;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

procedure lisk (x, y : integer; var pg : Tpg);
var
  did, maz : Integer;
begin
  if (x = viso) and (y = viso) then exit;

  { kai skirtumai lygus, gali apsimoketi imti su mazesniu min arba su
    didesniu max }

  if x > 1 then
  begin
    maz := min (pg [x, y, 1], mas [x - 1, y]);
    did := max (pg [x, y, 2], mas [x - 1, y]);
    if (pg [x - 1, y, 1] = -1) or
       (did - maz < pg [x - 1, y, 2] - pg [x - 1, y, 1]) then
    begin
      pg [x - 1, y, 1] := maz;
      pg [x - 1, y, 2] := did;
      lisk (x - 1, y, pg)
    end
  end;

  if y > 1 then
  begin
    maz := min (pg [x, y, 1], mas [x, y - 1]);
    did := max (pg [x, y, 2], mas [x, y - 1]);
    if (pg [x, y - 1, 1] = -1) or
       (did - maz < pg [x, y - 1, 2] - pg [x, y - 1, 1]) then
    begin
      pg [x, y - 1, 1] := maz;
      pg [x, y - 1, 2] := did;
      lisk (x, y - 1, pg)
    end
  end;

  if x < viso then
  begin
    maz := min (pg [x, y, 1], mas [x + 1, y]);
    did := max (pg [x, y, 2], mas [x + 1, y]);
    if (pg [x + 1, y, 1] = -1) or
       (did - maz < pg [x + 1, y, 2] - pg [x + 1, y, 1]) then
    begin
      pg [x + 1, y, 1] := maz;
      pg [x + 1, y, 2] := did;
      lisk (x + 1, y, pg)
    end
  end;

  if y < viso then
  begin
    maz := min (pg [x, y, 1], mas [x, y + 1]);
    did := max (pg [x, y, 2], mas [x, y + 1]);
    if (pg [x, y + 1, 1] = -1) or
       (did - maz < pg [x, y + 1, 2] - pg [x, y + 1, 1]) then
    begin
      pg [x, y + 1, 1] := maz;
      pg [x, y + 1, 2] := did;
      lisk (x, y + 1, pg)
    end
  end
end;

function rask : integer;
var
  pg : Tpg;
begin
  fillchar (pg, sizeof (pg), $FF);
  pg [1, 1, 1] := mas [1, 1];
  pg [1, 1, 2] := mas [1, 1];
  lisk (1, 1, pg);
  rask := pg [viso, viso, 2] - pg [viso, viso, 1]
end;

procedure rasymas (ats : integer);
var
  f : text;
begin
  assign (f, '');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  ats := rask;
  rasymas (ats)
end.
