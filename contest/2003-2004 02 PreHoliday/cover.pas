{
PROG: cover
LANG: PASCAL
}

Program COVER;

Const
  name = 'cover';

Type
  Tmas = array [1 .. 50000, 1 .. 2] of longint;

var
  ats : longint;
  viso : longint;
  mas : Tmas;

Procedure nuskaitymas (var viso : longint; var mas : Tmas);
var
  f : Text;
  ck : longint;
begin
  assign (f, name + '.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    readln (f, mas [ck * 2 - 1, 1], mas [ck * 2, 1]);
    mas [ck * 2 - 1, 2] := ck;
    mas [ck * 2, 2] := ck
  end;
  close (f)
end;

Procedure quicksort (r1, r2 : longint; var mas : TMas);
var
  v1, v2, v, pg : longint;
begin
  v1 := r1;
  v2 := r2;
  v := mas [(v1 + v2) div 2, 1];
  repeat
    while mas [v1, 1] < v do inc (v1);
    while mas [v2, 1] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := mas [v1, 1];
      mas [v1, 1] := mas [v2, 1];
      mas [v2, 1] := pg;
      pg := mas [v1, 2];
      mas [v1, 2] := mas [v2, 2];
      mas [v2, 2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then quicksort (v1, r2, mas);
  if r1 < v2 then quicksort (r1, v2, mas)
end;

function rask (viso : longint; var mas : Tmas) : longint;
var
  pg, max, dabar, ck, ck1 : longint;
  kur, eil : array [1 .. 25000] of longint;
begin
  fillchar (kur, sizeof (kur), 0);
  dabar := 0;
  max := 0;

  for ck := 1 to viso * 2 do
  if kur [mas [ck, 2]] = 0 then
  begin
    inc (dabar);
    kur [mas [ck, 2]] := dabar;
    eil [dabar] := mas [ck, 2]
  end
  else
  begin
    pg := 0;
    for ck1 := kur [mas [ck, 2]] + 1 to dabar do
    if eil [ck1] = 0 then inc (pg);
    if pg > max then max := pg;
    eil [kur [mas [ck, 2]]] := 0
  end;

  rask := max
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, name + '.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  quicksort (1, viso * 2, mas);
  ats := rask (viso, mas);
  rasymas (ats)
end.
