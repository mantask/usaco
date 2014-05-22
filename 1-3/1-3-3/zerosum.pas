{
ID: vkanapo001
PROG: zerosum
}

Program ZEROSUM;

Type
  Tmas = array [1 .. 8] of char;

var
  sk : integer;
  f : text;
  mas : Tmas;

procedure nuskaitymas (var sk : Integer);
var
  f : Text;
begin
  assign (f, 'zerosum.in');
  reset (f);
  readln (f, sk);
  close (f)
end;

procedure rasymas (var f : Text; var mas : Tmas);
var
  ck : integer;
begin
  for ck := 1 to sk - 1 do
  write (f, ck, mas [ck]);
  writeln (f, sk)
end;

procedure varyk (gyl : integer; rez : longint; var mas : Tmas; var f : Text);
var
  ck1, ck : integer;
  pgrez, pg : longint;
begin
  if gyl = sk then
  begin
    if rez = 0 then rasymas (f, mas);
    exit
  end;

  pgrez := rez;
  mas [gyl] := ' ';
  ck := gyl;
  pg := 0;
  while (ck > 0) and (mas [ck] = ' ') do dec (ck);
  for ck1 := ck + 1 to gyl do
  pg := pg * 10 + ck1;
  if ck = 0 then rez := 0
  else
  if mas [ck] = '-' then inc (rez, pg)
                    else dec (rez, pg);
  pg := pg * 10 + gyl + 1;
  if ck = 0 then rez := pg
  else
  if mas [ck] = '-' then dec (rez, pg)
                    else inc (rez, pg);
  varyk (gyl + 1, rez, mas, f);
  rez := pgrez;

  mas [gyl] := '+';
  varyk (gyl + 1, rez + gyl + 1, mas, f);

  mas [gyl] := '-';
  varyk (gyl + 1, rez - gyl - 1, mas, f)
end;

begin
  nuskaitymas (sk);
  assign (f, 'zerosum.out');
  rewrite (f);
  varyk (1, 1, mas, f);
  close (f)
end.
