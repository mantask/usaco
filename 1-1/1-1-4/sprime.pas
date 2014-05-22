{
ID: vkanapo001
PROG: sprime
}

program SPRIME;

const
  p : array [1 .. 4] of longint =
      (1, 3, 7, 9);
  n : array [1 .. 8] of longint =
      (2, 2, 10, 10, 10, 100, 1000, 10000);

var
  sk : byte;
  f : text;

procedure nuskaitymas (var sk : byte);
var
  F : text;
begin
  assign (f, 'sprime.in');
  reset (f);
  readln (f, sk);
  close (f)
end;

function pirm (sk , ind: longint) : boolean;
var
  ok : boolean;
  ck : longint;
begin
  ok := true;
  for ck := 2 to sk div n [ind] do
  if sk mod ck = 0 then
  begin
    ok := false;
    break
  end;
  pirm := ok
end;

procedure gen (gylis : byte; pg : longint; var f : text);
var
  ck : byte;
begin
  if (gylis > 1) and not pirm (pg, gylis) then exit;

  if gylis = sk then
  begin
    writeln (f, pg);
    exit
  end;

  pg := pg * 10;
  for ck := 1 to 4 do
  gen (gylis + 1, pg + p [ck], f)
end;

begin
  nuskaitymas (sk);
  assign (f, 'sprime.out');
  rewrite (f);
  if sk = 1 then
  begin
    writeln (f, 2);
    writeln (f, 3);
    writeln (f, 5);
    writeln (f, 7)
  end
  else
  begin
    gen (1, 2, f);
    gen (1, 3, f);
    gen (1, 5, f);
    gen (1, 7, f)
  end;
  close (f)
end.
