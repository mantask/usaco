{
PROG: arithprg
LANG: PASCAL
}

Program arithprg;

const
  fname = 'arithprg';

Type
  Tmas = array [1 .. 2000] of longint;

var
  ats : integer;
  viso : integer;
  mas : Tmas;

Procedure nuskaitymas (var viso : integer; var mas : Tmas);
var
  ck, min : Integer;
  f : Text;
begin
  assign (f, fname + '.in');
  reset (f);
  readln (f, viso);
  min := 0;
  for ck := 1 to viso do
  begin
    readln (f, mas [ck + min]);
    if (ck > 1) and (mas [ck + min] = mas [ck + min - 1]) then min := min - 1
  end;
  viso := viso + min;
  close (f)
end;

function rask (viso : integer; var mas : Tmas) : integer;
var
  ck1, ck2, ck, pg : integer;
  L : array [1 .. 100, 1 .. 100] of integer;
begin
  pg := 2;
  for ck := viso - 1 downto 1 do
  begin
    ck1 := ck - 1;
    ck2 := ck + 1;
    while (ck1 >= 1) and (ck2 <= viso) do
    if mas [ck1] + mas [ck2] < 2 * mas [ck] then
    begin
      inc (ck2);
{      l [ck, ck2] := 2
}    end
    else
    if mas [ck1] + mas [ck2] > 2 * mas [ck] then
    begin
      l [ck1, ck] := 2;
      dec (ck1)
    end
    else
    begin
      L [ck1, ck] := l [ck, ck2] + 1;
      dec (ck1);
      inc (ck2);
      if l [ck1, ck] > pg then pg := l [ck1, ck]
    end;
    while ck1 >= 1 do
    begin
      l [ck1, ck] := 2;
      dec (ck1)
    end
  end;

  rask := pg
end;

procedure rasymas (ats : integer);
var
  f : text;
begin
  assign (f, fname + '.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  ats := rask (viso, mas);
  rasymas (ats)
end.
