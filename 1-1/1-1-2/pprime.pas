{
ID: vkanapo001
PROG: pprime
}

program PPRIME;

type
  Tmas = array [1 .. 8000] of longint;

var
  f : text;
  nuo, iki : longint;


procedure nuskaitymas (var nuo, iki : longint);
var
  f : text;
begin
  assign (f, 'pprime.in');
  reset (f);
  readln (f, nuo, iki);
  close (F)
end;

function okay (sk : longint) : boolean;
var
  ok : boolean;
  ck : longInt;
begin
  ok := true;
  if (sk < nuo) or (sk > iki) or
     (sk mod 2 = 0) or
     (sk mod 3 = 0) or
     ((sk > 7) and (sk mod 7 = 0)) or
     ((sk > 11) and (sk mod 11 = 0)) or
     ((sk > 13) and (sk mod 13 = 0)) or
     ((sk > 17) and (sk mod 17 = 0)) or
     ((sk > 19) and (sk mod 19 = 0)) or
     ((sk > 23) and (sk mod 23 = 0)) or
     ((sk > 29) and (sk mod 29 = 0)) or
     ((sk > 31) and (sk mod 31 = 0)) or
     ((sk > 37) and (sk mod 37 = 0)) or
     ((sk > 41) and (sk mod 41 = 0)) or
     ((sk > 43) and (sk mod 43 = 0)) or
     ((sk > 47) and (sk mod 47 = 0)) or
     ((sk > 53) and (sk mod 53 = 0)) or
     ((sk > 59) and (sk mod 59 = 0)) or
     ((sk > 61) and (sk mod 61 = 0)) or
     ((sk > 67) and (sk mod 67 = 0)) or
     ((sk > 71) and (sk mod 71 = 0)) or
     ((sk > 73) and (sk mod 73 = 0)) or
     ((sk > 79) and (sk mod 79 = 0)) or
     ((sk > 83) and (sk mod 83 = 0)) or
     ((sk > 89) and (sk mod 89 = 0)) or
     ((sk > 97) and (sk mod 97 = 0))
  then ok := false;
  if ok then
  for ck := 2 to sk div 100 do
  if sk mod ck = 0 then
  begin
    ok := false;
    break
  end;
  okay := ok
end;

function n (l : integer) : longint;
var
  ck : integer;
  ats : longint;
begin
  ats := 1;
  for ck := 1 to l do
  ats := ats * 10;
  n := ats
end;

procedure gen (kiek, gylis, sk, nuo, iki : longint; var f : text);
var
  ck : integer;
  pg, pg1 : longint;
begin
  if (kiek div 2 < gylis) or (kiek = 1) then
  begin
    if kiek mod 2 = 1 then
    begin
      pg := n (kiek div 2);
      for ck := 0 to 9 do
      begin
        pg1 := sk + pg * ck;
        if okay (pg1) then writeln (f, pg1)
      end;
    end
    else if okay (sk) then writeln (f, sk);
    exit
  end;

  for ck := 0 to 9 do
  if (gylis = 1) and ((ck mod 2 = 0) or (ck mod 5 = 0)) then continue
  else
  begin
    pg := sk + n (kiek - gylis) * ck + ck * n (gylis - 1);
    gen (kiek, gylis + 1, pg, nuo, iki, f)
  end
end;

procedure skaiciuok (nuo, iki : longint; var F : text);
var
  pg : longint;
  il1, il2,
  ck : Integer;
begin
  pg := 0;
  il1 := 9;
  il2 := 9;
  while nuo div n (il1) = 0 do dec (il1);
  inc (il1);
  while iki div n (il2) = 0 do dec (il2);
  inc (il2);
  if il2 = 9 then il2 := 8;
  for ck := il1 to il2 do
  gen (ck, 1, pg, nuo, iki, f);
end;

begin
  assign (f, 'pprime.out');
  rewrite (f);
  nuskaitymas (nuo, iki);
  skaiciuok (nuo, iki, f);
  close (f)
end.
