{
ID: vkanapo001
PROG: beads
}

program BEADS;

type
  Tg = array [1 .. 350] of 0 .. 2;

var
  ats, viso : integer;
  g : Tg;

procedure nuskaitymas (var viso : integer; var g : Tg);
var
  f : text;
  ck : integer;
  c : char;
begin
  assign (f, 'beads.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    read (f, c);
    case c of
      'r' : g [ck] := 1;
      'b' : g [ck] := 2;
      'w' : g [ck] := 0
    end
  end;
  close (f)
end;

function kiek (sen, kur, ko : byte; nuo, viso : integer; g : Tg) : integer;
var
  r, pg : integer;
begin
  pg := 0;
  r := nuo;
  while (g [r] = ko) or (g [r] = 0) do
  if pg + sen = viso then break
  else
  begin
    inc (pg);
    if kur = 1 then r := (r + viso - 2) mod viso + 1
               else r := r mod viso + 1
  end;
  kiek := pg
end;

function skaiciuok (viso : Integer; var g : Tg) : integer;
var
  v1, v2 : 0 .. 2;
  ilg1, ilg2, max,
  ilg, ck : Integer;
begin
  max := 0;
  for ck := 1 to viso do
  begin
    v1 := g [ck];
    v2 := g [ck mod viso + 1];
    ilg := 0;
    if ((v1 = 1) or (v1 = 0)) and ((v2 = 2) or (v2 = 0)) then
    begin
      ilg1 := kiek (ilg, 1, 1, ck, viso, g);
      ilg2 := kiek (ilg1, 2, 2, ck mod viso + 1, viso, g);
      ilg := ilg1 + ilg2
    end;
    if ((v1 = 2) or (v1 = 0)) and ((v2 = 1) or (v2 = 0)) then
    begin
      ilg1 := kiek (ilg, 1, 2, ck, viso, g);
      ilg2 := kiek (ilg1, 2, 1, ck mod viso + 1, viso, g);
      ilg := ilg1 + ilg2
    end;
    if ilg > max then max := ilg
  end;
  skaiciuok := max
end;

procedure rasyk (ats : integer);
var
  f : text;
begin
  assign (f, 'beads.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, g);
  ats := skaiciuok (viso, g);
  rasyk (ats)
end.
