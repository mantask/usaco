{
PROG: dquery
LANG: PASCAL
}

Program DQUERY;

Type
  Tmas = array [1 .. 40000] of record
    e, w, s, n : word;
    ilge, ilgw, ilgs, ilgn : integer
  end;

var
  mas : Tmas;
  ats : longint;
  viso : word;
  fi, fo : Text;
  kiek, v1, v2, ck : word;
  ilg : integer;
  c : Char;

function kelias (nuo, iki : word; var mas : Tmas) : longint;
var
  eil : array [1 .. 40000] of word;
  atst : array [1 .. 40000] of longint;
  v, gal, uod : word;
begin
  fillchar (atst, sizeof (atst), $FF);
  atst [nuo] := 0;
  eil [1] := nuo;
  gal := 1;
  uod := 2;

  while (gal < uod) do
  begin
    v := eil [gal];
    if (mas [v].e <> 0) and (atst [mas [v].e] = -1) then
    begin
      eil [uod] := mas [v].e;
      atst [mas [v].e] := atst [v] + mas [v].ilge;
      inc (uod)
    end;
    if (mas [v].W <> 0) and (atst [mas [v].w] = -1) then
    begin
      eil [uod] := mas [v].W;
      atst [mas [v].W] := atst [v] + mas [v].ilgW;
      inc (uod)
    end;
    if (mas [v].S <> 0) and (atst [mas [v].s] = -1) then
    begin
      eil [uod] := mas [v].S;
      atst [mas [v].S] := atst [v] + mas [v].ilgS;
      inc (uod)
    end;
    if (mas [v].N <> 0) and (atst [mas [v].n] = -1) then
    begin
      eil [uod] := mas [v].N;
      atst [mas [v].N] := atst [v] + mas [v].ilgN;
      inc (uod)
    end;

    if atst [iki] <> - 1 then
    begin
      kelias := atst [iki];
      exit
    end;

    inc (gal)
  end
end;

begin
  assign (fi, 'dquery.in');
  reset (fi);
  readln (fi, viso, kiek);
  for ck := 1 to kiek do
  begin
    readln (fi, v1, v2, ilg, c, c);
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

  assign (fo, 'dquery.out');
  rewrite (fo);

  readln (fi, kiek);
  for ck := 1 to kiek do
  begin
    readln (fi, v1, v2);
    ats := kelias (v1, v2, mas);
    writeln (fo, ats)
  end;

  close (fi);
  close (fo)
end.
