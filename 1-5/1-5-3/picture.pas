{
ID: vkanapo001
PROG: picture
}

Program PICTURE;

type
  TVlinija = record
    y1, y2, x : integer
  end;
  THlinija = record
    x1, x2, y : INteger
  end;
  THmas = array [1 .. 5000] of THlinija;
  TVmas = array [1 .. 5000] of TVlinija;
  Tmas = array [-10000 .. 10000] of integer;

var
  H1mas, h2mas : THmas;
  V1mas, v2mas : TVmas;
  viso : Integer;
  ats : longint;

procedure rikiuokH (r1, r2 : Integer; var hmas : THmas);
var
  v, v1, v2 : Integer;
  pg : THlinija;
begin
  v1 := r1;
  v2 := r2;
  v := hmas [(v1 + v2) div 2].y;
  repeat
    while hmas [v1].y < v do inc (v1);
    while hmas [v2].y > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := hmas [v1];
      hmas [v1] := hmas [v2];
      hmas [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuokH (v1, r2, hmas);
  if r1 < v2 then rikiuokH (r1, v2, hmas)
end;

procedure rikiuokV (r1, r2 : Integer; var vmas : TVmas);
var
  v, v1, v2 : Integer;
  pg : TVlinija;
begin
  v1 := r1;
  v2 := r2;
  v := vmas [(v1 + v2) div 2].x;
  repeat
    while vmas [v1].x < v do inc (v1);
    while vmas [v2].x > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := vmas [v1];
      vmas [v1] := vmas [v2];
      vmas [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuokV (v1, r2, vmas);
  if r1 < v2 then rikiuokV (r1, v2, vmas)
end;

procedure nuskaitymas (var viso : integer; var V1mas, V2mas : TVmas; var H1mas, H2mas : THmas);
var
  F : text;
  ck, x1, x2, y1, y2 : Integer;
begin
  assign (f, 'picture.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    readln (f, x1, y1, x2, y2);
    V1mas [ck].y1 := y1;
    V1mas [ck].y2 := y2;
    V1mas [ck].x := x1;
    h1mas [ck].x1 := x1;
    h1mas [ck].x2 := x2;
    h1mas [ck].y := y1;
    V2mas [ck].y1 := y1;
    V2mas [ck].y2 := y2;
    V2mas [ck].x := x2;
    h2mas [ck].x1 := x1;
    h2mas [ck].x2 := x2;
    h2mas [ck].y := y2
  end;
  close (f);

  rikiuokH (1, viso, h1mas);
  rikiuokH (1, viso, h2mas);
  rikiuokV (1, viso, v1mas);
  rikiuokV (1, viso, v2mas)
end;

function rask (viso : integer; var V1mas, V2mas : TVmas; var H1mas, H2mas : THmas) : longint;
var
  mas : Tmas;
  v1, v2, ck : integer;
  per : longint;
begin
  per := 0;

  v1 := 1;
  v2 := 1;
  fillchar (mas, sizeof (mas), 0);
  while (v1 <= viso) or (v2 <= viso) do
  begin
    if (v1 <= viso) and ((v2 > viso) or (v1mas [v1].x <= v2mas [v2].x)) then
    begin
      for ck := v1mas [v1].y1 to v1mas [v1].y2 - 1 do
      begin
        inc (mas [ck]);
        if mas [ck] = 1 then inc (per)
      end;
      inc (v1)
    end
    else
    begin
      for ck := v2mas [v2].y1 to v2mas [v2].y2 - 1 do
      begin
        dec (mas [ck]);
        if mas [ck] = 0 then inc (per)
      end;
      inc (v2)
    end
  end;

  v1 := 1;
  v2 := 1;
  fillchar (mas, sizeof (mas), 0);
  while (v1 <= viso) or (v2 <= viso) do
  begin
    if (v1 <= viso) and ((v2 > viso) or (h1mas [v1].y <= h2mas [v2].y)) then
    begin
      for ck := h1mas [v1].x1 to h1mas [v1].x2 - 1 do
      begin
        inc (mas [ck]);
        if mas [ck] = 1 then inc (per)
      end;
      inc (v1)
    end
    else
    begin
      for ck := h2mas [v2].x1 to h2mas [v2].x2 - 1 do
      begin
        dec (mas [ck]);
        if mas [ck] = 0 then inc (per)
      end;
      inc (v2)
    end
  end;

  rask := per
end;

procedure rasymas (ats : longint);
var
  f : Text;
begin
  assign (f, 'picture.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;


begin
  nuskaitymas (viso, V1mas, v2mas, h1mas, h2mas);
  ats := rask (viso, V1mas, v2mas, h1mas, h2mas);
  rasymas (ats)
end.
