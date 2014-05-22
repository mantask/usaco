{
PROG:leap2
LANG:PASCAL
}

Program LEAP2;

const
  ko : array [1 .. 8, 1 .. 2] of integer =
     ((-1, -2), (1, -2), (2, -1), (2, 1), (1, 2), (-1, 2), (-2, 1), (-2, -1));

Type
  Tmas = array [1 .. 280, 1 .. 280] of longint;
  Tlent = array [1 .. 280, 1 .. 280] of record
    x, y : integer;
    l : longint
  end;
  Tats = array [1 .. 78400] of longint;

var
  viso : Integer;
  kiek : longint;
  mas : Tmas;
  ats : Tats;

Procedure nuskaitymas (var viso : Integer; var mas : Tmas);
var
  f : Text;
  ckx, cky : integer;
begin
  assign (f, 'leap2.in');
  reset (f);
  readln (f, viso);
  for cky := 1 to viso do
  begin
    for ckx := 1 to viso do
    begin
      read (f, mas [ckx, cky]);
      if ckx mod 15 = 0 then readln (f)
    end;
    readln (f)
  end;
  close (f)
end;

procedure pildyk (xx, yy : Integer; var kiek : longint; var lent : Tlent);
var
  gal, uod : longint;
  eil : array [1 .. 78400, 1 .. 2] of integer;
  ck, pgx, pgy, x, y : integer;
begin
  if lent [xx, yy].l = 0 then lent [xx, yy].l := 1;
  eil [1, 1] := xx;
  eil [1, 2] := yy;
  gal := 1;
  uod := 2;
  while gal < uod do
  begin
    x := eil [gal, 1];
    y := eil [gal, 2];
    for ck := 1 to 8 do
    begin
      pgx := x + ko [ck, 1];
      pgy := y + ko [ck, 2];
      if (pgx >= 1) and (pgx <= viso) and (pgy >= 1) and (pgy <= viso) and
         (mas [x, y] < mas [pgx, pgy]) and
         ((lent [x, y].l >= lent [pgx, pgy].l) or
          ((lent [pgx, pgy].l = lent [x, y].l + 1) and
           (mas [x, y] < mas [lent [pgx, pgy].x, lent [pgx, pgy].y]))) then
      begin
        lent [pgx, pgy].l := lent [x, y].l + 1;
        lent [pgx, pgy].x := x;
        lent [pgx, pgy].y := y;
        if lent [pgx, pgy].l > kiek then kiek := lent [pgx, pgy].l;
        if (pgy < yy) or ((pgy = yy) and (pgx < xx)) then
        begin
          eil [uod, 1] := pgx;
          eil [uod, 2] := pgy;
          inc (uod)
        end
      end
    end;
    inc (gal)
  end
end;

procedure rask (var kiek : longint; var ats : Tats);
var
  x, y, xx, yy, ckx, cky : integer;
  lent : Tlent;
  pg : longint;
begin
  kiek := 1;
  fillchar (lent, sizeof (lent), 0);
  for cky := 1 to viso do
  for ckx := 1 to viso do
  pildyk (ckx, cky, kiek, lent);

  for ckx := 1 to viso do
  for cky := 1 to viso do
  if lent [ckx, cky].l = kiek then
  begin
    pg := kiek;
    x := ckx;
    y := cky;
    while pg > 0 do
    begin
      ats [pg] := mas [x, y];
      xx := lent [x, y].x;
      yy := lent [x, y].y;
      x := xx;
      y := yy;
      dec (pg)
    end;
    exit
  end
end;

procedure rasymas (kiek : longint; var ats : Tats);
var
  f : text;
  ck : integer;
begin
  assign (f, 'leap2.out');
  rewrite (f);
  writeln (f, kiek);
  for ck := 1 to kiek do
  writeln (f, ats [ck]);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  rask (kiek, ats);
  rasymas (kiek, ats)
end.
