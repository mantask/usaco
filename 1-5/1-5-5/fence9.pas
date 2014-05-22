{
ID: vkanapo001
PROG: fence9
}

Program FENCE9;

var
  x1, x2, y, ats : longint;

procedure nuskaitymas (var x1, x2, y : longint);
var
  f : text;
begin
  assign (f, 'fence9.in');
  reset (f);
  readln (f, x1, y, x2);
  close (f)
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'fence9.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

function rask (xx1, xx2, y : longint) : longint;
var
  cky, x2, pg : longint;
begin
  if xx1 = 0 then x1 := 1
             else x1 := xx1;
  x2 := xx1;
  pg := 0;
  for cky := y - 1 downto 1 do
  begin
    while y * (x1 - 1) > xx1 * cky do dec (x1);
    while y * (x2 + 1 - xx2) < (xx1 - xx2) * cky do inc (x2);
    while y * (x2 - xx2) >= (xx1 - xx2) * cky do dec (x2);
    if x1 <= x2 then pg := pg + (x2 - x1 + 1)
  end;
  rask := pg
end;

begin
  nuskaitymas (x1, x2, y);
  ats := rask (x1, x2, y);
  rasymas (ats)
end.
