{
PROG: marathon
LANG: PASCAL
}

Program MARATHON;

Type
  Tmas = array [1 .. 40000] of record
    e, w, s, n : word;
    ilge, ilgw, ilgs, ilgn : integer
  end;

var
  mas : Tmas;
  ats : longint;
  viso : word;

procedure nuskaitymas (var viso : word; var mas : Tmas);
var
  f : Text;
  kiek, v1, v2, ck : word;
  ilg : integer;
  c : Char;
begin
  assign (f, 'marathon.in');
  reset (f);
  readln (f, viso, kiek);
  for ck := 1 to kiek do
  begin
    readln (f, v1, v2, ilg, c, c);
    case c of
      'E' : begin
              mas [v1].e := v2;
              mas [v1].ilge := ilg;
              mas [v2].w := v1;
              mas [v2].ilgw := ilg
            end;
      'W' : begin
              mas [v1].W := v2;
              mas [v1].ilgw := ilg;
              mas [v2].e := v1;
              mas [v2].ilge := ilg
            end;
      'S' : begin
              mas [v1].s := v2;
              mas [v1].ilgs := ilg;
              mas [v2].n := v1;
              mas [v2].ilgn := ilg
            end;
      'N' : begin
              mas [v1].n := v2;
              mas [v1].ilgn := ilg;
              mas [v2].s := v1;
              mas [v2].ilgs := ilg
            end
    end
  end;
  close (f)
end;

function kelias (nuo : word; var mas : Tmas) : longint;
var
  eil : array [1 .. 40000] of word;
  atst : array [1 .. 40000] of longint;
  v, gal, uod : word;
  pg : longint;
begin
  fillchar (atst, sizeof (atst), $FF);
  atst [nuo] := 0;
  eil [1] := nuo;
  gal := 1;
  uod := 2;
  pg := 0;

  while (gal < uod) do
  begin
    v := eil [gal];
    if (mas [v].e <> 0) and (atst [mas [v].e] = -1) then
    begin
      eil [uod] := mas [v].e;
      atst [mas [v].e] := atst [v] + mas [v].ilge;
      if atst [mas [v].e] > pg then pg := atst [mas [v].e];
      inc (uod)
    end;
    if (mas [v].W <> 0) and (atst [mas [v].w] = -1) then
    begin
      eil [uod] := mas [v].W;
      atst [mas [v].W] := atst [v] + mas [v].ilgW;
      if atst [mas [v].w] > pg then pg := atst [mas [v].w];
      inc (uod)
    end;
    if (mas [v].S <> 0) and (atst [mas [v].s] = -1) then
    begin
      eil [uod] := mas [v].S;
      atst [mas [v].S] := atst [v] + mas [v].ilgS;
      if atst [mas [v].s] > pg then pg := atst [mas [v].s];
      inc (uod)
    end;
    if (mas [v].N <> 0) and (atst [mas [v].n] = -1) then
    begin
      eil [uod] := mas [v].N;
      atst [mas [v].N] := atst [v] + mas [v].ilgN;
      if atst [mas [v].n] > pg then pg := atst [mas [v].n];
      inc (uod)
    end;
    inc (gal)
  end;

  kelias := pg
end;

function rask (viso : word; var mas : tmas) : longint;
var
  ats, pg : longint;
  ck : word;
  kiek : integer;
begin
  ats := 0;
  for ck := 1 to viso do
  begin
    kiek := 0;
    if mas [ck].e <> 0 then inc (kiek);
    if mas [ck].w <> 0 then inc (kiek);
    if mas [ck].s <> 0 then inc (kiek);
    if mas [ck].n <> 0 then inc (kiek);
    if kiek = 1 then
    begin
      pg := kelias (ck, mas);
      if pg > ats then ats := pg
    end
  end;
  rask := ats
end;

procedure rasymas (ats : longint);
var
  f : Text;
begin
  assign (f, 'marathon.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  ats := rask (viso, mas);
  rasymas (ats)
end.
