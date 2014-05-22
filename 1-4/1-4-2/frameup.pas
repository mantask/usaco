{
ID: vkanapo001
PROG: frameup
}

Program FRAMEUP;

TYpe
  Tmas = array [1 .. 30, 1 .. 30] of -2 .. 26;
  Tyra = array [1 .. 26] of boolean;
  Tkoord = array [1 .. 26] of record
    x1, x2, y1, y2 : Integer
  end;
  Tant = array [1 .. 26, 1 .. 26] of boolean;
  Tats = array [1 .. 10000] of string;

var
  xx, yy, viso, visoATS : Integer;
  mas : Tmas;
  yra : Tyra;
  ant : Tant;
  Ats : Tats;

procedure nuskaitymas (var xx, yy : integer; var mas : Tmas; var yra : Tyra);
var
  f : Text;
  sk, ckx, cky : integer;
  c : char;
begin
  fillchar (yra, sizeof (yra), 0);
  assign (f, 'frameup.in');
  reset (f);
  readln (f, yy, xx);
  for cky := 1 to yy do
  begin
    for ckx := 1 to xx do
    begin
      read (f, c);
      if c = '.' then sk := 0
                 else sk := ord (c) - 64;
      mas [ckx, cky] := sk;
      if sk <> 0 then yra [sk] := true
    end;
    readln (f)
  end;
  close (f)
end;

procedure aptverk (var koord : Tkoord);
var
  ck, ckx, cky : Integer;
  ok : boolean;
begin
  for ck := 1 to 26 do
  if yra [ck] then
  begin
    ok := true;
    for ckx := 1 to xx do
    begin
      if not ok then break;
      for cky := 1 to yy do
      if mas [ckx, cky] = ck then
      begin
        koord [ck].x1 := ckx;
        ok := false;
        break
      end;
    end;
    ok := true;
    for cky := 1 to yy do
    begin
      if not ok then break;
      for ckx := 1 to xx do
      if mas [ckx, cky] = ck then
      begin
        koord [ck].y1 := cky;
        ok := false;
        break
      end
    end;
    ok := true;
    for ckx := xx downto 1 do
    begin
      if not ok then break;
      for cky := 1 to yy do
      if mas [ckx, cky] = ck then
      begin
        koord [ck].x2 := ckx;
        ok := false;
        break
      end
    end;
    ok := true;
    for cky := yy downto 1 do
    begin
      if not ok then break;
      for ckx := 1 to xx do
      if mas [ckx, cky] = ck then
      begin
        koord [ck].y2 := cky;
        ok := false;
        break
      end
    end
  end
end;

procedure tikrink (var koord : Tkoord);
var
  ck1, ck : Integer;
  ok : boolean;
begin
  for ck := 1 to 26 do
  if yra [ck] then
  repeat
    ok := true;
    for ck1 := koord [ck].x1 to koord [ck].x2 do
    begin
      if mas [ck1, koord [ck].y1] = 0 then
      begin
        ok := false;
        dec (koord [ck].y1, 1);
        break
      end;
      if mas [ck1, koord [ck].y2] = 0 then
      begin
        ok := false;
        inc (koord [ck].y2, 1);
        break
      end
    end;
    if ok then
    for ck1 := koord [ck].y1 to koord [ck].y2 do
    begin
      if mas [koord [ck].x1, ck1] = 0 then
      begin
        ok := false;
        dec (koord [ck].x1, 1);
        break
      end;
      if mas [koord [ck].x2, ck1] = 0 then
      begin
        ok := false;
        inc (koord [ck].x2, 1);
        break
      end
    end
  until ok
end;

procedure rask (var viso : integer; var ant : Tant);
var
  koord : Tkoord;
  ck, ck1 : Integer;
begin
  aptverk (koord);
  tikrink (koord);

  viso := 0;
  fillchar (ant, sizeof (ant), 0);
  for ck := 1 to 26 do
  if yra [ck] then
  begin
    for ck1 := koord [ck].x1 to koord [ck].x2 do
    begin
      if mas [ck1, koord [ck].y1] <> ck then ant [ck, mas [ck1, koord [ck].y1]] := true;
      if mas [ck1, koord [ck].y2] <> ck then ant [ck, mas [ck1, koord [ck].y2]] := true
    end;
    for ck1 := koord [ck].y1 to koord [ck].y2 do
    begin
      if mas [koord [ck].x1, ck1] <> ck then ant [ck, mas [koord [ck].x1, ck1]] := true;
      if mas [koord [ck].x2, ck1] <> ck then ant [ck, mas [koord [ck].x2, ck1]] := true
    end;
    inc (viso)
  end
end;

procedure formuok (eil : string; var viso : Integer; var yra : Tyra; var ant : Tant;
                   var visoATS : Integer; var Ats : Tats);
var
 ck, ck1 : Integer;
 ok : boolean;
 pg : array [1 .. 26] of boolean;
begin
  if length (eil) = viso then
  begin
    inc (visoATS);
    ats [visoATS] := eil;
    exit
  end;
  for ck := 1 to 26 do
  if yra [ck] then
  begin
    ok := true;
    for ck1 := 1 to 26 do
    if ant [ck, ck1] then
    begin
      ok := false;
      break
    end;
    if ok then
    begin
      yra [ck] := false;
      for ck1 := 1 to 26 do
      begin
        pg [ck1] := ant [ck1, ck];
        ant [ck1, ck] := false
      end;
      formuok (chr (ck + 64) + eil, viso, yra, ant, visoAts, ats);
      for ck1 := 1 to 26 do
      ant [ck1, ck] := pg [ck1];
      yra [ck] := true
    end
  end
end;

procedure rikiuok (r1, r2 : Integer; var ats : Tats);
var
  v1,v2 : Integer;
  v, pg : string;
begin
  v1 := r1;
  v2 := r2;
  v := ats [(v1 + v2) div 2];
  repeat
    while ats [v1] < v do inc (v1);
    while ats [v2] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := ats [v1];
      ats [v1] := ats [v2];
      ats [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuok (v1, r2, ats);
  if r1 < v2 then rikiuok (r1, v2, ats)
end;

procedure rasymas (visoAts : integer; var ats : Tats);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'frameup.out');
  rewrite (f);
  for ck := 1 to visoATS do
  writeln (f, ats [ck]);
  close (f)
end;

begin
  nuskaitymas (xx, yy, mas, yra);
  rask (viso, ant);
  visoATS := 0;
  formuok ('', viso, yra, ant, visoAts, ats);
  rikiuok (1, visoAts, Ats);
  rasymas (visoAts, ats)
end.
