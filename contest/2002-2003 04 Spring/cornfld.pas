{
PROG: cornfld
LANG: PASCAL
}

Program CORNFLD;

Type
  Tmas = array [1 .. 250, 1 .. 250] of byte;
  Tvirs = array [1 .. 100000, 1 .. 2] of byte;
  Tats = array [1 .. 100000] of byte;

var
  mas : Tmas;
  virs : Tvirs;
  viso, ilg, kiek : integer;
  ats : Tats;

Procedure nuskaitymas (var viso, ilg, kiek : Integer; var mas : TMas; var virs : Tvirs);
var
  f : Text;
  ckx, cky : integer;
begin
  assign (f, 'cornfld.in');
  reset (f);
  readln (f, viso, ilg, kiek);
  for cky := 1 to viso do
  begin
    for ckx := 1 to viso do
    read (F, mas [ckx, cky]);
    readln (f)
  end;
  for ckx := 1 to kiek do
  readln (f, virs [ckx, 2], virs [ckx, 1]);
  close (f)
end;

procedure rask (var ats : Tats);
var
  sk : array [1 .. 250, 1 .. 250] of integer;
  ck, ckx, cky : integer;
  min, max : byte;
begin
  fillchar (sk, sizeof (sk), $ff);

  for ck := 1 to kiek do
  begin
    if sk [virs [ck, 1], virs [ck, 2]] = -1
    then
    begin
      min := 255;
      max := 0;
      for ckx := virs [ck, 1] to virs [ck, 1] + ilg - 1 do
      for cky := virs [ck, 2] to virs [ck, 2] + ilg - 1 do
      begin
        if mas [ckx, cky] > max then max := mas [ckx, cky];
        if mas [ckx, cky] < min then min := mas [ckx, cky]
      end;
      sk [virs [ck, 1], virs [ck, 2]] := max - min
    end;
    ats [ck] := sk [virs [ck, 1], virs [ck, 2]]
  end
end;

procedure rasymas (kiek : Integer; var ats : Tats);
var
  f : text;
  ck : Integer;
begin
  assign (f, 'cornfld.out');
  rewrite (f);
  for ck := 1 to kiek do
  writeln (f, ats [ck]);
  close (f)
end;

begin
  nuskaitymas (viso, ilg, kiek, mas, virs);
  rask (ats);
  rasymas (kiek, ats)
end.
