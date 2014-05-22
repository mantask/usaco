{
PROG: life2
LANG: PASCAL
}

Program LIFE2;

var
  ats, sk, n : integer;

procedure nuskaitymas (var sk, n : integer);
var
  f : Text;
begin
  assign (f, 'life2.in');
  reset (f);
  readln (f, sk, n);
  close (f)
end;

function nn (sk, n : integer) : longint;
var
  pg : longint;
  ck : integer;
begin
  pg := sk;
  for ck := 1 to n - 1 do
  pg := pg * sk;
  nn := pg
end;

function laipsn (sk : longint; n : integer) : longint;
var
  s, pg : longint;
begin
  pg := 0;
  while sk <> 0 do
  begin
    s := sk mod 10;
    sk := sk div 10;
    pg := pg + nn (s, n)
  end;
  laipsn := pg
end;

function varyk (sk, n : integer) : integer;
var
  jau : boolean;
  pg : longint;
  ck, ilg : integer;
  mas : array [1 .. 100000] of longint;
begin
  mas [1] := sk;
  pg := laipsn (sk, n);
  mas [2] := pg;
  ilg := 2;
  jau := mas [1] = mas [2];
  while not jau and (ilg <= 100000) do
  begin
    pg := laipsn (pg, n);
    inc (ilg);
    mas [ilg] := pg;
    for ck := 1 to ilg - 1 do
    if mas [ck] = pg then
    begin
      jau := true;
      ilg := ck - 1;
      break
    end
  end;
  if not jau then varyk := 0
             else varyk := ilg
end;

procedure rasyk (ats : integer);
var
  f : text;
begin
  assign (f, 'life2.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (sk, n);
  ats := varyk (sk, n);
  rasyk (ats)
end.
