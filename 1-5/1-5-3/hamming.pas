{
ID: vkanapo001
PROG: hamming
}

Program HAMMING;

type
  TMas = array [1 .. 64] of byte;

var
  mas : Tmas;
  kiek, ilg, d : Integer;

procedure nuskaitymas (var kiek, ilg, d : Integer);
var
  f : text;
begin
  assign (f, 'hamming.in');
  reset (f);
  readln (f, kiek, ilg, d);
  close (f)
end;

function ok (sk1, sk2 : byte; d : integer) : boolean;
var
  delta, ck : Integer;
begin
  delta := 0;
  for ck := 1 to 8 do
  begin
    if (sk1 and 1) <> (sk2 and 1) then inc (delta);
    sk1 := sk1 shr 1;
    sk2 := sk2 shr 1
  end;
  ok := delta >= d
end;

procedure rask (kiek, ilg, d : integer; var mas : Tmas);
var
  ck, viso, sk : byte;
  galima : boolean;
begin
  sk := 0;
  mas [1] := sk;
  viso := 1;
  while viso < kiek do
  begin
    inc (sk);
    galima := true;
    for ck := 1 to viso do
    if not ok (sk, mas [ck], d) then
    begin
      galima := false;
      break
    end;
    if galima then
    begin
      inc (viso);
      mas [viso] := sk
    end
  end
end;

procedure rasymas (kiek : integer; var mas : Tmas);
var
  f : Text;
  ck : integer;
begin
  assign (f, 'hamming.out');
  rewrite (f);
  for ck := 1 to kiek - 1 do
  if ck mod 10 = 0 then writeln (f, mas [ck])
                   else write (f, mas [ck], ' ');
  writeln (f, mas [kiek]);
  close (f)
end;

begin
  nuskaitymas (kiek, ilg, d);
  rask (kiek, ilg, d, mas);
  rasymas (kiek, mas)
end.
