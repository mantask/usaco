{
ID: vkanapo001
PROG: frac1
}

Program FRAC1;

Type
  Trec = record
    s1, s2 : integer
  end;
  Tmas = array [1 .. 12720] of Trec;

var
  mas : Tmas;
  viso, sk : integer;

procedure nuskaitymas (var sk : integer);
var
  f : text;
begin
  assign (f, 'frac1.in');
  reset (f);
  readln (f, sk);
  close (f)
end;

procedure rikiuok (s1, s2 : integer; var mas : Tmas);
var
  v1, v2, vs1, vs2, v : integer;
  pg : Trec;
begin
  v1 := s1;
  v2 := s2;
  v := (v1 + v2) div 2;
  vs1 := mas [v].s1;
  vs2 := mas [v].s2;
  repeat
    while mas [v1].s1 * vs2 < mas [v1].s2 * vs1 do inc (v1);
    while mas [v2].s1 * vs2 > mas [v2].s2 * vs1 do dec (v2);
    if v1 <= v2 then
     begin
      pg := mas [v1];
      mas [v1] := mas [v2];
      mas [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if s1 < v2 then rikiuok (s1, v2, mas);
  if v1 < s2 then rikiuok (v1, s2, mas)
end;

function DBD (x, y : integer) : integer;
begin
  if x = 0 then DBD := y
           else DBD := DBD (y mod x, x)
end;

procedure gen (var viso : Integer; var mas : Tmas);
var
  ck1, ck2 : integer;
begin
  viso := 0;
  for ck2 := 2 to sk do
  for ck1 := 1 to ck2 - 1 do
  if dbd (ck1, ck2) = 1 then
  begin
    inc (viso);
    mas [viso].s1 := ck1;
    mas [viso].s2 := ck2
  end
end;

procedure rasyk (viso : integer; var mas : Tmas);
var
  f : Text;
  ck : integer;
begin
  assign (f, 'frac1.out');
  rewrite (f);
  writeln (f, '0/1');
  for ck := 1 to viso do
  writeln (f, mas [ck].s1, '/', mas [ck].s2);
  writeln (f, '1/1');
  close (f)
end;

begin
  nuskaitymas (sk);
  gen (viso, mas);
  if 1 < viso then rikiuok (1, viso, mas);
  rasyk (viso, mas)
end.
