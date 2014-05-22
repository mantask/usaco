{
PROG: btp
LANG: PASCAL
}

Program BTP;

var
  viso, kiek, n : word;

Procedure nuskaitymas (var viso, kiek : word);
var
  f : Text;
begin
  assign (f, 'btp.in');
  reset (f);
  readln (f, viso, kiek);
  close (f)
end;

function laipsnis (sk : word) : integer;
var
  pg : Integer;
begin
  pg := 0;
  while sk <> 0 do
  begin
    sk := sk shr 1;
    inc (pg)
  end;
  laipsnis := pg
end;

Procedure rasymas;
var
  f : Text;
  mas : array [1 .. 65536] of word;
  jau : array [1 .. 65536] of boolean;
  ck, ck1, pg, riba, sk, iki : word;
begin
  assign (f, 'btp.out');
  rewrite (f);
  n := n - 1;
  sk := viso - n - 1;
  writeln (f, sk);

  iki := viso;
  fillchar (jau, sizeof (jau), 0);
  write (f, sk, ' ');
  jau [sk] := true;
  mas [1] := sk;
  riba := iki;
  for ck1 := 2 to riba - 1 do
  begin
    pg := random (riba) + 1;
    while jau [pg] do pg := pg mod riba + 1;
    mas [ck1] := pg;
    jau [pg] := true;
    write (f, pg, ' ');
  end;
  while jau [pg] do pg := pg mod riba + 1;
  mas [iki] := pg;
  writeln (f, pg);
  mas [riba] := pg;

  for ck := 2 to n do
  begin
    pg := iki shr (ck - 1);
    riba := 2 shl (ck - 2);
    for ck1 := 0 to pg - 2 do
    write (f, mas [ck1 * riba + 1], ' ');
    writeln (f, mas [(pg - 1) * riba + 1])
  end;
  close (f)
end;

begin
  nuskaitymas (viso, kiek);
  n := laipsnis (viso);
  rasymas
end.
