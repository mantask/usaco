{
ID: vkanapo001
PROG: starry
}

Program STARRY;

type
  Tmas = array [1 .. 100, 1 .. 100] of integer;
  Teil = array [1 .. 160, 1 .. 2] of integer;
  Tlist = array [1 .. 26] of integer;
  Tsar = array [1 .. 26] of record
    kiek, xx, yy : integer;
    eil : Teil
  end;

var
  mas : Tmas;
  xx, yy : integer;

procedure nuskaitymas (var xx, yy : Integer; var mas : TMas);
var
  f : Text;
  ckx, cky : integer;
  c : Char;
begin
  assign (f, 'starry.in');
  reset (f);
  readln (F, xx);
  readln (f, yy);
  for cky := 1 to yy do
  begin
    for ckx := 1 to xx do
    begin
      read (f, c);
      if c = '1' then mas [ckx, cky] := -1
                 else mas [ckx, cky] := 0
    end;
    readln (f)
  end;
  close (f)
end;

procedure atsek (x, y : integer; var mas : Tmas; var eil : Teil; var ilg : integer);
begin
  mas [x, y] := 0;
  inc (ilg);
  eil [ilg, 1] := x;
  eil [ilg, 2] := y;

  if y > 1 then
  begin
    if mas [x, y - 1] = -1 then atsek (x, y - 1, mas, eil, ilg);
    if (x > 1) and (mas [x - 1, y - 1] = -1) then atsek (x - 1, y - 1, mas, eil, ilg);
    if (x < xx) and (mas [x + 1, y - 1] = -1) then atsek (x + 1, y - 1, mas, eil, ilg)
  end;
  if (x > 1) and (mas [x - 1, y] = -1) then atsek (x - 1, y, mas, eil, ilg);
  if (x < xx) and (mas [x + 1, y] = -1) then atsek (x + 1, y, mas, eil, ilg);
  if y < yy then
  begin
    if mas [x, y + 1] = -1 then atsek (x, y + 1, mas, eil, ilg);
    if (x > 1) and (mas [x - 1, y + 1] = -1) then atsek (x - 1, y + 1, mas, eil, ilg);
    if (x < xx) and (mas [x + 1, y + 1] = -1) then atsek (x + 1, y + 1, mas, eil, ilg)
  end
end;

procedure transf (var eil : Teil; var ilg, ilgx, ilgy : integer);
var
  minx, miny, ck : integer;
begin
  minx := maxint;
  miny := maxint;
  ilgx := -maxint;
  ilgy := -maxint;
  for ck := 1 to ilg do
  begin
    if minx > eil [ck, 1] then minx := eil [ck, 1];
    if minY > eil [ck, 2] then miny := eil [ck, 2];
    if ilgx < eil [ck, 1] then ilgx := eil [ck, 1];
    if ilgy < eil [ck, 2] then ilgy := eil [ck, 2]
  end;
  dec (minx);
  dec (miny);
  for ck := 1 to ilg do
  begin
    dec (eil [ck, 1], minx);
    dec (eil [ck, 2], miny)
  end;
  dec (ilgx, minx);
  dec (ilgy, minY)
end;

procedure rikiuok (r1, r2 : integer; var eil : Teil);
var
  pg, v1, v2, mid1, mid2 : integer;
begin
  v1 := r1;
  v2 := r2;
  mid1 := eil [(v1 + v2) div 2, 1];
  mid2 := eil [(v1 + v2) div 2, 2];
  repeat
    while (eil [v1, 1] < mid1) or ((eil [v1, 1] = mid1) and (eil [v1, 2] < mid2)) do inc (V1);
    while (eil [v2, 1] > mid1) or ((eil [v2, 1] = mid1) and (eil [v2, 2] > mid2)) do dec (V2);
    if v1 <= v2 then
    begin
      pg := eil [v1, 1];
      eil [v1, 1] := eil [v2, 1];
      eil [v2, 1] := pg;
      pg := eil [v1, 2];
      eil [v1, 2] := eil [v2, 2];
      eil [v2, 2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuok (v1, r2, eil);
  if r1 < v2 then rikiuok (r1, v2, eil)
end;

function lygink (var eil : Teil; ilg : integer; var list : Tlist; kiek : integer; var sar : Tsar) : integer;
var
  ck1, ck2 : integer;
  ok : boolean;
begin
  for ck1 := 1 to kiek do
  begin
    ok := true;

    for ck2 := 1 to ilg do
    if (sar [list [ck1]].eil [ck2, 1] <> eil [ck2, 1]) or
       (sar [list [ck1]].eil [ck2, 2] <> eil [ck2, 2]) then
    begin
      ok := false;
      break
    end;

    if ok then
    begin
      lygink := list [ck1];
      exit
    end
  end;

  lygink := 0
end;

procedure pasukXY (var eil : Teil; var ilg, ilgy : integer);
var
  ck, pgx, pgy : integer;
begin
  pgy := ilgy + 1;
  for ck := 1 to ilg do
  begin
    pgx := eil [ck, 1];
    eil [ck, 1] := pgy - eil [ck, 2];
    eil [ck, 2] := pgx
  end
end;

procedure pasukXX (var eil : Teil; ilg, ilgx, ilgy : integer);
var
  ck, pgx, pgy : Integer;
begin
  pgx := ilgx + 1;
  pgy := ilgy + 1;
  for ck := 1 to ilg do
  begin
    eil [ck, 1] := pgx - eil [ck, 1];
    eil [ck, 2] := pgy - eil [ck, 2]
  end
end;

procedure invertuok (var eil : Teil; ilg, ilgx : integer);
var
  ck : integer;
begin
  inc (ilgx);
  for ck := 1 to ilg do eil [ck, 1] := ilgX - eil [ck, 1];
end;

procedure pildyk (var mas : Tmas; var eil : Teil; ilg, kuo : Integer);
var
  ck : integer;
begin
  for ck := 1 to ilg do
  mas [eil [ck, 1], eil [ck, 2]] := kuo
end;

procedure rask (xx, yy : integer; var mas : Tmas);
var
  pgeil, eil : Teil;
  list1, list2 : Tlist;
  ilg, ilgx, ilgy, ckx, cky, ck, kuo, viso, ilg1, ilg2 : integer;
  sar : Tsar;
begin
  viso := 0;
  fillchar (sar, sizeof (sar), 0);
  for cky := 1 to yy do
  for ckx := 1 to xx do
  if mas [ckx, cky] = -1 then
  begin
    ilg := 0;
    atsek (ckx, cky, mas, eil, ilg);
    pgeil := eil;
    transf (eil, ilg, ilgx, ilgy);

    ilg1 := 0;
    ilg2 := 0;
    for ck := 1 to viso do
    if sar [ck].kiek = ilg then
    begin
      if (sar [ck].xx = ilgx) and (sar [ck].yy = ilgY) then
      begin
        inc (ilg1);
        list1 [ilg1] := ck
      end;
      if (sar [ck].yy = ilgx) and (sar [ck].xx = ilgy) then
      begin
        inc (ilg2);
        list2 [ilg2] := ck
      end
    end;

    kuo := 0;

    if ilg1 > 0 then
    begin
      rikiuok (1, ilg, eil);
      kuo := lygink (eil, ilg, list1, ilg1, sar);

      if kuo = 0 then
      begin
        pasukXX (eil, ilg, ilgx, ilgy);
        rikiuok (1, ilg, eil);
        kuo := lygink (eil, ilg, list1, ilg1, sar);

        if kuo = 0 then
        begin
          invertuok (eil, ilg, ilgx);
          rikiuok (1, ilg, eil);
          kuo := lygink (eil, ilg, list1, ilg1, sar);

          if kuo = 0 then
          begin
            pasukXX (eil, ilg, ilgx, ilgy);
            rikiuok (1, ilg, eil);
            kuo := lygink (eil, ilg, list1, ilg1, sar)
          end
        end
      end
    end;

    if (kuo = 0) and (ilg2 > 0) then
    begin
      pasukXY (eil, ilg, ilgy);
      rikiuok (1, ilg, eil);
      kuo := lygink (eil, ilg, list2, ilg2, sar);

      if kuo = 0 then
      begin
        pasukXX (eil, ilg, ilgy, ilgx);
        rikiuok (1, ilg, eil);
        kuo := lygink (eil, ilg, list2, ilg2, sar);

        if kuo = 0 then
        begin
          invertuok (eil, ilg, ilgy);
          rikiuok (1, ilg, eil);
          kuo := lygink (eil, ilg, list2, ilg2, sar);

          if kuo = 0 then
          begin
            pasukXX (eil, ilg, ilgy, ilgx);
            rikiuok (1, ilg, eil);
            kuo := lygink (eil, ilg, list2, ilg2, sar)
          end
        end
      end
    end;

    if kuo = 0 then
    begin
      inc (viso);
      kuo := viso;
      rikiuok (1, ilg, eil);
      sar [viso].eil := eil;
      sar [viso].kiek := ilg;
      sar [viso].xx := ilgx;
      sar [viso].yy := ilgy
    end;

    pildyk (mas, pgeil, ilg, kuo)

  end
end;

procedure rasymas (xx, yy : Integer; var mas : Tmas);
var
  f : text;
  ckx, cky : integer;
begin
  assign (f, 'starry.out');
  rewrite (f);
  for cky := 1 to yy do
  begin
    for ckx := 1 to xx do
    if mas [ckx, cky] = 0 then write (f, '0')
                          else write (f, chr (mas [ckx, cky] + 96));
    writeln (f)
  end;
  close (f)
end;

begin
  nuskaitymas (xx, yy, mas);
  rask (xx, yy, mas);
  rasymas (xx, yy, mas)
end.
