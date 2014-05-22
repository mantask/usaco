{
PROG: tour
LANG: PASCAL
}

Program TOUR;

Type
  TG = array [1 .. 1000, 1 .. 1000] of integer;

var
  g : Tg;
  ats, viso : integer;

Procedure nuskaitymas (var viso : integer; var g : Tg);
var
  f : Text;
  ck, pg1, pg2, pg, kiek : Integer;
begin
  fillchar (g, sizeof (g), $FF);
  assign (f, 'tour.in');
  reset (f);
  readln (f, viso, kiek);
  for ck := 1 to kiek do
  begin
    readln (F, pg1, pg2, pg);
    g [pg1, pg2] := pg;
    g [pg2, pg1] := pg
  end;
  close (f)
end;

procedure lisk (v : Integer; atgal : boolean; var ilg, ats : longint; var g : Tg);
var
  pg, ck : integer;
begin
  if (ats <> -1) and (ilg >= ats) then exit;
  if atgal then
  begin
    if v = 1 then
    begin
      if (ats = -1) or (ilg < ats) then ats := ilg;
      exit
    end
  end
  else if v = viso then atgal := true;

  for ck := 1 to viso do
  if (ck <> v) and (g [v, ck] <> -1) then
  begin
    pg := g [v, ck];
    g [v, ck] := -1;
    g [ck, v] := -1;
    ilg := ilg + pg;
    lisk (ck, atgal, ilg, ats, g);
    ilg := ilg - pg;
    g [ck, v] := pg;
    g [v, ck] := pg
  end
end;

function rask (var g : Tg) : longint;
var
  ats, ilg : Longint;
begin
  ilg := 0;
  ats := -1;
  lisk (1, false, ilg, ats, g);
  rask := ats
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'tour.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, g);
  ats := rask (g);
  rasymas (ats)
end.
