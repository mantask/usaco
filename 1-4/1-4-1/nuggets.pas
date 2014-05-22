{
ID: vkanapo001
PROG: nuggets
}

Program NUGGETS;

type
  Tmas = array [1 .. 256] of integer;

var
  mas : TMas;
  viso : Integer;
  ats : longint;

procedure rikiuok (r1, r2 : Integer; var mas : Tmas);
var
  v, v1, v2, pg : Integer;
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
  if r1 < v2 then rikiuok (r1, v2, mas);
  if v1 < r2 then rikiuok (v1, r2, mas)
end;

procedure suprastinimas (var viso : Integer; var mas : Tmas);
var
  ck1, ck2 : integer;
begin
  for ck1 := 1 to viso - 1 do
  for ck2 := ck1 + 1 to viso do
  if (mas [ck1] <> -1) and (mas [ck2] <> -1) and (mas [ck2] mod mas [ck1] = 0)
  then mas [ck2] := -1;

  for ck1 := 1 to viso do
  if mas [ck1] = -1 then
  begin
    for ck2 := ck1 to viso - 1 do
    mas [ck2] := mas [ck2 + 1];
    dec (viso)
  end
end;

function MBD (x, y : Integer) : integer;
begin
  if x = 0 then mbd := y
           else mbd := mbd (y mod x, x)
end;

function nuskaitymas (var viso : Integer; var mas : Tmas) : boolean;
var
  f : Text;
  nelyg : boolean;
  pg, ck : Integer;
begin
  nelyg := False;
  assign (f, 'nuggets.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    readln (f, mas [ck]);
    if mas [ck] mod 2 = 1 then nelyg := true
  end;
  close (f);
  rikiuok (1, viso, mas);
  if (not nelyg) or (mas [1] = 1) then nuskaitymas := false
  else
  begin
    suprastinimas (viso, mas);
    pg := mas [1];
    for ck := 2 to viso do
    if pg = 1 then break
              else pg := MBD (pg, mas [ck]);
    if (viso = 1) or (pg <> 1) then nuskaitymas := false
                               else nuskaitymas := true
  end
end;

function rask : longint;
var
  ck : longint;
  kiek, ck1 : Integer;
  sk : array [1 .. 100000] of boolean;
begin
  fillchar (sk, sizeof (sk), 0);
  kiek := 0;
  ck := mas [1];
  for ck1 := 1 to viso do
  sk [mas [ck1]] := true;
  while kiek < mas [1] do
  begin
    if not sk [ck] then kiek := 0
    else
    begin
      for ck1 := 1 to viso do
      sk [ck + mas [ck1]] := true;
      inc (kiek)
    end;
    inc (ck)
  end;
  rask := ck - kiek - 1
end;

procedure rasymas (ats : longint);
var
  f : Text;
begin
  assign (f, 'nuggets.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  if not nuskaitymas (viso, mas) then ats := 0
                                 else ats := rask;
  rasymas (ats)
end.
