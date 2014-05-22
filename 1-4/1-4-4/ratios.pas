{
ID: vkanapo001
PROG: ratios
}

Program RATIOS;

type
  Ts = array [0 .. 3, 1 .. 3] of integer;

var
  s : Ts;
  s1, s2, s3, s0 : integer;

procedure nuskaitymas (var s : Ts);
var
  f : text;
  ck : Integer;
begin
  assign (f, 'ratios.in');
  reset (f);
  for ck := 0 to 3 do
  readln (f, s [ck, 1], s [ck, 2], s [ck, 3]);
  close (f)
end;

procedure rask (var s : TS; var s0, s1, s2, s3 : Integer);
var
  pg1, pg2, pg3, pg,
  ck1, ck2, ck3 : Integer;
begin
  s0 := -1;
  s1 := 1000;
  s2 := 1000;
  s3 := 1000;

  if (s [0, 1] = 0) and (s [0, 2] = 0) and (s [0, 3] = 0) then
  begin
    s0 := 0;
    s1 := 0;
    s2 := 0;
    s3 := 0;
    exit
  end;

  for ck1 := 0 to 99 do
  for ck2 := 0 to 99 do
  for ck3 := 0 to 99 do
  begin
    pg := 0;

    pg1 := s [1, 1] * ck1 + s [2, 1] * ck2 + s [3, 1] * ck3;
    if pg1 < s [0, 1] then continue
    else
    if s [0, 1] = 0 then
    begin
      if pg1 <> 0 then continue
    end
    else
    if pg1 mod s [0, 1] = 0 then pg := pg1 div s [0, 1]
                            else continue;

    pg2 := s [1, 2] * ck1 + s [2, 2] * ck2 + s [3, 2] * ck3;
    if pg2 < s [0, 2] then continue
    else
    if s [0, 2] = 0 then
    begin
      if pg2 <> 0 then continue
    end
    else
    if pg = 0 then
    begin
      if pg2 mod s [0, 1] = 0 then pg := pg2 div s [0, 1]
                              else continue;
    end
    else
    if not ((pg2 mod s [0, 2] = 0) and (pg2 div s [0, 2] = pg)) then continue;

    pg3 := s [1, 3] * ck1 + s [2, 3] * ck2 + s [3, 3] * ck3;
    if pg3 < s [0, 3] then continue
    else
    if s [0, 3] = 0 then
    begin
      if pg3 <> 0 then continue
    end
    else
    if pg = 0 then
    begin
      if pg2 mod s [0, 3] = 0 then pg := pg3 div s [0, 3]
                              else continue
    end
    else
    if not ((pg3 mod s [0, 3] = 0) and (pg3 div s [0, 3] = pg)) then continue;

    if (s1 + s2 + s3 > ck1 + ck2 + ck3) then
    begin
      s1 := ck1;
      s2 := ck2;
      s3 := ck3;
      s0 := pg
    end
  end
end;

procedure rasymas (s0, s1, s2, s3 : Integer);
var
  f : text;
begin
  assign (F, 'ratios.out');
  rewrite (f);
  if s0 = -1 then writeln (F, 'NONE')
             else writeln (f, s1, ' ', s2, ' ', s3, ' ', s0);
  close (f)
end;

begin
  nuskaitymas (s);
  rask (s, s1, s2, s3, s0);
  rasymas (s1, s2, s3, s0)
end.
