{
ID: vkanapo001
PROG: poly1
}

program POLY1;

type
  Tlent = array [0 .. 1000, 0 .. 1000] of integer;

var
  lent1, lent2, lent : Tlent;

procedure tvark (eil : string; var lent : Tlent);
var
  pgeil : string;
  x, y, kof, ilg, nuo,
  ck : Integer;
  teig : boolean;
begin
  ilg := length (eil);
  nuo := 1;
  for ck := 2 to ilg + 1 do
  if (eil [ck] = '-') or (eil [ck] = '+') or (ck = ilg + 1) then
  begin
    pgeil := copy (eil, nuo, ck - nuo);

    if pgeil [1] = '-' then teig := false
                       else teig := true;
    if (pgeil [1] = '-') or (pgeil [1] = '+') then delete (pgeil, 1, 1);

    kof := 0;
    x := 0;
    y := 0;

    if pgeil [1] in ['0' .. '9'] then
    while (length (pgeil) > 0) and (pgeil [1] in ['0' .. '9']) do
    begin
      kof := kof * 10 + ord (pgeil [1]) - 48;
      delete (pgeil, 1, 1)
    end
    else kof := 1;

    if (length (pgeil) > 0) and (pgeil [1] = 'x') then
    begin
      delete (pgeil, 1, 1);
      if (length (pgeil) > 0) and (pgeil [1] in ['0' .. '9']) then
      while (length (pgeil) > 0) and (pgeil [1] in ['0' .. '9']) do
      begin
        x := x * 10 + ord (pgeil [1]) - 48;
        delete (pgeil, 1, 1)
      end
      else x := 1
    end;

    if (length (pgeil) > 0) and (pgeil [1] = 'y') then
    begin
      delete (pgeil, 1, 1);
      if (length (pgeil) > 0) and (pgeil [1] in ['0' .. '9']) then
      while (length (pgeil) > 0) and (pgeil [1] in ['0' .. '9']) do
      begin
        y := y * 10 + ord (pgeil [1]) - 48;
        delete (pgeil, 1, 1)
      end
      else y := 1
    end;

    if (length (pgeil) > 0) and (pgeil [1] = 'x') then
    begin
      delete (pgeil, 1, 1);
      if (length (pgeil) > 0) and (pgeil [1] in ['0' .. '9']) then
      while (length (pgeil) > 0) and (pgeil [1] in ['0' .. '9']) do
      begin
        x := x * 10 + ord (pgeil [1]) - 48;
        delete (pgeil, 1, 1)
      end
      else x := 1
    end;

    if teig then lent [x, y] := lent [x, y] + kof
            else lent [x, y] := lent [x, y] - kof;
    nuo := ck
  end
end;

procedure nuskaitymas (var lent1, lent2 : Tlent);
var
  f : text;
  eil : string;
begin
  assign (f, 'poly1.in');
  reset (f);
  readln (f, eil);
  tvark (eil, lent1);
  readln (f, eil);
  tvark (eil, lent2);
  close (f)
end;

procedure sujunk (var lent1, lent2, lent : Tlent);
var
  x, y,
  ckx1, cky1,
  ckx2, cky2 : integer;
begin
  for ckx1 := 0 to 1000 do
  for cky1 := 0 to 1000 do
  if lent1 [ckx1, cky1] <> 0 then
  begin
    for ckx2 := 0 to 1000 do
    for cky2 := 0 to 1000 do
    if lent2 [ckx2, cky2] <> 0 then
    begin
      x := ckx1 + ckx2;
      y := cky1 + cky2;
      lent [x, y] := lent [x, y] + lent1 [ckx1, cky1] * lent2 [ckx2, cky2]
    end
  end
end;

procedure rasyk (var lent : tlent);
var
  f : text;
  eil1, eil2 : array [1 .. 200] of char;
  pg, il, kof, uod, ck, ckx, cky : integer;
begin
  for ck := 1 to 200 do
  begin
    eil1 [ck] := '.';
    eil2 [ck] := '.'
  end;
  uod := 1;

  for ckx := 1000 downto 0 do
  for cky := 0 to 1000 do
  if lent [ckx, cky] <> 0 then
  begin
    if lent [ckx, cky] < 0 then
    begin
      if uod = 1 then
      begin
        eil2 [uod] := '-';
        inc (uod)
      end
      else
      begin
        eil2 [uod] := '-';
        eil2 [uod + 1] := ' ';
        inc (uod, 2)
      end
    end
    else
    if uod > 1 then
    begin
      eil2 [uod] := '+';
      eil2 [uod + 1] := ' ';
      inc (uod, 2)
    end;

    kof := abs (lent [ckx, cky]);
    if (kof = 1) and (ckx = 0) and (cky = 0) then
    begin
      eil2 [uod] := '1';
      inc (uod)
    end
    else
    if kof > 1 then
    begin
      if kof div 10000000 >= 1 then il := 8 else
      if kof div 1000000 >= 1 then il := 7 else
      if kof div 100000 >= 1 then il := 6 else
      if kof div 10000 >= 1 then il := 5 else
      if kof div 1000 >= 1 then il := 4 else
      if kof div 100 >= 1 then il := 3 else
      if kof div 10 >= 1 then il := 2
                         else il := 1;
      inc (uod, il);
      pg := il + 1;
      while kof > 0 do
      begin
        eil2 [uod + il - pg] := chr (kof mod 10 + 48);
        kof := kof div 10;
        dec (il)
      end;
    end;

    if ckx > 0 then
    begin
      eil2 [uod] := 'x';
      inc (uod);
      kof := ckx;
      if kof > 1 then
      begin
        if kof div 100 >= 1 then il := 3
        else if kof div 10 >= 1 then il := 2
                                else il := 1;
        inc (uod, il);
        pg := il + 1;
        while kof > 0 do
        begin
          eil1 [uod + il - pg] := chr (kof mod 10 + 48);
          kof := kof div 10;
          dec (il)
        end
      end
    end;

    if cky > 0 then
    begin
      eil2 [uod] := 'y';
      inc (uod);
      kof := cky;
      if kof > 1 then
      begin
        if kof div 100 >= 1 then il := 3
        else if kof div 10 >= 1 then il := 2
                                else il := 1;
        inc (uod, il);
        pg := il + 1;
        while kof > 0 do
        begin
          eil1 [uod + il - pg] := chr (kof mod 10 + 48);
          kof := kof div 10;
          dec (il)
        end
      end
    end;

    eil2 [uod] := ' ';
    inc (uod)
  end;

  assign (f, 'poly1.out');
  rewrite (f);
  ckx := uod - 2;
  cky := uod - 2;
  while eil1 [ckx] = '.' do dec (ckx);
  for ck := 1 to ckx do
  if eil1 [ck] = '.' then write (f, ' ')
                     else write (f, eil1 [ck]);
  writeln (f);
  while eil2 [cky] = '.' do dec (cky);
  for ck := 1 to cky do
  if eil2       [ck] = '.' then write (f, ' ')
                     else write (f, eil2 [ck]);
  writeln (f);
  close (f)
end;

begin
  fillchar (lent1, sizeof (lent1), 0);
  fillchar (lent2, sizeof (lent2), 0);
  fillchar (lent, sizeof (lent), 0);
  nuskaitymas (lent1, lent2);
  sujunk (lent1, lent2, lent);
  rasyk (lent)
end.
