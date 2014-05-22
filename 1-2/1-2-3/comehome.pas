{
ID: vkanapo001
PROG: comehome
}

Program COMEHOME;

Type
  Tg = array [1 .. 52, 1 .. 52] of integer;
  TQ = set of 1 .. 25;
  Tats = array [1 .. 52] of longint;

var
  g : Tg;
  Q : TQ;
  ats : Tats;
  nr : longint;

procedure nuskaitymas (var Q : Tq; var g : Tg);
var
  f : Text;
  sv, kod1, kod2, pg, ck : integer;
  c, c1, c2 : char;
begin
  fillchar (G, sizeof (G), 0);
  assign (f, 'comehome.in');
  reset (f);
  readln (f, pg);
  for ck := 1 to pg do
  begin
    readln (f, c1, c, c2, sv);
    kod1 := ord (c1);
    kod2 := ord (c2);

    if kod1 < 95 then
    begin
      dec (kod1, 64);
      if (kod1 < 26) then q := q + [kod1]
    end
    else dec (kod1, 70);

    if kod2 < 95 then
    begin
      dec (kod2, 64);
      if kod2 < 26 then q := q + [kod2]
    end
    else dec (kod2, 70);

    if (g [kod1, kod2] = 0) or (g [kod1, kod2] > sv) then g [kod1, kod2] := sv;
    if (g [kod2, kod1] = 0) or (g [kod2, kod1] > sv) then g [kod2, kod1] := sv
  end;
  close (f)
end;

procedure dijkstra (var ats : tats);
var
  min, ck : Integer;
  aib : set of 1 .. 52;
begin
  aib := [1 .. 52];
  for ck := 1 to 52 do
  ats [ck] := maxint;
  ats [26] := 0;

  while aib <> [] do
  begin
    min := -1;
    for ck := 1 to 52 do
    if (ck in aib) and ((min = -1) or (ats [ck] < ats [min])) then min := ck;
    aib := aib - [min];
    for ck := 1 to 52 do
    if (ck in aib) and (g [min, ck] <> 0) and (g [min, ck] + ats [min] < ats [ck])
    then ats [ck] := ats [min] + g [min, ck]
  end
end;

function rask (var ats : Tats) : integer;
var
  min, ck : Integer;
begin
  min := 0;
  for ck := 1 to 25 do
  if (ck in q) and ((min = 0) or (ats [ck] < ats [min])) then min := ck;
  rask := min
end;

procedure rasyk (Nr : integer);
var
  f : Text;
begin
  assign (f, 'comehome.out');
  rewrite (f);
  writeln (f, CHR (nr + 64), ' ', ats [nr]);
  close (f);
end;

begin
  nuskaitymas (q, g);
  dijkstra (ats);
  nr := rask (ats);
  rasyk (nr)
end.
