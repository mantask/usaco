{
ID: vkanapo001
PROG: stall4
}

Program STALL4;

type
  Tg = array [1 .. 402, 1 .. 402] of 0 .. 1;

var
  ats, viso : Integer;
  g : Tg;

procedure nuskaitymas (var viso : Integer; var g : TG);
var
  f : text;
  ck1, ck2, kiek, pad, kar, pg : Integer;
begin
  fillchar (g, sizeof (g), 0);
  assign (f, 'stall4.in');
  reset (f);
  readln (f, kar, pad);
  viso := 2 + kar + pad;
  for ck1 := 1 to kar do
  begin
    g [1, ck1 + 1] := 1;
    read (f, kiek);
    for ck2 := 1 to kiek do
    begin
      read (f, pg);
      g [ck1 + 1, pg + 1 + kar] := 1
    end;
    readln (f)
  end;
  for ck1 := 1 to pad do
  g [1 + kar + ck1, viso] := 1;
  close (f)
end;

function rask (viso : Integer; var g : Tg) : Integer;
var
  ck, kuris, kitas, sr, maxSR : Integer;
  jau : array [1 .. 402] of boolean;
  srautas, ish : Array [1 .. 402] of integer;
begin
  sr := 0;
  while true do
  begin
    fillchar (jau, sizeof (jau), 0);
    fillchar (ish, sizeof (ish), 0);
    fillchar (srautas, sizeof (srautas), 0);
    srautas [1] := maxint;
    while true do
    begin
      kuris := 0;
      maxSR := 0;
      for ck := 1 to viso do
      if not jau [ck] and (srautas [ck] > maxSR) then
      begin
        maxSR := srautas [ck];
        kuris := ck
      end;

      if (kuris = 0) or (kuris = viso) then break;

      jau [kuris] := true;
      for ck := 1 to viso do
      if srautas [ck] < g [kuris, ck] then
      begin
        inc (srautas [ck], 1);
        ish [ck] := kuris
      end
    end;

    if kuris = 0 then break;
    inc (sr, srautas [viso]);

    kuris := viso;
    while kuris <> 1 do
    begin
      kitas := ish [kuris];
      g [kitas, kuris] := 0;
      g [kuris, kitas] := 1;
      kuris := kitas
    end
  end;
  rask := sr
end;

procedure rasymas (ats : Integer);
var
  f : Text;
begin
  assign (f, 'stall4.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, g);
  ats := rask (viso, g);
  rasymas (ats)
end.
