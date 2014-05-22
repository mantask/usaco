{
PROG: order
LANG: PASCAL
}

Program order;

const
  fname = 'order';

Type
  Tmas = array [1 .. 10000, 1 .. 2] of integer;

var
  viso, kiek : integer;
  mas : Tmas;

Procedure nuskaitymas (var viso, kiek : integer; var mas : Tmas);
var
  f : Text;
  ck : integer;
begin
  assign (f, fname + '.in');
  reset (f);
  readln (f, viso, kiek);
  for ck := 1 to kiek do
  readln (f, mas [ck, 1], mas [ck, 2]);
  close (f)
end;

Procedure quicksort (r1, r2 : Integer; var mas : TMas);
var
  v1, v2, v11, v22, pg : Integer;
begin
  v1 := r1;
  v2 := r2;
  v11 := mas [(v1 + v2) div 2, 1];
  v22 := mas [(v1 + v2) div 2, 2];
  repeat
    while (mas [v1, 1] < v11) or ((mas [v1, 1] = v11) and (mas [v1, 2] < v22)) do inc (v1);
    while (mas [v2, 1] > v11) or ((mas [v2, 1] = v11) and (mas [v2, 2] > v22)) do dec (v2);
    if v1 <= v2 then
    begin
      pg := mas [v1, 1];
      mas [v1, 1] := mas [v2, 1];
      mas [v2, 1] := pg;
      pg := mas [v1, 2];
      mas [v1, 2] := mas [v2, 2];
      mas [v2, 2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then quicksort (v1, r2, mas);
  if r1 < v2 then quicksort (r1, v2, mas)
end;


procedure rask (var viso, kiek : integer; var mas : TMas);
var
  list, poz : array [1 .. 1500] of integer;
  pg, ck, ck1 : integer;
begin
  for ck := 1 to viso do
  begin
    list [ck] := ck;
    poz [ck] := ck
  end;

  for ck := 1 to kiek do
  if poz [mas [ck, 1]] > poz [mas [ck, 2]] then
  begin
    for ck1 := poz [mas [ck, 1]] downto poz [mas [ck, 2]] + 1 do
    begin
      list [ck1] := list [ck1 - 1];
      inc (poz [list [ck1]])
    end;
    list [poz [mas [ck, 2]] - 1] := mas [ck, 1];
    poz [mas [ck, 1]] := ck1
  end

end;

procedure rasymas (kiek : integer; var mas : tmas);
var
  f : text;
  ck : integer;
begin
  assign (f, fname + '.out');
  rewrite (f);
  writeln (f, kiek);
  for ck := 1 to kiek do
  writeln (f, mas [ck, 1], ' ', mas [ck, 2]);
  close (f)
end;

begin
  nuskaitymas (viso, kiek, mas);
  kiek := viso - 1;
  quicksort (1, kiek, mas);
{  rask (viso, kiek, mas);
 } rasymas (kiek, mas)
end.
