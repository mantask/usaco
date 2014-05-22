{
PROG:milking
LANG:PASCAL
}

Program MILKING;

Type
  Tg = array [1 .. 230, 1 .. 230] of integer;

var
  ats, kar, mas, po : integer;
  atst, g : Tg;

Procedure nuskaitymas (var kar, mas, po : integer; var g : Tg);
var
  f : Text;
  ckx, cky : integer;
begin
  fillchar (g, sizeof (g), 0);
  assign (f, 'milking.in');
  reset (f);
  readln (f, kar, mas, po);
  for cky := 1 to kar + mas do
  begin
    for ckx := 1 to kar + mas do
    begin
      read (f, g [ckx, cky]);
      if ckx mod 15 = 0 then readln (f)
    end;
    readln (f)
  end;
  close (f)
end;

procedure poros (var atst : TG);
var
  ck1, ck2, ck3 : Integer;
begin
  for ck1 := 1 to kar + mas do
  for ck2 := 1 to kar + mas do
  if g [ck1, ck2] = 0 then atst [ck1, ck2] := maxint
                      else atst [ck1, ck2] := g [ck1, ck2];

  for ck3 := 1 to kar + mas do
  for ck1 := 1 to kar + mas do
  for ck2 := 1 to kar + mas do
  if atst [ck1, ck3] + atst [ck3, ck2] < atst [ck1, ck2]
  then atst [ck1, ck2] := atst [ck1, ck3] + atst [ck3, ck2]
end;

function rask : integer;
var
  ckx, cky, pg, didz : integer;
begin
  didz := 0;
  for ckx := 1 to mas do
  begin
    pg := maxint;
    for cky := mas + 1 to kar + mas do
    if atst [ckx, cky] < pg then pg := atst [ckx, cky];
    if pg > didz then didz := pg
  end;
  rask := didz
end;

procedure rasymas (ats : integer);
var
  f : text;
begin
  assign (f, 'milking.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (kar, mas, po, g);
  poros (atst);
  ats := rask;
  rasymas (ats)
end.
