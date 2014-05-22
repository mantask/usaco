{
ID: vkanapo001
PROG: subset
}

Program SUBSET;

var
  viso : Integer;
  ats : int64;

procedure nuskaitymas (var viso : INteger);
var
  f : Text;
begin
  assign (f, 'subset.in');
  reset (f);
  readln (f, viso);
  close (f)
end;

function rask : int64;
var
  ckx, cky, sum : Integer;
  mas : array [1 .. 39, 1 .. 780] of int64;
begin
  sum := (1 + viso) * viso div 2;
  if sum mod 2 = 1 then
  begin
    rask := 0;
    exit
  end
  else sum := sum div 2;

  mas [1, 1] := 1;
  for cky := 2 to sum do
  mas [1, cky] := 0;

  for ckx := 2 to viso do
  for cky := 1 to sum do
  begin
    mas [ckx, cky] := mas [ckx - 1, cky];
    if ckx = cky then inc (mas [ckx, cky]);
    if cky > ckx then inc (mas [ckx, cky], mas [ckx - 1, cky - ckx])
  end;

  rask := mas [viso, sum] div 2
end;

procedure rasymas (ats : int64);
var
  f : Text;
begin
  assign (f, 'subset.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso);
  ats := rask;
  rasymas (ats)
end.
