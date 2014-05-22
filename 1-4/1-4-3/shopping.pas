{
ID: vkanapo001
PROG: shopping
}

Program SHOPPING;

Type
  Tprod = array [1 .. 5, 1 .. 3] of integer;
  Tnuol = array [1 .. 99] of record
    kiek, kaina : integer;
    prod : array [1 .. 5, 1 .. 2] of integer
  end;

var
  ats, viso, kiek : Integer;
  prod : Tprod;
  nuol : Tnuol;

procedure nuskaitymas (var viso, kiek : Integer; var prod : Tprod; var nuol : TNuol);
var
  f : Text;
  ck, ck1 : Integer;
begin
  fillchar (prod, sizeof (prod), 0);
  fillchar (nuol, sizeof (nuol), 0);
  assign (f, 'shopping.in');
  reset (f);
  readln (f, kiek);
  for ck := 1 to kiek do
  begin
    read (f, nuol [ck].kiek);
    for ck1 := 1 to nuol [ck].kiek do
    read (f, nuol [ck].prod [ck1, 1], nuol [ck].prod [ck1, 2]);
    readln (f, nuol [ck].kaina)
  end;
  readln (f, viso);
  for ck := 1 to viso do
  readln (f, prod [ck, 1], prod [ck, 2], prod [ck, 3]);
  close (f);
end;

procedure sukeisk (var nuol : Tnuol);
var
  pg : integer;
  ckNR, ck1, ck2 : integer;
begin
  for ckNR := 1 to kiek do
  for ck1 := 1 to viso do
  begin
    for ck2 := 1 to viso do
    if nuol [ckNR].prod [ck2, 1] = prod [ck1, 1] then break;
    if ck2 > viso then ck2 := viso;
    pg := nuol [ckNR].prod [ck2, 1];
    nuol [ckNR].prod [ck2, 1] := nuol [ckNR].prod [ck1, 1];
    nuol [ckNR].prod [ck1, 1] := pg;
    pg := nuol [ckNR].prod [ck2, 2];
    nuol [ckNR].prod [ck2, 2] := nuol [ckNR].prod [ck1, 2];
    nuol [ckNR].prod [ck1, 2] := pg
  end
end;

function rask : integer;
var
  mas : array [0 .. 5, 0 .. 5, 0 .. 5, 0 .. 5, 0 .. 5] of integer;
  pg, ck, ck1, ck2, ck3, ck4, ck5 : integer;
begin
  fillchar (mas, sizeof (mas), 255);
  mas [0,0,0,0,0] := 0;
  for ck1 := 0 to prod [1, 2] do
  for ck2 := 0 to prod [2, 2] do
  for ck3 := 0 to prod [3, 2] do
  for ck4 := 0 to prod [4, 2] do
  for ck5 := 0 to prod [5, 2] do
  if mas [ck1, ck2, ck3, ck4, ck5] <> -1 then
  begin
    pg := mas [ck1, ck2, ck3, ck4, ck5];
    if (ck1 + 1 <= prod [1, 2]) and ((mas [ck1 + 1, ck2, ck3, ck4, ck5] = -1) or
        (mas [ck1 + 1, ck2, ck3, ck4, ck5] > pg + prod [1, 3]))
    then mas [ck1 + 1, ck2, ck3, ck4, ck5] := pg + prod [1, 3];
    if (ck2 + 1 <= prod [2, 2]) and ((mas [ck1, ck2 + 1, ck3, ck4, ck5] = -1) or
        (mas [ck1, ck2 + 1, ck3, ck4, ck5] > pg + prod [2, 3]))
    then mas [ck1, ck2 + 1, ck3, ck4, ck5] := pg + prod [2, 3];
    if (ck3 + 1 <= prod [3, 2]) and ((mas [ck1, ck2, ck3 + 1, ck4, ck5] = -1) or
        (mas [ck1, ck2, ck3 + 1, ck4, ck5] > pg + prod [3, 3]))
    then mas [ck1, ck2, ck3 + 1, ck4, ck5] := pg + prod [3, 3];
    if (ck4 + 1 <= prod [4, 2]) and ((mas [ck1, ck2, ck3, ck4 + 1, ck5] = -1) or
        (mas [ck1, ck2, ck3, ck4 + 1, ck5] > pg + prod [4, 3]))
    then mas [ck1, ck2, ck3, ck4 + 1, ck5] := pg + prod [4, 3];
    if (ck5 + 1 <= prod [5, 2]) and ((mas [ck1, ck2, ck3, ck4, ck5 + 1] = -1) or
        (mas [ck1, ck2, ck3, ck4, ck5 + 1] > pg + prod [5, 3]))
    then mas [ck1, ck2, ck3, ck4, ck5 + 1] := pg + prod [5, 3];
    for ck := 1 to kiek do
    if (ck1 + nuol [ck].prod [1, 2] <= prod [1, 2]) and
       (ck2 + nuol [ck].prod [2, 2] <= prod [2, 2]) and
       (ck3 + nuol [ck].prod [3, 2] <= prod [3, 2]) and
       (ck4 + nuol [ck].prod [4, 2] <= prod [4, 2]) and
       (ck5 + nuol [ck].prod [5, 2] <= prod [5, 2]) and
       ((mas [ck1 + nuol [ck].prod [1, 2], ck2 + nuol [ck].prod [2, 2],
              ck3 + nuol [ck].prod [3, 2], ck4 + nuol [ck].prod [4, 2],
              ck5 + nuol [ck].prod [5, 2]] = -1) or
        (mas [ck1 + nuol [ck].prod [1, 2], ck2 + nuol [ck].prod [2, 2],
              ck3 + nuol [ck].prod [3, 2], ck4 + nuol [ck].prod [4, 2],
              ck5 + nuol [ck].prod [5, 2]] > pg + nuol [ck].kaina))
    then mas [ck1 + nuol [ck].prod [1, 2], ck2 + nuol [ck].prod [2, 2],
              ck3 + nuol [ck].prod [3, 2], ck4 + nuol [ck].prod [4, 2],
              ck5 + nuol [ck].prod [5, 2]] := pg + nuol [ck].kaina
  end;
  rask := mas [prod [1, 2], prod [2, 2], prod [3, 2], prod [4, 2], prod [5, 2]]
end;

procedure rasymas (ats : integer);
var
  f : Text;
begin
  assign (f, 'shopping.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, kiek, prod, nuol);
  sukeisk (nuol);
  ats := rask;
  rasymas (ats)
end.
