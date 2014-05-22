{
ID: vkanapo001
PROG: milk2
}

Program MILK2;

type
  Tmas = array [1 .. 5000, 1 .. 2] of longint;

var
  mas1, mas : Tmas;
  f : Text;
  pg, ck, ck1, viso : integer;
  min, max : longint;
  ok : boolean;

procedure rikiuok (s1, s2 : integer; var mas : Tmas);
var
  v1, v2 : integer;
  v, pg1, pg2 : longint;
begin
  v1 := s1;
  v2 := s2;
  v := mas [(v1 + v2) div 2, 1];
  repeat
    while mas [v1, 1] < v do inc (v1);
    while mas [v2, 1] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg1 := mas [v1, 1];
      pg2 := mas [v1, 2];
      mas [v1, 1] := mas [v2, 1];
      mas [v1, 2] := mas [v2, 2];
      mas [v2, 1] := pg1;
      mas [v2, 2] := pg2;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if s1 < v2 then rikiuok (s1, v2, mas);
  if v1 < s2 then rikiuok (v1, s2, mas)
end;

begin
  fillchar (mas, sizeof (mas), 0);
  fillchar (mas1, sizeof (mas1), 0);
  assign (f, 'milk2.in');
  reset (f);
  readln (f, pg);
  for ck := 1 to pg do
  readln (f, mas1 [ck, 1], mas1 [ck, 2]);
  close (f);

  viso := 0;
  rikiuok (1, pg, mas1);
  for ck := 1 to pg do
  begin
    ok := true;
    for ck1 := 1 to viso do
    if (mas1 [ck, 1] >= mas [ck1, 1]) and (mas1 [ck, 1] <= mas [ck1, 2]) or
       (mas1 [ck, 2] >= mas [ck1, 1]) and (mas1 [ck, 2] <= mas [ck1, 2])
    then
    begin
      ok := false;
      if mas1 [ck, 1] < mas [ck1, 1] then mas [ck1, 1] := mas1 [ck, 1];
      if mas1 [ck, 2] > mas [ck1, 2] then mas [ck1, 2] := mas1 [ck, 2];
      break
    end;
    if ok then
    begin
      inc (viso);
      mas [viso, 1] := mas1 [ck, 1];
      mas [viso, 2] := mas1 [ck, 2]
    end
  end;

  min := 0;
  max := 0;
  for ck := 1 to viso - 1 do
  begin
    if max < mas [ck, 2] - mas [ck, 1] then max := mas [ck, 2] - mas [ck, 1];
    if min < mas [ck + 1, 1] - mas [ck, 2] then min := mas [ck + 1, 1] - mas [ck, 2]
  end;
  if max + mas [viso, 1] < mas [viso, 2] then max := mas [viso, 2] - mas [viso, 1];

  assign (f, 'milk2.out');
  rewrite (f);
  writeln (f, max, ' ', min);
  close (f)
end.
