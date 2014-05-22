{
PROG: brain
LANG: PASCAL
}

Program BRAIN;

var
  sk : longint;
  ats, n : integer;

procedure nuskaitymas (var sk : longint; var n : integer);
var
  f : Text;
begin
  assign (f, 'brain.in');
  reset(f);
  readln (f, sk, n);
  close (f)
end;

function versk (sk : longint; n : integer) : integer;
var
  pg : integer;
begin
  pg := sk mod n;
  while pg = 0 do
  begin
    sk := sk div n;
    pg := sk mod n
  end;
  versk := sk mod n
end;

function skaitmuo (sk : longint; n : integer) : integer;
var
  pg, ck : longint;
begin
  pg := 1;
  for ck := 2 to sk do
  pg := versk (pg * ck, n);
  skaitmuo := pg
end;

procedure rasyk (ats : longint);
var
  f : text;
begin
  assign (f, 'brain.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (sk, n);
  ats := skaitmuo (sk, n);
  rasyk (ats)
end.
