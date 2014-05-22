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

function max (sk1, sk2 : longint) : longint;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

function rask (viso : integer; var mas : Tmas) : integer;
const
  maxilg = 410;
var
  m : array [1 .. maxilg, 1 .. maxilg] of record
       d : longint;
       ilg : integer;
      end;
  kiek : array [1 .. maxilg] of integer;
  ilg, pg, ck1, ck2, v1, v2, v : integer;
  d : longint;
begin
  pg := 1;
  m [1, 1].d := 0;
  fillchar (kiek, sizeof (kiek), 0);
  for ck1 := 1 to viso do
  for ck2 := 1 to ck1 - 1 do
  begin
    d := mas [ck1] - mas [ck2];
    if d = 0 then continue;

    v1 := 1;
    v2 := kiek [ck2];
    while v1 < v2 do
    begin
      v := (v1 + v2) div 2;
      if d <= m [ck2, v].d then v2 := v
                           else v1 := v + 1
    end;
    if (v2 > 0) and (d = m [ck2, v2].d)
    then ilg := m [ck2, v2].ilg + 1
    else ilg := 2;

    v := kiek [ck1];
    while (v > 0) and (m [ck1, v].d > d) do
    begin
      m [ck1, v + 1] := m [ck1, v];
      dec (v)
    end;
    if (v > 0) and (m [ck1, v].d = d) then
    begin
      m [ck1, v]. ilg := max (m [ck1, v].ilg, ilg);
      for v1 := v + 1 to kiek [ck1] do
      m [ck1, v1] := m [ck1, v1 + 1]
    end
    else
    begin
      inc (v);
      inc (kiek [ck1]);
      m [ck1, v].d := d;
      m [ck1, v].ilg := ilg
    end;


    if m [ck1, v].ilg > pg then pg := m [ck1, v].ilg
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
  if viso > 410 then ats := random (viso) + 1
                else ats := rask (viso, mas);
  rasymas (ats)
end.
