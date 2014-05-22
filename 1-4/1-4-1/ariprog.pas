{
ID: vkanapo001
PROG: ariprog
}

Program ARIPROG;

Type
  Tmas = array [1 .. 32000] of longint;
  Tats = array [1 .. 10000, 1 .. 2] of longint;

var
  vATS, viso, ilg, max : Integer;
  ats : Tats;
  mas : Tmas;

procedure nuskaitymas (var ilg, max : Integer);
var
  f : Text;
begin
  assign (f, 'ariprog.in');
  reset (f);
  readln (f, ilg);
  readln (f, max);
  close (f)
end;

procedure formuok (var viso : integer; var mas : Tmas);
var
  ck1, ck2 : integer;
  pgMAS : array [0 .. 250] of longint;
begin
  for ck1 := 0 to max do
  pgMAS [ck1] := sqr (ck1);

  viso := 1;
  mas [1] := 0;
  for ck1 := 1 to max do
  for ck2 := 0 to ck1 do
  begin
    inc (viso);
    mas [viso] := pgMAS [ck1] + pgMAS [ck2]
  end
end;

procedure rikiuok (r1, r2 : integer; var mas : Tmas);
var
  v1, v2 : integer;
  v, pg : Longint;
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

procedure prastink (var viso : Integer; var mas : Tmas);
var
  pl, ck : Integer;
begin
  pl := 0;
  ck := 1;
  while ck <= viso - pl do
  begin
    mas [ck] := mas [ck + pl];
    while mas [ck] = mas [ck + pl + 1] do inc (pl);
    inc (ck)
  end;
  dec (viso, pl)
end;

function yra (sk : longint; nuo, iki : integer) : boolean;
var
  vid : Integer;
begin
  while nuo < iki do
  begin
    vid := (nuo + iki) div 2;
    if sk <= mas [vid] then iki := vid
                       else nuo := vid + 1;
    if (mas [iki] = sk) or (mas [nuo] = sk) then
    begin
      yra := true;
      exit
    end
  end;
  yra := false
end;

procedure rask (var vATS : integer; var ats : Tats);
var
  pg, ckb, ck, ckYRA : integer;
  ok : boolean;
begin
  if ilg < 4 then pg := 1
  else
  if ilg < 6 then pg := 4
  else
  if ilg < 14 then pg := 12
              else pg := 84;
  vATS := 0;
  for ck := 1 to viso + 1 - ilg do
  for ckb := 1 to (mas [viso] - mas [ck]) div (pg * (ilg - 1)) do
  begin
    ok := true;
    for ckYRA := 1 to ilg - 1 do
    if not yra (mas [ck] + ckYRA * ckB * pg, ck + 1, viso) then
    begin
      ok := false;
      break
    end;
    if ok then
    begin
      inc (vATS);
      ats [vATS, 1] := mas [ck];
      ats [vATS, 2] := ckB * pg
    end
  end
end;

procedure rikiuokREZ (r1, r2, IND : integer; var ats : Tats);
var
  pg, v, v1, v2 : integer;
begin
  v1 := r1;
  v2 := r2;
  v := ats [(v1 + v2) div 2, IND];
  repeat
    while ats [v1, IND] < v do inc (v1);
    while ats [v2, IND] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := ats [v1, 1];
      ats [v1, 1] := ats [v2, 1];
      ats [v2, 1] := pg;
      pg := ats [v1, 2];
      ats [v1, 2] := ats [v2, 2];
      ats [v2, 2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then rikiuokREZ (v1, r2, ind, ats);
  if r1 < v2 then rikiuokREZ (r1, v2, ind, ats)
end;

procedure rik (var vATS : Integer; var ats : Tats);
var
  nuo, iki : integer;
begin
  rikiuokREZ (1, vAts, 2, ats);
  nuo := 1;
  iki := 1;
  while iki < vATS do
  begin
    while ats [nuo, 2] = ats [iki + 1, 2] do inc (iki);
    if nuo < iki then rikiuokREZ (nuo, iki, 1, ats);
    nuo := iki + 1;
    iki := nuo
  end
end;

procedure rasymas (vAts : Integer; var ats : Tats);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'ariprog.out');
  rewrite (f);
  if vATS = 0 then writeln (f, 'NONE')
  else
  for ck := 1 to vATS do
  writeln (f, ats [ck, 1], ' ', ats [ck, 2]);
  close (f)
end;

begin
  nuskaitymas (ilg, max);
  formuok (viso, mas);
  rikiuok (1, viso, mas);
  prastink (viso, mas);
  rask (vAts, ats);
  if vATS > 1 then rik (vATS, ats);
  rasymas (vAts, ats)
end.
