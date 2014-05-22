{
ID: vkanapo001
PROG: inflate
}

Program INFLATE;

Type                      {task, min}
  Tmin = array [1 .. 10000, 1 .. 2] of integer;
  Tmas = array [0 .. 10000] of longint;

var
  min : Tmin;
  mas : Tmas;
  viso, laik : integer;

procedure nuskaitymas (var viso, laik : Integer; var min : TMin);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'inflate.in');
  reset (f);
  readln (f, laik, viso);
  for ck := 1 to viso do
  readln (f, min [ck, 1], min [ck, 2]);
  close (f)
end;

procedure rikiuok (s1, s2 : integer; var min : Tmin);
var
  pg1, pg2, v1, v2, v : Integer;
begin
  v1 := s1;
  v2 := s2;
  v := min [(v1 + v2) div 2, 2];
  repeat
    while min [v1, 2] < v do inc (v1);
    while min [v2, 2] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg1 := min [v1, 1];
      pg2 := min [v1, 2];
      min [v1, 1] := min [v2, 1];
      min [v1, 2] := min [v2, 2];
      min [v2, 1] := pg1;
      min [v2, 2] := pg2;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if s1 < v2 then rikiuok (s1, v2, min);
  if v1 < s2 then rikiuok (v1, s2, min)
end;

procedure varyk (var mas : Tmas);
var
  ck1, ck2 : integer;
begin
  for ck1 := 1 to laik do
  begin
    for ck2 := 1 to viso do
    begin
      if min [ck2, 2] > ck1 then break;
      if (ck1 >= min [ck2, 2]) and (mas [ck1 - min [ck2, 2]] + min [ck2, 1] > mas [ck1])
      then mas [ck1] := mas [ck1 - min [ck2, 2]] + min [ck2, 1]
    end
  end
end;

procedure rasyk (ats : longint);
var
  f : Text;
begin
  assign (f, 'inflate.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, laik, min);
  fillchar (mas, sizeof (mas), 0);
  rikiuok (1, viso, min);
  varyk (mas);
  rasyk (mas [laik])
end.
