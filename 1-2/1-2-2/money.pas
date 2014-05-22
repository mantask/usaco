{
ID: vkanapo001
PROG: money
}

Program MONEY;

const
  CC = 50;

type
  Tmon = array [1 .. 25] of integer;
  Telem = array [1 .. CC] of 0 .. 10;
  Tsk = array [0 .. 10000, 1 .. 25] of Telem;

var
  mon : Tmon;
  ats : Tsk;
  viso, suma : Integer;

procedure nuskaitymas (var suma, viso : integer; var mon : Tmon);
var
  f : text;
  ck, pg, ck1, poz : Integer;
  ok : boolean;
begin
  assign (f, 'money.in');
  reset (f);
  readln (f, viso, suma);
  poz := 0;
  for ck := 1 to viso do
  begin
    read (f, pg);
    ok := true;
    for ck1 := 1 to ck - 1 do
    if mon [ck1] = pg then
    begin
      ok := false;
      dec (viso);
      break
    end;
    if ok then
    begin
      inc (poz);
      mon [poz] := pg
    end
  end;
  readln (f);
  close (f)
end;

procedure rikiuok (s1, s2 : integer; var mon : Tmon);
var
  pg, v, v1, v2 : integer;
begin
  v1 := s1;
  v2 := s2;
  v := mon [(v1 + v2) div 2];
  repeat
    while mon [v1] < v do inc (v1);
    while mon [v2] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := mon [v1];
      mon [v1] := mon [v2];
      mon [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if s1 < v2 then rikiuok (s1, v2, mon);
  if v1 < s2 then rikiuok (v1, s2, mon)
end;

procedure tvark (sk, iki : Integer; var ats : Tsk);
var
  sk1, iki1,
  liek, pg, ck : Integer;
begin
  iki1 := iki - 1;
  sk1 := sk - mon [iki];

  liek := 0;
  ck := 1;
  if sk1 < 0 then
  while (ats [sk, iki1, ck] <> 10) or (liek > 0) do
  begin
    pg := ats [sk, iki1, ck] + liek;
    if ats [sk, iki1, ck] = 10 then dec (pg, 10);
    ats [sk, iki, ck] := pg mod 10;
    liek := pg div 10;
    inc (ck)
  end
  else
  while (ats [sk, iki1, ck] <> 10) or (ats [sk1, iki, ck] <> 10) or (liek > 0) do
  begin
    pg := ats [sk, iki1, ck] + ats [sk1, iki, ck] + liek;
    if ats [sk, iki1, ck] = 10 then dec (pg, 10);
    if ats [sk1, iki, ck] = 10 then dec (pg, 10);
    ats [sk, iki, ck] := pg mod 10;
    liek := pg div 10;
    inc (ck)
  end
end;

procedure skaic (var ats : Tsk);
var
  cksk, ckiki : integer;
begin
  fillchar (ats, sizeof (ats), 10);
  for cksk := 1 to suma do
  if cksk mod mon [1] = 0 then ats [cksk, 1, 1] := 1;
  for ckiki := 1 to viso do
  ats [0, ckiki, 1] := 1;

  for ckiki := 2 to viso do
  for cksk := 1 to suma do
  tvark (cksk, ckiki, ats)
end;

procedure rasyk (var ats : Tsk);
var
  f : Text;
  pg, ck : integer;
begin
  pg := CC;
  while (pg > 0) and (ats [suma, viso, pg] = 10) do dec (pg);
  assign (f, 'money.out');
  rewrite (F);
  if ats [suma, viso, 1] = 10 then write (f, 0)
  else
  for ck := pg downto 1 do
  write (f, ats [suma, viso, ck]);
  writeln (f);
  close (F)
end;

begin
  nuskaitymas (suma, viso, mon);
  rikiuok (1, viso, mon);
  skaic (ats);
  rasyk (ats)
end.
