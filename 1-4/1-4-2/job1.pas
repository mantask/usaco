{
ID: vkanapo001
PROG: job
}

Program JOB;

Type
  Tmas = array [1 .. 30] of 1 .. 20;
  Tm = array [1 .. 1000, 1 .. 2] of longint;

var
  mas1, mas2 : TMas;
  laik1, laik2 : longint;
  viso, ilg1, ilg2 : integer;

procedure nuskaitymas (var viso, ilg1, ilg2 : Integer; var mas1, mas2 : Tmas);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'job.in');
  reset (f);
  readln (f, viso, ilg1, ilg2);
  for ck := 1 to ilg1 do
  read (f, mas1 [ck]);
  for ck := 1 to ilg2 do
  read (f, mas2 [ck]);
  close (f)
end;

procedure rikiuok (r1, r2 : integer; var mas : Tmas);
var
  pg, v1, v2, v : Integer;
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

procedure rask (var laik1, laik2 : longint);
var
  m1, m2 : Tm;
  iki, kiek, ck, ck1 : integer;
  min : longint;
begin
  fillchar (m1, sizeof (m1), 0);
  fillchar (m2, sizeof (m2), 0);
  for ck := 1 to viso do
  begin
    min := 1;
    if kiek < ilg1 then iki := ck
                   else iki := ck - 1;
    for ck1 := 2 to iki do
    if m1 [ck1, 2] + mas1 [m1 [ck1, 1]] < m1 [min, 2] + mas1 [m1 [min, 1]]
    then min := ck1;

    m1 [ck] :=
  end;

  laik1 := 0;
  laik2 := 0;
  for ck := 1 to viso do
  begin
    if m1 [ck, 2] > laik1 then laik1 := m1 [ck, 2];
    if m2 [ck, 2] + m1 [ck, 2] > laik2 then laik2 := m2 [ck, 2] + m1 [ck, 1]
  end
end;

procedure rasymas (laik1, laik2 : longint);
var
  f : text;
begin
  assign (f, 'job.out');
  rewrite (f);
  writeln (f, laik1, ' ', laik2);
  close (f)
end;

begin
  nuskaitymas (viso, ilg1, ilg2, mas1, mas2);
  rikiuok (1, ilg1, mas1);
  rikiuok (1, ilg2, mas2);
  rask (laik1, laik2);
  rasymas (laik1, laik2)
end.

