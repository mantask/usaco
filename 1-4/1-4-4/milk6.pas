{
ID: vkanapo001
PROG: milk6
}

Program MILK6;

type
  TG = array [1 .. 32, 1 .. 32] of int64;
  Tel = record
    ind, v1, v2 : integer;
    kaina : longint
  end;
  Tmas = array [1 .. 1000] of Tel;
  Tats = array [1 .. 1000] of integer;

var
  g : Tg;
  visoATS, viso, kiek : Integer;
  minn : int64;
  mas : Tmas;
  ats : Tats;

procedure nuskaitymas (var viso, kiek : Integer; var g : tg; var mas : Tmas);
var
  f : text;
  ck : Integer;
begin
  fillchar (g, sizeof (g), 0);
  assign (f, 'milk6.in');
  reset (f);
  readln (f, viso, kiek);
  for ck := 1 to kiek do
  begin
    readln (f, mas [ck].v1, mas [ck].v2, mas [ck].kaina);
    mas [ck].ind := ck;
    inc (g [mas [ck].v1, mas [ck].v2], mas [ck].kaina)
  end;
  close (f)
end;

procedure rikiuok (r1, r2 : integer; var mas : TMas);
var
  v1, v2 : integer;
  v : int64;
  el : Tel;
begin
  v1 := r1;
  v2 := r2;
  v := mas [(v1 + v2) div 2].kaina;
  repeat
    while mas [v1].kaina > v do inc (v1);
    while mas [v2].kaina < v do dec (v2);
    if v1 <= v2 then
    begin
      el := mas [v1];
      mas [v1] := mas [v2];
      mas [v2] := el;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuok (v1, r2, mas);
  if r1 < v2 then rikiuok (r1, v2, mas)
end;

function min (a, b : longint) : longint;
begin
  if a < b then min := a
           else min := b
end;

function MaxFLOW (viso : Integer; g : Tg) : int64;
var
  totalFLOW : int64;
  ish : array [1 .. 32] of integer;
  sr : array [1 .. 32] of longint;
  jau : array [1 .. 32] of boolean;
  ck, v : integer;
  srautas : longint;
begin
  totalFlow := 0;
  while true do
  begin
    fillchar (ish, sizeof (ish), 0);
    fillchar (sr, sizeof (sr), $FF);
    fillchar (jau, sizeof (jau), 0);
    sr [1] := maxlongint;

    while true do
    begin
      v := -1;
      for ck := 1 to viso do
      if not jau [ck] and (sr [ck] <> -1) and
         ((v = -1) or (sr [ck] > sr [v])) then v := ck;

      if (v = -1) or (v = viso) then break;

      jau [v] := true;

      for ck := 1 to viso do
      if (g [v, ck] <> 0) and (sr [ck] < min (g [v, ck], sr [v])) then
      begin
        ish [ck] := v;
        sr [ck] := min (g [v, ck], sr [v])
      end
    end;

    if v = -1 then break;

    srautas := sr [viso];
    inc (totalFLOW, srautas);

    v := viso;
    while v <> 1 do
    begin
      dec (g [ish [v], v], srautas);
      inc (g [v, ish [v]], srautas);
      v := ish [v]
    end
  end;
  MaxFlow := TotalFlow
end;

procedure skaiciuok (var visoATS : Integer; var minn : int64; var ats : Tats);
var
  pg, max : int64;
  kuris : Integer;
begin
  visoATS := 0;
  minn := 0;
  kuris := 1;
  max := maxflow (viso, g);
  while max > 0 do
  begin
    dec (g [mas [kuris].v1, mas [kuris].v2], mas [kuris].kaina);
    pg := maxflow (viso, g);
    if pg + mas [kuris].kaina = max then
    begin
      max := pg;
      inc (visoATS);
      ats [visoATS] := mas [kuris].ind;
      inc (minn, mas [kuris].kaina)
    end
    else inc (g [mas [kuris].v1, mas [kuris].v2], mas [kuris].kaina);
    inc (kuris)
  end
end;

procedure rikiuokATS (r1, r2 : integer; var mas : TAts);
var
  el, v1, v2, v : Integer;
begin
  v1 := r1;
  v2 := r2;
  v := ats [(v1 + v2) div 2];
  repeat
    while mas [v1] < v do inc (v1);
    while mas [v2] > v do dec (v2);
    if v1 <= v2 then
    begin
      el := mas [v1];
      mas [v1] := mas [v2];
      mas [v2] := el;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuokATS (v1, r2, mas);
  if r1 < v2 then rikiuokATS (r1, v2, mas)
end;

procedure rasymas (minn : int64; visoATS : integer; var ats : Tats);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'milk6.out');
  rewrite (f);
  writeln (f, minn, ' ', visoats);
  for ck := 1 to visoATS do
  writeln (f, ats [ck]);
  close (f)
end;

begin
  nuskaitymas (viso, kiek, g, mas);
  rikiuok (1, kiek, mas);
  skaiciuok (visoATS, minn, ats);
  rikiuokATS (1, visoATS, ats);
  rasymas (minn, visoATS, ats)
end.
