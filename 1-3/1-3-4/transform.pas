{
ID: vkanapo001
PROG: transform
}

Program TRANSFORM;

Type
  Tmas = array [1 .. 10, 1 .. 10] of boolean;

Var
  viso : integer;
  mas1, mas2 : Tmas;

Procedure nuskaitymas (var viso : Integer; var mas1, mas2 : Tmas);
var
  f : Text;
  ckx, cky : Integer;
  c : char;
begin
  assign (f, 'transform.in');
  reset (f);
  readln (f, viso);
  for cky := 1 to viso do
  begin
    for ckx := 1 to viso do
    begin
      read (f, c);
      if c = '@' then mas1 [ckx, cky] := true
                 else mas1 [ckx, cky] := false
    end;
    readln (f)
  end;
  for cky := 1 to viso do
  begin
    for ckx := 1 to viso do
    begin
      read (f, c);
      if c = '@' then mas2 [ckx, cky] := true
                 else mas2 [ckx, cky] := false
    end;
    readln (f)
  end;
  close (f)
end;

procedure rasyk (sk : Integer);
var
  f : Text;
begin
  assign (f, 'transform.out');
  rewrite (f);
  writeln (f, sk);
  close (f)
end;

function lygu (mas1, mas2 : Tmas) : boolean;
var
  ckx, cky : Integer;
begin
  for ckx := 1 to viso do
  for cky := 1 to viso do
  if mas1 [ckx, cky] <> mas2 [ckx, cky] then
  begin
    lygu := false;
    exit
  end;
  lygu := true
end;

procedure pasuk90 (var mas : Tmas);
var
  pgMAS : Tmas;
  ckx, cky : integer;
begin
  pgMAS := mas;
  for ckx := 1 to viso do
  for cky := 1 to viso do
  mas [viso + 1 - cky, ckx] := pgMAS [ckx, cky]
end;

procedure atspindys (var mas : Tmas);
var
  ckx, cky : Integer;
  pg : boolean;
begin
  for cky := 1 to viso do
  for ckx := 1 to viso div 2 do
  begin
    pg := mas [viso + 1 - ckx, cky];
    mas [viso + 1 - ckx, cky] := mas [ckx, cky];
    mas [ckx, cky] := pg
  end
end;

begin
  nuskaitymas (viso, mas1, mas2);
  pasuk90 (mas1);
  if lygu (mas1, mas2) then   { 90 }
  begin
    rasyk (1);
    exit
  end;
  pasuk90 (mas1);
  if lygu (mas1, mas2) then   { 180 }
  begin
    rasyk (2);
    exit
  end;
  pasuk90 (mas1);
  if lygu (mas1, mas2) then   { 270 }
  begin
    rasyk (3);
    exit
  end;
  pasuk90 (mas1);             { -0 }
  atspindys (mas1);
  if lygu (mas1, mas2) then
  begin
    rasyk (4);
    exit
  end;
  pasuk90 (mas1);             { -90 }
  if lygu (mas1, mas2) then
  begin
    rasyk (5);
    exit
  end;
  pasuk90 (mas1);             { -180 }
  if lygu (mas1, mas2) then
  begin
    rasyk (5);
    exit
  end;
  pasuk90 (mas1);             { -270 }
  if lygu (mas1, mas2) then
  begin
    rasyk (5);
    exit
  end;
  pasuk90 (mas1);
  atspindys (mas1);
  if lygu (mas1, mas2) then   { 0 }
  begin
    rasyk (6);
    exit
  end;
  rasyk (7)
end.
