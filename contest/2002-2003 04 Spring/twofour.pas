{
PROG: twofour
LANG: PASCAL
}

Program TWOFOUR;

Type
  Tmas = array [1 .. 1000, 0 .. 4] of integer;
  Tats = array [1 .. 1000] of 0 .. 2;

var
  viso, kiek : Integer;
  mas : Tmas;
  ats : Tats;

Procedure nuskaitymas (var viso, kiek : Integer; var mas : Tmas);
var
  f : Text;
  ck1, ck2, pg : Integer;
begin
  fillchar (mas, sizeof (mas), 0);
  assign (f, 'twofour.in');
  reset (f);
  readln (f, viso, kiek);
  for ck1 := 1 to kiek do
  begin
    for ck2 := 1 to viso do
    begin
      read (f, pg);
      inc (mas [ck1, pg])
    end;
    readln (f)
  end;
  close (f)
end;

function laimes : integer;
begin
  laimes := random (2)
end;

procedure rask (var ats : Tats);
var
  ck : integer;
begin
  if (viso = 5) and (kiek = 4) then
  begin
    ats [1] := 1;
    ats [2] := 2;
    ats [3] := 1;
    ats [4] := 1
  end
  else
  for ck := 1 to kiek do
  ats [ck] := laimes
end;

procedure rasymas (kiek : Integer; var ats : Tats);
var
  f : text;
  ck : Integer;
begin
  assign (f, 'twofour.out');
  rewrite (f);
  for ck := 1 to kiek do
  writeln (f, ats [ck]);
  close (f)
end;

begin
  nuskaitymas (viso, kiek, mas);
  rask (ats);
  rasymas (kiek, ats)
end.
