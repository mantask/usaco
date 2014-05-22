{
ID: vkanapo001
PROG: rect1
}

program RECT1;

Type
  Psar = ^Tsar;
  Tsar = record
    x1, y1, x2, y2 : integer;
    toliau : Psar
  end;
  Tmas = array [1 .. 2500] of Psar;

var
  mas : Tmas;
  spmax, sp, viso, ck, ck1,
  x1, y1, x2, y2 : integer;
  pl : longint;
  f : text;
  buvo : array [1 .. 2500] of boolean;

function min (sk1, sk2 : integer) : integer;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

function max (sk1, sk2 : integer) : integer;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

procedure prijunk (sp, x1, y1, x2, y2 : integer; var mas : Tmas);
var
  pries, sar : Psar;
  pirmas : boolean;
begin
  if mas [sp] = nil then
  begin
    new (sar);
    mas [sp] := sar;
    sar^.x1 := x1;
    sar^.x2 := x2;
    sar^.y1 := y1;
    sar^.y2 := y2;
    sar^.toliau := nil;
    sar := sar^.toliau;
    dispose (sar);
    exit
  end;

  pirmas := true;
  sar := mas [sp];
  pries := mas [sp];
  while sar <> nil do
  begin
    if (x2 <= sar^.x1) or (x1 >= sar^.x2) or (y2 <= sar^.y1) or (y1 >= sar^.y2)
    then
    begin
      pries := sar;
      sar := sar^.toliau;
      if pirmas then pirmas := false;
      continue           { jei salia, tai ieskom toliau }
    end;

   { jei kertasi tai teks ismesti is grandines }
    if pirmas then mas [sp] := sar^.toliau
              else pries^.toliau := sar^.toliau;

    if y1 > sar^.y1       { jei kertasi, tai skaidysim }
    then prijunk (sp, sar^.x1, sar^.y1, sar^.x2, y1, mas);
    if y2 < sar^.y2
    then prijunk (sp, sar^.x1, y2, sar^.x2, sar^.y2, mas);
    if x1 > sar^.x1
    then prijunk (sp, sar^.x1, max (y1, sar^.y1), x1, min (sar^.y2, y2), mas);
    if x2 < sar^.x2
    then prijunk (sp, x2, max (sar^.y1, y1), sar^.x2, min (y2, sar^.y2), mas);

    pries := sar;                     { vietoj }
    sar := sar^.toliau;               { sar := sar.toliau ir dispose sar }
    if pirmas then pirmas := false
  end;
  sar := mas [sp];
  pries := mas [sp];
  while sar <> nil do
  begin
    pries := sar;
    sar := sar^.toliau
  end;
  if (x1 < x2) and (y1 < y2) then
  begin
    new (sar);
    sar^.x1 := x1;
    sar^.y1 := y1;
    sar^.x2 := x2;       {susidaro situacija kai mas[sp]=nil}
    sar^.y2 := y2;
    if mas [sp] = nil then mas [sp] := sar
    else
    begin
     pries^.toliau := sar;
     pries := pries^.toliau;
     pries := pries^.toliau
    end;
    sar := sar^.toliau   { pridejau pg ir padariau kad nutrauktu cikla kai sar.toliau nil }
  end;
  dispose (sar)
end;

procedure apkirpk (sp, x1, y1, x2, y2 : integer; var mas : Tmas);
var
  pries, sar : Psar;
  pirmas : boolean;
begin
  sar := mas [sp];
  pries := mas [sp];
  pirmas := true;
  while sar <> nil do
  begin
    if (x2 <= sar^.x1) or (x1 >= sar^.x2) or (y2 <= sar^.y1) or (y1 >= sar^.y2)
    then   { if only near }
    begin
      pries := sar;
      sar := sar^.toliau;
      if pirmas then pirmas := false;
      continue
    end;

    if pirmas then mas [sp] := sar^.toliau
              else pries^.toliau := sar^.toliau;

    if y1 > sar^.y1
    then prijunk (sp, sar^.x1, sar^.y1, sar^.x2, y1, mas);
    if y2 < sar^.y2
    then prijunk (sp, sar^.x1, y2, sar^.x2, sar^.y2, mas);
    if x1 > sar^.x1
    then prijunk (sp, sar^.x1, max (y1, sar^.y1), x1, min (sar^.y2, y2), mas);
    if x2 < sar^.x2
    then prijunk (sp, x2, max (sar^.y1, y1), sar^.x2, min (y2, sar^.y2), mas);

    sar := sar^.toliau
  end;
  dispose (sar)
end;

function S (sp : integer; var mas : Tmas) : longint;
var
  sar : Psar;
  pl : longint;
begin
  sar := mas [sp];
  pl := 0;
  while sar <> nil do
  begin
    pl := pl + (sar^.x2 - sar^.x1) * (sar^.y2 - sar^.y1);
    sar := sar^.toliau
  end;
  s := pl;
  dispose (sar)
end;

begin
  for ck := 1 to 2500 do
  begin
    new (mas [ck]);
    mas [ck] := nil
  end;
  fillchar (buvo, sizeof (buvo), 0);

  assign (f, 'rect1.in');
  reset (f);
  readln (f, x2, y2, viso);
  prijunk (1, 0, 0, x2, y2, mas);
  buvo [1] := true;
  spmax := 1;
  for ck := 1 to viso do
  begin
    readln (f, x1, y1, x2, y2, sp);
    buvo [sp] := true;

    for ck1 := 1 to spmax do
    if buvo [ck1] and (ck1 <> sp) then apkirpk (ck1, x1, y1, x2, y2, mas);
    if sp > spmax then spmax := sp;

    prijunk (sp, x1, y1, x2, y2, mas)
  end;

  close (f);

  assign (f, 'rect1.out');
  rewrite (f);
  for ck := 1 to spmax do
  begin
    pl := s (ck, mas);
    if pl <> 0 then writeln (f, ck, ' ', pl)
  end;
  close (f);

  for ck := 1 to 2500 do
  dispose (mas [ck])
end.
