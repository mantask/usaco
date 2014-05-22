{
ID: vkanapo001
PROG: fence6
}

Program FENCE6;

type
  Tmas = array [1 .. 100] of record
    gal : array [1 .. 2] of set of 1 .. 100;
    ilg : Integer
  end;
  Taib = set of 1 .. 100;

var
  mas : TMas;
  ats, viso : Integer;

procedure nuskaitymas (var viso : Integer; var mas : Tmas);
var
  f : Text;
  pg, ck, ck1, ck2, n1, n2, ind, ilg : Integer;
begin
  fillchar (mas, sizeof (mas), 0);
  assign (f, 'fence6.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    readln (f, ind, ilg, N1, N2);
    mas [ind].ilg := ilg;
    for ck1 := 1 to N1 do
    begin
      read (f, pg);
      mas [ind].gal [1] := mas [ind].gal [1] + [pg]
    end;
    readln (f);
    for ck2 := 1 to N2 do
    begin
      read (f, pg);
      mas [ind].gal [2] := mas [ind].gal [2] + [pg]
    end;
    readln (f)
  end;
  close (f)
end;

function galas (v1, v2 : Integer) : integer;
begin
  if v1 in mas [v2].gal [1] then galas := 2
                            else galas := 1
end;

procedure lisk (v, gal, ilg, v1 : integer; var aib : Taib; var min : integer);
var
  ck : Integer;
begin
  if ilg >= min then exit;

  if v in mas [v1].gal [2] then
  begin
    min := ilg;
    exit
  end;

  for ck := 1 to viso do
  if not (ck in aib) and (ck in mas [v].gal [gal]) then
  begin
    aib := aib + [ck];
    lisk (ck, galas (v, ck), ilg + mas [ck].ilg, v1, aib, min);
    aib := aib - [ck]
  end
end;

function rask (viso : Integer; var mas : TMas) : Integer;
var
  min, ck : Integer;
  aib : Taib;
begin
  min := maxint;
  for ck := 1 to viso do
  begin
    aib := [ck];
    lisk (ck, 1, mas [ck].ilg, ck, aib, min);
  end;
  rask := min
end;

procedure rasymas (ats : Integer);
var
  f : Text;
begin
  assign (f, 'fence6.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  ats := rask (viso, mas);
  rasymas (ats)
end.
