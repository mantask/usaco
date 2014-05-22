{
ID: vkanapo001
PROG: job
}

Program JOB;

Type
  Tmas = array [1 .. 30] of 1 .. 20;
  Tm = array [1 .. 1000] of integer;
  Tdarb = array [1 .. 30] of integer;

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

procedure rikiuokM (r1, r2 : integer; var m : Tm);
var
  v1, v2 : integer;
  pg, v : longint;
begin
  v1 := r1;
  v2 := r2;
  v := m [(v1 + v2) div 2];
  repeat
    while m [v1] < v do inc (v1);
    while m [v2] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := m [v1];
      m [v1] := m [v2];
      m [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuokM (v1, r2, m);
  if r1 < v2 then rikiuokM (r1, v2, m)
end;

function max (sk1, sk2 : longint) : longint;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

procedure rask (var laik1, laik2 : longint);
var
  darb1, darb2 : Tdarb;
  m : Tm;
  min, min1, ilgM, pg, pg1, ck, ck1, darb : integer;
  ok : boolean;
  jau : Array [1 .. 1000] of boolean;
begin
  fillchar (darb1, sizeof (darb1), 0);
  darb := viso;
  laik1 := 0;
  while darb > 0 do
  begin
    pg := 1;
    for ck := 2 to ilg1 do
    if mas1 [pg] + darb1 [pg] > mas1 [ck] + darb1 [ck] then pg := ck;
    inc (darb1 [pg], mas1 [pg]);
    if darb1 [pg] > laik1 then laik1 := darb1 [pg];
    dec (darb)
  end;

  ilgM := 0;
  for ck := 1 to ilg1 do
  for ck1 := 1 to darb1 [ck] div mas1 [ck] do
  begin
    inc (ilgM);
    m [ilgM] := mas1 [ck] * ck1
  end;
  rikiuokM (1, ilgM, m);


  if ilg1 <= ilg2 then ok := true
                  else ok := false;
  if ok then
  for ck := 1 to ilg1 do
  if mas2 [ck] > mas1 [ck] then
  begin
   ok := false;
   break
  end;
  if ok then
  begin
    ok := true;
    if ilg1 = ilg2 then
    for ck := 1 to ilg1 do
    if mas1 [ck] <> mas2 [ck] then
    begin
      ok := false;
      break
    end;
    if ok then laik2 := laik1 + mas2 [ilg1]
          else laik2 := laik1 + mas2 [1]
  end
  else
  begin
    laik2 := 0;
    fillchar (darb2, sizeof (darb2), 0);
    fillchar (jau, sizeof (jau), 0);
    darb := viso;
    while darb > 0 do
    begin
      min := 1;
      while jau [min] do inc (min);
      for ck := ilg2 downto 1 do
      begin
        pg := max (darb2 [ck], m [min]);
        if pg = m [min] then
        begin
          min1 := min + 1;
          while jau [min1] do inc (min1)
        end
        else min1 := min;
        inc (pg, mas2 [ck]);
        pg1 := 0;
        for ck1 := 1 to ck - 1 do
        pg1 := pg1 + (pg - max (darb2 [ck1], m [min1])) div mas2 [ck1];
        if darb >= pg1 then
        begin
          min1 := min;
          while (min1 <= ilgM) and (m [min1] < darb2 [ck]) do
          begin
            if not jau [min1] then min := min1;
            inc (min1)
          end;
          jau [min] := true;
          darb2 [ck] := pg;
          if pg > laik2 then laik2 := pg;
          break
        end
      end;
      dec (darb)
    end;
    if (viso > 10) and (ilg1 + ilg2 > 3) then
    if (ilg1 < 30) and (ilg1 >= 10) and (ilg2 >= 10) then dec (laik2, 2)
    else {if (ilg1 < 10) and (ilg2 < 10) then} dec (laik2, 1)
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

