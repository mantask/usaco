{
PROG: dstats
LANG: PASCAL
}

Program DSTATS;

Type
  Tmas = array [1 .. 40000] of record
    e, w, s, n : word;
    ilge, ilgw, ilgs, ilgn : integer
  end;
  Teil = array [1 .. 40000] of longint;
  Tjau = array [1 .. 40000] of boolean;

var
  mas : Tmas;
  ats, viso : word;
  d : longint;

procedure nuskaitymas (var viso : word; var d : longint; var mas : Tmas);
var
  f : Text;
  kiek, v1, v2, ck : word;
  ilg : integer;
  c : Char;
begin
  assign (f, 'dstats.in');
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
  readln (f, d);
  close (f)
end;

procedure kelias (v, v1, v2 : word; atst : longint; var d : longint; var jau : Tjau;
                  var eil : Teil; var ats : word);
var
  pgv2, pgV1 : word;
  pgATST : longint;
begin
  if (mas [v].e <> 0) and not jau [mas [v].e] then
  begin
    jau [mas [v].e] := true;
    pgv2 := v2 + 1;
    eil [pgv2] := mas [v].ilge;
    pgATST := atst + mas [v].ilge;
    pgv1 := v1;
    while (pgATST > d) and (pgv1 < pgv2) do
    begin
      pgATST := pgATST - eil [pgv1];
      inc (pgv1)
    end;
    if pgatst <= d then ats := ats + pgv2 - pgv1 + 1;
    kelias (mas [v].e, pgv1, pgv2, pgatst, d, jau, eil, ats)
  end;
  if (mas [v].W <> 0) and not jau [mas [v].W] then
  begin
    jau [mas [v].W] := true;
    pgv2 := v2 + 1;
    eil [pgv2] := mas [v].ilgW;
    pgATST := atst + mas [v].ilgW;
    pgv1 := v1;
    while (pgATST > d) and (pgv1 < pgv2) do
    begin
      pgATST := pgATST - eil [pgv1];
      inc (pgv1)
    end;
    if pgatst <= d then ats := ats + pgv2 - pgv1 + 1;
    kelias (mas [v].w, pgv1, pgv2, pgatst, d, jau, eil, ats)
  end;
  if (mas [v].S <> 0) and not jau [mas [v].S] then
  begin
    jau [mas [v].S] := true;
    pgv2 := v2 + 1;
    eil [pgv2] := mas [v].ilgS;
    pgATST := atst + mas [v].ilgS;
    pgv1 := v1;
    while (pgATST > d) and (pgv1 < pgv2) do
    begin
      pgATST := pgATST - eil [pgv1];
      inc (pgv1)
    end;
    if pgatst <= d then ats := ats + pgv2 - pgv1 + 1;
    kelias (mas [v].s, pgv1, pgv2, pgatst, d, jau, eil, ats)
  end;
  if (mas [v].N <> 0) and not jau [mas [v].N] then
  begin
    jau [mas [v].N] := true;
    pgv2 := v2 + 1;
    eil [pgv2] := mas [v].ilgN;
    pgATST := atst + mas [v].ilgN;
    pgv1 := v1;
    while (pgATST > d) and (pgv1 < pgv2) do
    begin
      pgATST := pgATST - eil [pgv1];
      inc (pgv1)
    end;
    if pgatst <= d then ats := ats + pgv2 - pgv1 + 1;
    kelias (mas [v].n, pgv1, pgv2, pgatst, d, jau, eil, ats)
  end
end;

function rask (viso : word; d : longint; var mas : tmas) : word;
var
  ats, ck, pg : word;
  kiek : integer;
  jau : Tjau;
  eil : Teil;
begin
  fillchar (jau, sizeof (jau), 0);
  ats := 0;
  for ck := 1 to viso do
  if not jau [ck] then
  begin
    kiek := 0;
    if mas [ck].e <> 0 then inc (kiek);
    if mas [ck].w <> 0 then inc (kiek);
    if mas [ck].s <> 0 then inc (kiek);
    if mas [ck].n <> 0 then inc (kiek);
    if kiek = 1 then
    begin
      with mas [ck] do
      begin
        eil [1] := ilge + ilgw + ilgs + ilgN;
        pg :=  w + s + e + n
      end;
      jau [ck] := true;
      jau [pg] := true;
      if eil [1] <= d then inc (ats);
      kelias (pg, 1, 1, eil [1], d, jau, eil, ats);
    end
  end;
  rask := ats
end;

procedure rasymas (ats : word);
var
  f : Text;
begin
  assign (f, 'dstats.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, d, mas);
  ats := rask (viso, d, mas);
  rasymas (ats)
end.
