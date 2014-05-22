{
ID: vkanapo001
PROG: ditch
}

Program DITCH;

type
  Tg = array [1 .. 200, 1 .. 200] of longint;

var
  g : Tg;
  viso : Integer;
  ats : Longint;

procedure nuskaitymas (var viso : integer; var g : Tg);
var
  f : TExt;
  ck, v1, v2, kiek : Integer;
  pg : Longint;
begin
  fillchar (g, sizeof (g), 0);
  assign (f, 'ditch.in');
  reset (f);
  readln (f, kiek, viso);
  for ck := 1 to kiek do
  begin
    readln (f, v1, v2, pg);
    if v1 <> v2 then inc (g [v1, v2], pg)
  end;
  close (f)
end;

function min (sk1, sk2 : Longint) : longint;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

function rask (viso : integer; var g : Tg) : Longint;
var
  maxsr, ats : longint;
  ck, kuris, kitas : Integer;
  jau : array [1 .. 200] of boolean;
  srautas : array [1 .. 200] of longint;
  ish : array [1 .. 200] of integer;
begin
  ats := 0;
  while true do
  begin
    fillchar (jau, sizeof (jau), 0);
    fillchar (srautas, sizeof (srautas), 0);
    fillchar (ish, sizeof (ish), 0);
    srautas [1] := maxlongint;

    while true do
    begin
      maxsr := 0;
      kuris := 0;
      for ck := 1 to viso do
      if not jau [ck] and (srautas [ck] > maxsr) then
      begin
        maxsr := srautas [ck];
        kuris := ck
      end;

      if (kuris = 0) or (kuris = viso) then break;
      jau [kuris] := true;

      for ck := 1 to viso do
      if srautas [ck] < min (maxsr, g [kuris, ck]) then
      begin
        ish [ck] := kuris;
        srautas [ck] := min (maxsr, g [kuris, ck]);
      end
    end;
    if kuris = 0 then break;

    inc (ats, srautas [viso]);
    kuris := viso;
    while kuris <> 1 do
    begin
      kitas := ish [kuris];
      dec (g [kitas, kuris], srautas [viso]);
      inc (g [kuris, kitas], srautas [viso]);
      kuris := kitas
    end
  end;
  rask := ats
end;

procedure rasymas (ats : longint);
var
  f : Text;
begin
   assign (f, 'ditch.out');
   rewrite (f);
   writeln (f, ats);
   close (F)
end;

begin
  nuskaitymas (viso, g);
  ats := rask (viso, g);
  rasymas (ats)
end.
