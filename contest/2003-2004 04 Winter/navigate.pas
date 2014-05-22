{
PROG: navigate
LANG: PASCAL
}

Program NAVIGATE;

Type
  Tmas = array [1 .. 40000] of record
    e, w, s, n : word;
    ilge, ilgw, ilgs, ilgn : integer
  end;
  Tel = record
    v1, v2, ind : word
  end;
  Tuzkl = array [1 .. 40000] of Tel;

var
  mas : Tmas;
  uzkl : Tuzkl;
  ats : longint;
  c : char;
  ilg : integer;
  v1, v2, kuri, ck, viso, kiek, kiekUZKL : word;
  fi, fo : Text;

Procedure quicksort (r1, r2 : word; var mas : Tuzkl);
var
  v1, v2, v : word;
  pg : Tel;
begin
  v1 := r1;
  v2 := r2;
  v := mas [(v1 + v2) div 2].ind;
  repeat
    while mas [v1].ind < v do inc (v1);
    while mas [v2].ind > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := mas [v1];
      mas [v1] := mas [v2];
      mas [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then quicksort (v1, r2, mas);
  if r1 < v2 then quicksort (r1, v2, mas)
end;

procedure idek (v1, v2 : word; ilg : integer; c : char; var mas : Tmas);
begin
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

function kelias (nuo, iki : word; var mas : Tmas) : longint;
var
  xx, yy : array [1 .. 40000] of longint;
  jau : array [1 .. 40000] of boolean;
  eil : array [1 .. 40000] of word;
  gal, uod, v : word;
begin
  fillchar (xx, sizeof (xx), $FF);
  fillchar (yy, sizeof (yy), $FF);
  fillchar (jau, sizeof (jau), 0);

  xx [nuo] := 0;
  yy [nuo] := 0;
  eil [1] := nuo;
  jau [nuo] := true;
  gal := 1;
  uod := 2;

  while gal < uod do
  begin
    v := eil [gal];

    if (mas [v].e <> 0) and not jau [mas [v].e] then
    begin
      jau [mas [v].e] := true;
      xx [mas [v].e] := xx [v] + mas [v].ilge;
      yy [mas [v].e] := yy [v];
      eil [uod] := mas [v].e;
      inc (uod)
    end;
    if (mas [v].w <> 0) and not jau [mas [v].w] then
    begin
      jau [mas [v].w] := true;
      xx [mas [v].w] := xx [v] - mas [v].ilgw;
      yy [mas [v].w] := yy [v];
      eil [uod] := mas [v].w;
      inc (uod)
    end;
    if (mas [v].S <> 0) and not jau [mas [v].s] then
    begin
      jau [mas [v].s] := true;
      xx [mas [v].S] := xx [v];
      yy [mas [v].S] := yy [v] + mas [v].ilgS;
      eil [uod] := mas [v].S;
      inc (uod)
    end;
    if (mas [v].N <> 0) and not jau [mas [v].n] then
    begin
      jau [mas [v].n] := true;
      xx [mas [v].N] := xx [v];
      yy [mas [v].N] := yy [v] - mas [v].ilgN;
      eil [uod] := mas [v].N;
      inc (uod)
    end;

    if xx [iki] <> -1 then
    begin
      kelias := abs (xx [iki]) + abs (yy [iki]);
      exit
    end;

    inc (gal)
  end;

  kelias := -1
end;

begin
  assign (fi, 'navigate.in');
  reset (fi);
  readln (fi, viso, kiek);
  for ck := 1 to kiek do
  readln (fi);
  readln (fi, kiekUZKL);
  for ck := 1 to kiekUZKL do
  readln (fi, uzkl [ck].v1, uzkl [ck].v2, uzkl [ck].ind);
  quicksort (1, kiekUZKL, uzkl);

  assign (fo, 'navigate.out');
  rewrite (fo);

  reset (fi);
  readln (fi);
  ck := 1;
  fillchar (mas, sizeof (mas), 0);
  for kuri := 1 to kiekUZKL do
  begin
    while (ck <= uzkl [kuri].ind) do
    begin
      readln (fi, v1, v2, ilg, c, c);
      idek (v1, v2, ilg, c, mas);
      inc (ck)
    end;
    ats := kelias (uzkl [kuri].v1, uzkl [kuri].v2, mas);
    writeln (fo, ats)
  end;

  close (fi);
  close (fo)
end.
