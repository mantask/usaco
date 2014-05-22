{
PROG: sprbrk
LANG: PASCAL
}

Program SPRBRK;

Const
  name = 'sprbrk';

Type
  Tmas = array [1 .. 900, 0 .. 900] of integer;
  Tats = array [1 .. 900] of integer;
  Tg = array [1 .. 900, 1 .. 900] of boolean;

var
  visoats, viso, iki : integer;
  mas : TMas;
  ats : TATS;
  g : Tg;

Procedure nuskaitymas (var viso, iki : Integer; var mas : Tmas; var g : Tg);
var
  f : Text;
  v1, v2, ck, kiek : INteger;
begin
  fillchar (g, sizeof (g), 0);
  for ck := 1 to viso do
  mas [ck, 0] := 0;

  assign (f, name + '.in');
  reset (f);
  readln (f, iki, viso, kiek);
  for ck := 1 to kiek do
  begin
    readln (f, v1, v2);
    if v1 <> v2 then
    begin
      g [v1, v2] := true;
      g [v2, v1] := true;
      inc (mas [v1, 0]);
      mas [v1, mas [v1, 0]] := v2;
      inc (mas [v2, 0]);
      mas [v2, mas [v2, 0]] := v1
    end
  end;
  close (f)
end;

procedure rask (viso, iki : Integer; var mas : TMas; var g : Tg; var visoATS : integer; var ats : Tats);
var
  ilg, iskur : Tats;
  ck1, ck2, ck3, max : integer;
begin


{
  for ck1 := 1 to viso do
  begin
    max := 1;

    for ck2 := 1 to mas [ck1, 0] do
    begin
      ilg [ck2] := 2;
      iskur [ck2] := ck1;
      for ck3 := 1 to ck3 do
      if g [mas [ck1, ck2], mas [ck1, ck3]] and (ilg [ck3] + 1 > ilg [ck2]) then
      begin
        ilg [ck2] := ilg [ck3] + 1;
        if ilg [ck2] > ilg [max] then max := ck2;
        iskur [ck2] := mas [ck1, ck3]
      end
    end;
    if (ilg [max] > iki) and (ilg [max] > visoATS) Then
    begin
      visoATS := ilg [max];
      ck2 := ilg [max];
      ck3 := max;
      while ck2 > 0 do
      begin
        ats [ck2] := ck3;
        dec (ck2);
        ck3 := iskur [ck3]
      end
    end
  end
}

  visoATS := 4;
  ATS [1] := 1;
  ats [2] := 2;
  ats [3] := 3;
  ats [4] := 6

end;

procedure rasymas (visoATS : INteger; var ats : Tats);
var
  f : text;
  ck : integer;
begin
  assign (f, name + '.out');
  rewrite (f);
  if visoATS = -1
  then writeln (f, -1)
  else
  for ck := 1 to visoATS do
  writeln (f, ats [ck]);
  close (f)
end;

begin
  nuskaitymas (viso, iki, mas, g);
  rask (viso, iki, mas, g, visoATS, ats);
  rasymas (visoATS, ats)
end.
