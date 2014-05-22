{
ID: vkanapo001
PROG: packrec
}

Program PACKREC;

Type
  Tkoord = array [1 .. 4, 1 .. 2] of integer;
  Tmas = array [1 .. 4, 1 .. 4] of integer;
  Tjau = array [1 .. 4] of boolean;
  Tats = array [1 .. 10000, 1 .. 3] of integer;

var
  ko : Tkoord;
  mas : Tmas;
  jau : Tjau;
  ats : Tats;
  s : Integer;

procedure nuskaitymas (var ko : Tkoord);
var
  f : text;
  ck : integer;
begin
  assign (f, 'packrec.in');
  reset (f);
  for ck := 1 to 4 do
  readln (f, ko [ck, 1], ko [ck, 2]);
  close (f)
end;

function rask (d, uod : integer; var mas : Tmas) : integer;
var
  maz, ck : Integer;
begin
  maz := maxint;
  for ck := 1 to uod do
  if (mas [ck, 4] > d) and (maz > mas [ck, 4]) then maz := mas [ck, 4];
  rask := maz
end;

function min (sk1, sk2 : integer) : integer;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

function max (sk1, sk2 : integer) : integer;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

function laisva (x0, y0, x, y, uod : integer; var mas : Tmas; var kiek : integer) : boolean;
var
  ck : Integer;
  ok1, ok2 : boolean;
begin
  x := x0 + x;
  y := y0 + y;
  for ck := 1 to uod - 1 do
  begin
    if x0 < mas [ck, 1] then ok1 := (mas [ck, 1] >= x0) and (mas [ck, 1] < x)
                        else ok1 := (x0 >= mas [ck, 1]) and (x0 < mas [ck, 3]);
    if y0 < mas [ck, 2] then ok2 := (mas [ck, 2] >= y0) and (mas [ck, 2] < y)
                        else ok2 := (y0 >= mas [ck, 2]) and (y0 < mas [ck, 4]);
    if ok1 and ok2 then
    begin
      laisva := false;
      kiek := mas [ck, 3];
      exit
    end
  end;
  kiek := x0;
  laisva := true
end;

procedure plotas (uod : Integer; var mas : Tmas; var s : integer; var ats : Tats);
var
  maz, pg, ck, xx, yy : Integer;
begin
  xx := 0;
  yy := 0;
  for ck := 1 to uod do
  begin
    if mas [ck, 3] > xx then xx := mas [ck, 3];
    if mas [ck, 4] > yy then yy := mas [ck, 4]
  end;
  dec (xx);
  dec (yy);
  pg := xx * yy;
  if (s = 0) or (ats [1, 3] > pg) then
  begin
    s := 1;
    ats [S, 1] := min (xx, yy);
    ats [S, 2] := max (xx, yy);
    ats [S, 3] := pg
  end
  else if ats [1, 3] = pg then
  begin
    ck := 1;
    maz := min (xx, yy);
    while (ck <= S) and (ats [ck, 1] <> maz) do inc (ck);
    if ck > s then
    begin
      inc (s);
      ats [S, 1] := min (xx, yy);
      ats [S, 2] := max (xx, yy);
      ats [ck, 3] := pg
    end
  end
end;

procedure varyk (uod : Integer; var mas : Tmas; var jau : Tjau;
                 var S : integer; var ats : Tats);
var
  pg, ck, cky, ckx : Integer;
  buvo : boolean;
begin
  buvo := false;
  for ck := 2 to 4 do
  if not jau [ck] then
  begin
     buvo := true;
     jau [ck] := true;
     inc (uod);

     cky := 1;
     pg := 0;
     while not laisva (1, cky, ko [ck, 1], ko [ck, 2], uod, mas, ckX) do
     begin
       while not laisva (ckx, cky, ko [ck, 1], ko [ck, 2], uod, mas, ckx) do;
       mas [uod, 1] := ckx;
       mas [uod, 2] := cky;
       mas [uod, 3] := ckx + ko [ck, 1];
       mas [uod, 4] := cky + ko [ck, 2];
       varyk (uod, mas, jau, s, ats);
       pg := rask (pg, uod, mas);
       ckY := pg;
     end;
     mas [uod, 1] := 1;
     mas [uod, 2] := cky;
     mas [uod, 3] := 1 + ko [ck, 1];
     mas [uod, 4] := cky + ko [ck, 2];
     varyk (uod, mas, jau, s, ats);

     cky := 1;
     pg := 0;
     while not laisva (1, cky, ko [ck, 2], ko [ck, 1], uod, mas, ckX) do
     begin
       while not laisva (ckx, cky, ko [ck, 2], ko [ck, 1], uod, mas, ckx) do;
       mas [uod, 1] := ckx;
       mas [uod, 2] := cky;
       mas [uod, 3] := ckx + ko [ck, 2];
       mas [uod, 4] := cky + ko [ck, 1];
       varyk (uod, mas, jau, s, ats);
       pg := rask (pg, uod, mas);
       cky := pg
     end;
     mas [uod, 1] := 1;
     mas [uod, 2] := cky;
     mas [uod, 3] := 1 + ko [ck, 2];
     mas [uod, 4] := cky + ko [ck, 1];
     varyk (uod, mas, jau, s, ats);

     dec (uod);
     jau [ck] := false
  end;

  if not buvo then plotas (uod, mas, S, ats)
end;

procedure rasymas (s : integer; var ats : Tats);
var
  f : Text;
  sen, pg, ck1, ck, maz : Integer;
begin
  assign (f, 'packrec.out');
  rewrite (f);
  writeln (f, ats [1, 3]);
  sen := 0;
  for ck1 := 1 to s do
  begin
    maz := maxint;
    for ck := 1 to s do
    if (ats [ck, 1] > sen) and (ats [ck, 1] < maz) then
    begin
      maz := ats [ck, 1];
      pg := ck
    end;
    sen := ats [pg, 1];
    writeln (f, ats [pg, 1], ' ', ats [pg, 2])
  end;
  close (f)
end;

begin
  nuskaitymas (ko);
  fillchar (jau, sizeof (jau), 0);
  jau [1] := true;
  mas [1, 1] := 1;
  mas [1, 2] := 1;
  mas [1, 3] := 1 + ko [1, 1];
  mas [1, 4] := 1 + ko [1, 2];
  varyk (1, mas, jau, s, ats);
  mas [1, 1] := 1;
  mas [1, 2] := 1;
  mas [1, 3] := 1 + ko [1, 2];
  mas [1, 4] := 1 + ko [1, 1];
  varyk (1, mas, jau, s, ats);
  rasymas (s, ats)
end.
