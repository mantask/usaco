{
ID: vkanapo001
PROG: wissqu
}

program WISSQU;

type
  Tmas = array [1 .. 4, 1 .. 4] of char;
  Tkiek = array ['A' .. 'E'] of integer;
  Tjau = array [1 .. 4, 1 .. 4] of boolean;
  Tats = array [1 .. 16] of record
    c : char;
    x, y : Integer
  end;

var
  mas : TMas;
  kiek : Tkiek;
  jau : Tjau;
  ats : Tats;
  viso : Integer;

procedure nuskaitymas (var mas : TMas);
var
  f : text;
  ckx, cky : Integer;
begin
  assign (f, 'wissqu.in');
  reset (f);
  for cky := 1 to 4 do
  begin
    for ckx := 1 to 4 do
    read (f, mas [ckx, cky]);
    readln (f)
  end;
  close (f)
end;

function galima (c : char; x, y : integer; var mas : Tmas) : boolean;
begin
  if ((x > 1) and
      ((mas [x - 1, y] = c) or
       (y > 1) and (mas [x - 1, y - 1] = c) or
       (y < 4) and (mas [x - 1, y + 1] = c))) or
     ((x < 4) and
      ((mas [x + 1, y] = c) or
       (y > 1) and (mas [x + 1, y - 1] = c) or
       (y < 4) and (mas [x + 1, y + 1] = c))) or
     ((y > 1) and (mas [x, y - 1] = c)) or
     ((y < 4) and (mas [x, y + 1] = c))
  then galima := false
  else galima := true
end;

procedure geriau (var kuris, uz : Tats);
var
  ck : integer;
begin
  ck := 1;
  while (kuris [ck].c = uz [ck].c) and
        (kuris [ck].y = uz [ck].y) and
        (kuris [ck].x = uz [ck].x) do
  inc (ck);

  if (kuris [ck].c < uz [ck].c) or
     ((kuris [ck].c = uz [ck].c) and (kuris [ck].y < uz [ck].y)) or
     ((kuris [ck].c = uz [ck].c) and (kuris [ck].y = uz [ck].y) and (kuris [ck].x < uz [ck].x))
  then uz := kuris
end;

procedure lisk (liko : integer; var viso : integer; dabar : Tats; var ats : Tats);
var
  pg, ck : char;
  ckx, cky : integer;
begin
  if liko = 0 then
  begin
    inc (viso);
    geriau (dabar, ats);
    exit
  end;

  for ck := 'A' to 'E' do
  if kiek [ck] > 0 then
  for ckx := 1 to 4 do
  for cky := 1 to 4 do
  if not jau [ckx, cky] and ((mas [ckx, cky] <> ck) and galima (ck, ckx, cky, mas)) then
  begin
    pg := mas [ckx, cky];
    mas [ckx, cky] := ck;
    jau [ckx, cky] := true;
    dec (kiek [ck]);
    with dabar [17 - liko] do
    begin
      c := ck;
      x := ckx;
      y := cky
    end;
    lisk (liko - 1, viso, dabar, ats);
    mas [ckx, cky] := pg;
    jau [ckx, cky] := false;
    inc (kiek [ck])
  end
end;

procedure rask (var viso : integer; var ats : Tats);
var
  pg : char;
  ckx, cky : integer;
  dabar : Tats;
begin
  ats [1].c := 'Z';
  kiek ['A'] := 3;
  kiek ['B'] := 3;
  kiek ['C'] := 3;
  kiek ['D'] := 4;
  kiek ['E'] := 3;
  fillchar (jau, sizeof (jau), 0);
  viso := 0;

  for ckx := 1 to 4 do
  for cky := 1 to 4 do
  if (mas [ckx, cky] <> 'D') and galima ('D', ckx, cky, mas) then
  begin
    pg := mas [ckx, cky];
    mas [ckx, cky] := 'D';
    jau [ckx, cky] := true;
    dec (kiek ['D']);
    with dabar [1] do
    begin
      c := 'D';
      x := ckx;
      y := cky
    end;
    lisk (15, viso, dabar, ats);
    mas [ckx, cky] := pg;
    jau [ckx, cky] := false;
    inc (kiek ['D'])
  end
end;

procedure rasymas (viso : integer; var ats : tats);
var
  f : text;
  ck : integer;
begin
  assign (f, 'wissqu.out');
  rewrite (f);
  for ck := 1 to 16 do
  with ats [ck] do
  writeln (f, c, ' ', y, ' ', x);
  writeln (f, viso);
  close (f)
end;

begin
  nuskaitymas (mas);
  rask (viso, ats);
  rasymas (viso, ats)
end.
