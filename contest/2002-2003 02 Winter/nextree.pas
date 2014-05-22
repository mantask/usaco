{
PROG: nextree
LANG: PASCAL
}

Program NEXTREE;

Type
  Tmas = array [1 .. 1000] of integer;

var
  mas : Tmas;
  viso : Integer;
  ok : boolean;

Procedure nuskaitymas (var viso : Integer; var mas : TMas);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'nextree.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  read (f, mas [ck]);
  close (f)
end;

function rask (var mas : Tmas) : boolean;
var
  ck, ck1 : Integer;
  ok : boolean;
begin
  ok := false;
  for ck := viso - 1 downto 2 do
  if ((mas [ck] < ck) and (mas [ck - 1] = 1)) or (mas [ck] + 1 < mas [ck - 1]) then
  begin
    ok := true;
    inc (mas [ck]);
    for ck1 := ck + 1 to viso - 1 do
    mas [ck1] := 1;
    break
  end;
  rask := ok
end;

Procedure rasymas (ok : boolean; viso : Integer; var mas : Tmas);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'nextree.out');
  rewrite (f);
  if not ok then writeln (f, 0)
  else
  begin
    for ck := 1 to viso - 1 do
    write (f, mas [ck], ' ');
    writeln (f, mas [ck])
  end;
  close (f)
end;


begin
  nuskaitymas (viso, mas);
  ok := rask (mas);
  rasymas (ok, viso, mas)
end.
