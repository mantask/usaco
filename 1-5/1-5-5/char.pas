{
ID: vkanapo001
PROG: char
}

Program CHARR;

type
  Tseka = array [1 .. 1200, 1 .. 20] of byte;
  Tzod = array [1 .. 27, 1 .. 20, 1 .. 20] of byte;

var
  eil : string;
  zod : Tzod;
  seka : Tseka;
  viso, visoEIL : Integer;

procedure nuskaitymas;
var
  f : Text;
  c : char;
  ck, ck1, ck2 : Integer;
begin
  assign (f, 'char.in');
  reset (f);
  readln (f, visoEIL);
  for ck := 1 to visoEIL do
  begin
    for ck1 := 1 to 20 do
    begin
      read (f, c);
      if c = '1' then seka[ck][ck1] := 1
                 else seka[ck][ck1] := 0
    end;
    readln (f)
  end;
  close (f);

  assign (f, 'font.in');
  reset (f);
  viso := 27;
  readln (f);
  for ck := 1 to 27 do
  for ck1 := 1 to 20 do
  begin
    for ck2 := 1 to 20 do
    begin
      read (f, c);
      if c = '1' then zod [ck, ck1, ck2] := 1
                 else zod [ck, ck1, ck2] := 0
    end;
    readln (f)
  end;
  close (f)
end;

procedure rasymas;
var
  f : Text;
  ckx, cky : Integer;
begin
  assign (f, 'char.out');
  rewrite (f);
  writeln (f, eil);
  close (f)
end;

procedure lyginkNorm (nuo : integer; var raid, kiek : integer);
var
  ck, ckx, cky, pg : INteger;
begin
  dec (nuo);
  kiek := 10000;
  for ck := 1 to 27 do
  begin
    pg := 0;
    for ckx := 1 to 20 do
    for cky := 1 to 20 do
    if seka [nuo + cky, ckx] <> zod [ck, cky, ckx] then inc (pg);

    if kiek > pg then
    begin
      raid := ck;
      kiek := pg;
    end
    else if kiek = pg then
      raid := 0

  end;

end;

procedure lyginkDaug (nuo : Integer; var raid, kiek : integer);
var
  ckR, ckL, ckx, cky, pg : Integer;
begin
  dec (nuo);
  kiek := 10000;
  for ckR := 1 to 27 do
    for ckL := 1 to 20 do
    begin
      pg := 0;

      for cky := 1 to ckl - 1 do
        for ckx := 1 to 20 do
          if seka [cky + nuo, ckx] <> zod [ckR, cky, ckx] then
            inc (pg);

      for cky := ckl + 1 to 20 do
        for ckx := 1 to 20 do
          if seka [cky + nuo, ckx] <> zod [ckR, cky - 1, ckx] then
            inc (pg);

      if pg < kiek then
      begin
        raid := ckR;
        kiek := pg;
      end
      else if (pg = kiek) and (raid <> ckR) then
        raid := 0;
    end;

end;

procedure lyginkMazai (nuo : Integer; var raid, kiek : Integer);
var
  ckR, ckL, ckx, cky, pg : Integer;
begin
  dec (nuo);
  kiek := 10000;
  for ckR := 1 to 27 do
    for ckL := 1 to 20 do { taip ir nesupratau, kodel ne to 21 }
    begin                 { kodel ignoruojama paskutine eilute }
      pg := 0;

      for cky := 1 to ckL - 1 do
        for ckx := 1 to 20 do
          if seka[cky + nuo, ckx] <> zod[ckR, cky, ckx] then
            inc (pg);

      for cky := ckL + 1 to 20 do  { taip pat iki 21 siuliau }
        for ckx := 1 to 20 do
          if seka[cky + nuo - 1, ckx] <> zod[ckR, cky, ckx] then
            inc (pg);

      if pg < kiek then
      begin
        raid := ckR;
        kiek := pg;
      end
      else if (pg = kiek) and (raid <> ckR) then
        raid := 0;
    end;

end;

procedure add (raid : Integer);
begin
  if (raid = 1) then
    eil := ' ' + eil
  else if (raid = 0) then
    eil := '?' + eil
  else
    eil := char (ord ('a') + raid - 2)  + eil
end;

procedure rask;
var
  r19, r20, r21 : array [1 .. 1201] of integer;
  ats : array [1 .. 1201] of longint;
  ish : array [1 .. 1201] of integer;
  ck, kiek : Integer;

begin
  for ck := 1 to visoEIL + 1 do
  begin
    ish[ck] := -1;
    ats[ck] := 1000000;
    r19[ck] := 1;
    r20[ck] := 1;
    r21[ck] := 1;
  end;
  ats[1] := 0;
  ish[1] := -2;


  for ck := 1 to visoEil do
  begin
    if (ish[ck] = -1) then
      continue;

    if ck + 18 > visoEil then
      continue;

    lyginkMazai (ck, r19[ck], kiek);
    if ats[ck] + kiek < ats[ck + 19] then
    begin
      ats[ck + 19] := ats[ck] + kiek;
      ish[ck + 19] := 19;
    end;

    if ck + 19 > visoEil then continue;

    lyginkNorm (ck, r20[ck], kiek);
    if ats[ck] + kiek < ats[ck + 20] then
    begin
      ats[ck + 20] := ats[ck] + kiek;
      ish[ck + 20] := 20;
    end;

    if ck + 20 > visoEil then continue;

    lyginkDaug (ck, r21[ck], kiek);
    if ats[ck] + kiek < ats[ck + 21] then
    begin
      ats[ck + 21] := ats[ck] + kiek;
      ish[ck + 21] := 21;
    end;
  end;


  ck := visoEIL + 1;
  while ck <> 1 do
  begin
    case ish[ck] of
      19 : add (r19[ck - ish[ck]]);
      20 : add (r20[ck - ish[ck]]);
      21 : add (r21[ck - ish[ck]]);
    end;
    ck := ck - ish[ck];
  end;

end;

begin
  nuskaitymas;
  rask;
  rasymas
end.
