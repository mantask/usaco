{
ID: vkanapo001
PROG: fact4
}

Program FACT4;

var
  sk, ats : Integer;

procedure nuskaitymas (var sk : Integer);
var
  f : Text;
begin
  assign (f, 'fact4.in');
  reset (f);
  readln (f, sk);
  close (f)
end;

function varyk (sk : integer) : integer;
var
  ck : Integer;
  pg : longint;
begin
  pg := 1;
  for ck := 2 to sk do
  begin
    pg := pg * ck;
    while pg mod 10 = 0 do pg := pg div 10;
    pg := pg mod 1000
  end;
  varyk := pg mod 10
end;

procedure rasymas (ats : integer);
var
  f : Text;
begin
  assign (f, 'fact4.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (sk);
  ats := varyk (sk);
  rasymas (ats)
end.
