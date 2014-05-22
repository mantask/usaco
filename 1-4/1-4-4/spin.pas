{
ID: vkanapo001
PROG: spin
}

Program SPIN;

type
  Tmas = array [1 .. 5] of record
    V, kiek : integer;
    m : array [1 .. 5, 1 .. 2] of integer
  end;

var
  mas : Tmas;
  ats : Integer;

procedure nuskaitymas (var mas : Tmas);
var
  f : Text;
  ck, ck1 : Integer;
begin
  assign (f, 'spin.in');
  reset (f);
  for ck := 1 to 5 do
  begin
    read (f, mas [ck].v, mas [ck].kiek);
    for ck1 := 1 to mas [ck].kiek do
    read (f, mas [ck].m [ck1, 1], mas [ck].m [ck1, 2]);
    readln (f)
  end;
  close (f)
end;

function jau (var mas : Tmas) : boolean;
var
  ck, ck1, ck2 : Integer;
  ok : boolean;
begin
  for ck := 0 to 359 do
  begin
    for ck1 := 1 to 5 do
    begin
      ok := false;
      for ck2 := 1 to mas [ck1].kiek do
      if ((ck < mas [ck1].m [ck2, 1]) and
          (ck + 360 <= mas [ck1].m [ck2, 1] + mas [ck1].m [ck2, 2])) or
         ((ck >= mas [ck1].m [ck2, 1]) and
          (ck <= mas [ck1].m [ck2, 1] + mas [ck1].m [ck2, 2])) then
      begin
        ok := true;
        break
      end;
      if not ok then break
    end;
    if ok then
    begin
      jau := true;
      exit
    end
  end;
  jau := false
end;

procedure stumk (var mas : Tmas);
var
  ck1, ck2 : integer;
begin
  for ck1 := 1 to 5 do
  for ck2 := 1 to mas [ck1].kiek do
  mas [ck1].m [ck2, 1] := (mas [ck1].m [ck2, 1] + mas [ck1].v) mod 360
end;



function skaiciuok (var mas : Tmas) : integer;
var
  t : integer;
begin
  t := 0;
  while not jau (mas) and (t < 1000) do
  begin
    inc (t);
    stumk (mas)
  end;
  if t = 1000 then skaiciuok := -1
              else skaiciuok := t
end;

procedure rasymas (ats : integer);
var
  f : Text;
begin
  assign (f, 'spin.out');
  rewrite (f);
  if ats = -1 then writeln (f, 'none')
              else writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (mas);
  ats := skaiciuok (mas);
  rasymas (ats)
end.
