{
PROG:cowpal
LANG:PASCAL
}

Program COWPAL;

type
  Tats = array [1 .. 3000] of integer;
  Tjau = array [1 .. 3000] of boolean;

var
  keli, kiek, viso, ilg, ck : Integer;
  ats : Tats;
  jau : Tjau;

Procedure rikiuok (r1, r2 : Integer; var mas : Tats);
var
  v1, v2, v, pg : Integer;
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

procedure klausk (kuris : integer);
var
  ck : integer;
begin
  for ck := 1 to kuris - 1 do
  write (0);
  write (1);
  for ck := kuris + 1 to viso do
  write (0);
  writeln
end;

procedure gauk (var keli : integer; var jau : Tjau; var ilg : integer; var ats : Tats);
var
  ck : integer;
  c : char;
begin
  keli := 0;
  for ck := 1 to viso do
  begin
    read (c);
    if c = '1' then
    begin
      jau [ck] := true;
      inc (keli)
    end
  end;
  readln;
  inc (ilg);
  ats [ilg] := keli
end;

begin
  readln (viso);
  fillchar (jau, sizeof (jau), 0);
  kiek := 0;
  ilg := 0;

  while kiek < viso - 1 do
  begin
    ck := 1;
    while jau [ck] do inc (ck);
    klausk (ck);
    gauk (keli, jau, ilg, ats);
    inc (kiek, keli)
  end;

  if kiek < viso then
  begin
    inc (ilg);
    ats [ilg] := 1
  end;

  rikiuok (1, ilg, ats);
  write ('solution ');
  for ck := 1 to ilg - 1 do
  write (ats [ck], ' ');
  writeln (ats [ilg])
end.
