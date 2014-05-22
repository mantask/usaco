{
ID: vkanapo001
PROG: cowcycle
}

Program COWCYCLE;

Type
  Tmas = array [1 .. 10] of integer;
  Tm = array [1 .. 100] of real;
  Tk = array [25 .. 80, 5 .. 40] of real;

var
  PP, GG, P1, P2, G1, G2 : Integer;
  maxP, maxG, p, g : Tmas;
  maxD : real;
  k : Tk;

procedure nuskaitymas (var PP, GG, P1, P2, G1, G2 : Integer; var k : TK);
var
  f : Text;
  ck1, ck2 : integer;
begin
  assign (f, 'cowcycle.in');
  reset (f);
  readln (F, PP, GG);
  readln (f, P1, P2, G1, G2);
  close (f);
  for ck1 := p1 to P2 do
  for ck2 := g1 to g2 do
  k [ck1, ck2] := ck1 / ck2
end;

procedure rikiuok (r1, r2 : Integer; var mas : TM);
var
  v1, v2 : integer;
  pg, v : real;
begin
  v1 := r1;
  v2 := r2;
  v := mas [(v1 + v2) div 2];
  repeat
    while mas [v1] < v do inc (v1);
    while mas [v2] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := mas [v1];
      mas [v1] := mas [v2];
      mas [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuok (v1, r2, mas);
  if r1 < v2 then rikiuok (r1, v2, mas)
end;

procedure disp;
var
  kiek, ck1, ck2 : Integer;
  v, d : real;
  m : Tm;
begin
  if k [p [pp], g [1]] < 3 * k [p [1], g [gg]] then exit;
  kiek := 0;
  for ck1 := 1 to pp do
  for ck2 := 1 to gg do
  begin
    inc (kiek);
    m [kiek] := k [p [ck1], g [ck2]]
  end;
  rikiuok (1, kiek, m);
  v := 0;
  for ck1 := 1 to kiek - 1 do
  begin
    m [ck1] := m [ck1 + 1] - m [ck1];
    v := v + m [ck1]
  end;
  v := v / (kiek - 1);
  d := 0;
  for ck1 := 1 to kiek - 1 do
  d := d + sqr (v - m [ck1]);
  d := d / (kiek - 1);

  if d < maxd then
  begin
    maxD := D;
    maxP := p;
    maxG := g
  end
end;

procedure gal (kiekG : INteger; var g : Tmas);
var
  ck, nuo : integer;
begin
  if kiekG = 0 then nuo := g1
  else
  begin
    if k [p [pp], g [1]] < 3 * k [p [1], g2] then exit;
    nuo := g [kiekG] + 1
  end;
  inc (kiekG);
  for ck := nuo to g2 do
  begin
    g [kiekG] := ck;
    if kiekG = gg then disp
                  else gal (kiekG, g)
  end
end;

procedure priek (kiekP : Integer; var p : Tmas);
var
  ck, nuo : Integer;
begin
  if kiekP = 0 then nuo := p1
               else nuo := p [kiekP] + 1;
  inc (kiekP);
  for ck := nuo to p2 do
  begin
    p [kiekP] := ck;
    if kiekP = pp then gal (0, g)
                  else priek (kiekP, P)
  end
end;

procedure rasymas (var p, g : TMas);
var
  ck : Integer;
  f : Text;
begin
  assign (f, 'cowcycle.out');
  rewrite (f);
  for ck := 1 to pp - 1 do
  write (f, p [ck], ' ');
  writeln (f, p [pp]);
  for ck := 1 to gg - 1 do
  write (f, g [ck], ' ');
  writeln (f, g [gg]);
  close (f)
end;

begin
  nuskaitymas (PP, GG, P1, P2, G1, G2, k);
  p [1] := 0;
  g [1] := 0;
  maxD := 10000;
  priek (0, p);
  rasymas (maxP, maxG)
end.
