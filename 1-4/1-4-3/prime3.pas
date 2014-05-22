{
ID: vkanapo001
PROG: prime3
}

Program PRIME3;

type
  Tpirm = record
    m : array [1 .. 2760, 1 .. 5] of 0 .. 9;
    kiek : integer
  end;
  Tmas = array [1 .. 5, 1 .. 5] of integer;
  Tsk = -1 .. 9;
  Tats = array [1 .. 200] of Tmas;

var
  pirm : Tpirm;
  viso, suma, pirmas : Integer;
  Ats : Tats;

procedure nuskaitymas (var suma, pirmas : Integer);
var
  f : Text;
begin
  assign (f, 'prime3.in');
  reset (f);
  readln (f, suma, pirmas);
  close (f)
end;

procedure pirminiai (var pirm : Tpirm);
var
  visoDAL, ck, ck1, pg : longint;
  sk, s : integer;
  ok : boolean;
  dal : array [1 .. 65] of integer;
begin
  dal [1] := 2;
  visoDAL := 1;
  for ck := 3 to 313 do
  begin
    ok := true;
    for ck1 := 1 to visoDAL do
    if ck mod dal [ck1] = 0 then
    begin
      ok := false;
      break
    end;
    if ok then
    for ck1 := dal [visoDAL] + 1 to trunc (sqrt (ck)) do
    if ck mod ck1 = 0 then
    begin
      ok := false;
      break
    end;
    if ok then
    begin
      inc (visoDAL);
      dal [visoDAL] := ck
    end
  end;
  fillchar (pirm, sizeof (pirm), 0);
  pirm.kiek := 1;
  for ck := 10000 to 99999 do
  begin
    ok := true;
    for ck1 := 1 to visoDAL do
    if ck mod dal [ck1] = 0 then
    begin
      ok := false;
      break
    end;
    if ok then
    begin
      S := 0;
      pg := ck;
      sk := 5;
      while pg > 0 do
      begin
        pirm.m [pirm.kiek, sk] := pg mod 10;
        inc (s, pirm.m [pirm.kiek, sk]);
        dec (sk);
        pg := pg div 10
      end;
      if S = suma then inc (pirm.kiek)
    end
  end;
  dec (pirm.kiek)
end;

function Tinka (v : integer; s1, s2, s3, s4, s5 : Tsk) : boolean;
begin
  if ((pirm.m [v, 1] = s1) and (s2 = -1)) or
     ((pirm.m [v, 1] = s1) and (pirm.m [v, 2] = s2) and (s3 = -1)) or
     ((pirm.m [v, 1] = s1) and (pirm.m [v, 2] = s2) and (pirm.m [v, 3] = s3) and (s4 = -1)) or
     ((pirm.m [v, 1] = s1) and (pirm.m [v, 2] = s2) and (pirm.m [v, 3] = s3) and (pirm.m [v, 4] = s4) and (s5 = -1)) or
     ((pirm.m [v, 1] = s1) and (pirm.m [v, 2] = s2) and (pirm.m [v, 3] = s3) and (pirm.m [v, 4] = s4) and (pirm.m [v, 5] = s5))
     then tinka := true
     else tinka := false
end;

function ciki (v : integer; s1, s2, s3, s4, s5 : Tsk) : boolean;
begin
  if (pirm. m [v, 1] = s1) and ((s2 = -1) or (pirm.m [v, 2] = s2)) and
     ((s3 = -1) or (pirm.m [v, 3] = s3)) and ((s4 = -1) or (pirm.m [v, 4] = s4))
     and ((s5 = -1) or (pirm.m [v, 5] = s5))
  then ciki := true
  else ciki := false
end;

function poz (s1, s2, s3, s4, s5 : Tsk) : integer;
var
  v, v1, v2 : Integer;
begin
  v1 := 1;
  v2 := pirm.kiek;
  while v1 + 1 < v2 do
  begin
    v := (v1 + v2) div 2;
    if s1 < pirm.m [v, 1] then v2 := v
    else
    if s1 > pirm.m [v, 1] then v1 := v
    else
    if s2 = -1 then break
    else
    if s2 < pirm.m [v, 2] then v2 := v
    else
    if s2 > pirm.m [v, 2] then v1 := v
    else
    if s3 = -1 then break
    else
    if s3 < pirm.m [v, 3] then v2 := v
    else
    if s3 > pirm.m [v, 3] then v1 := v
    else
    if s4 = -1 then break
    else
    if s4 < pirm.m [v, 4] then v2 := v
    else
    if s4 > pirm.m [v, 4] then v1 := v
    else
    if s5 = -1 then break
    else
    if s5 < pirm.m [v, 5] then v2 := v
    else
    if s5 > pirm.m [v, 5] then v1 := v
    else break
  end;
  if v1 + 1 = v2 then
  begin
    if tinka (v1, s1, s2, s3, s4, s5) then poz := v1
    else
    if tinka (v2, s1, s2, s3, s4, s5) then poz := v2
                                      else poz := -1
  end
  else
  if tinka (v, s1, s2, s3, s4, s5) then poz := v
                                   else poz := -1
end;

procedure pildyk (nr, ind : integer; var mas : Tmas);
begin
  case nr of
    1 : begin
          mas [2, 1] := pirm.m [ind, 2];
          mas [3, 1] := pirm.m [ind, 3];
          mas [4, 1] := pirm.m [ind, 4];
          mas [5, 1] := pirm.m [ind, 5]
        end;
    2 : begin
          mas [1, 2] := pirm.m [ind, 2];
          mas [1, 3] := pirm.m [ind, 3];
          mas [1, 4] := pirm.m [ind, 4];
          mas [1, 5] := pirm.m [ind, 5]
        end;
    3 : begin
          mas [2, 4] := pirm.m [ind, 2];
          mas [3, 3] := pirm.m [ind, 3];
          mas [4, 2] := pirm.m [ind, 4]
        end;
    4 : begin
          mas [2, 2] := pirm.m [ind, 2];
          mas [3, 2] := pirm.m [ind, 3];
          mas [5, 2] := pirm.m [ind, 5]
        end;
    5 : begin
          mas [2, 3] := pirm.m [ind, 3];
          mas [2, 5] := pirm.m [ind, 5]
        end;
    6 : begin
          mas [4, 3] := pirm.m [ind, 4];
          mas [5, 3] := pirm.m [ind, 5]
        end;
    7 : begin
          mas [3, 4] := pirm.m [ind, 4];
          mas [3, 5] := pirm.m [ind, 5]
        end;
    8 : begin
          mas [4, 4] := pirm.m [ind, 4];
          mas [5, 4] := pirm.m [ind, 5]
        end;
    9 : mas [4, 5] := pirm.m [ind, 5];
    10 : mas [5, 5] := pirm.m [ind, 5]
  end
end;

function nuliai (ind : integer) : boolean;
var
  ck : Integer;
begin
  for ck := 2 to 4 do
  if pirm.m [ind, ck] = 0 then
  begin
    nuliai := true;
    exit
  end;
  nuliai := false
end;

procedure rask (nr : Integer; var viso : Integer; var mas : Tmas; var ats : Tats);
var
  ck1, ck : Integer;
  s1, s2, s3, s4, s5 : Tsk;
begin
  case nr of
    1, 2 : begin s1 := mas [1, 1]; s2 := -1; s3 := -1; s4 := -1; s5 := -1 end;
    3 : begin s1 := mas [1, 5]; s2 := -1; s3 := -1; s4 := -1; s5 := mas [5, 1] end;
    4 : begin s1 := mas [1, 2]; s2 := -1; s3 := -1; s4 := mas [4, 2]; s5 := -1 end;
    5 : begin s1 := mas [2, 1]; s2 := mas [2, 2]; s3 := -1; s4 := mas [2, 4]; s5 := -1 end;
    6 : begin s1 := mas [1, 3]; s2 := mas [2, 3]; s3 := mas [3, 3]; s4 := -1; s5 := -1 end;
    7 : begin s1 := mas [3, 1]; s2 := mas [3, 2]; s3 := mas [3, 3]; s4 := -1; s5 := -1 end;
    8 : begin s1 := mas [1, 4]; s2 := mas [2, 4]; s3 := mas [3, 4]; s4 := -1; s5 := -1 end;
    9 : begin s1 := mas [4, 1]; s2 := mas [4, 2]; s3 := mas [4, 3]; s4 := mas [4, 4]; s5 := -1 end;
    10 : begin s1 := mas [1, 5]; s2 := mas [2, 5]; s3 := mas [3, 5]; s4 := mas [4, 5]; s5 := -1 end;
    11 : begin s1 := mas [5, 1]; s2 := mas [5, 2]; s3 := mas [5, 3]; s4 := mas [5, 4]; s5 := mas [5, 5] end;
    12 : begin s1 := mas [1, 1]; s2 := mas [2, 2]; s3 := mas [3, 3]; s4 := mas [4, 4]; s5 := mas [5, 5] end
  end;

  if nr = 12 then
  begin
    if poz (s1, s2, s3, s4, s5) <> -1 then
    begin
      inc (viso);
      ats [viso] := mas
    end;
    exit
  end;

  ck := poz (s1, s2, s3, s4, s5);
  if ck = -1 then exit;

  if ciki (ck, s1, s2, s3, s4, s5) and
     ((((nr = 1) or (nr = 2)) and not nuliai (ck)) or (nr > 2)) then
  begin
    pildyk (nr, ck, mas);
    rask (nr + 1, viso, mas, ats)
  end;

  if nr <= 10 then
  begin
    ck1 := ck;
    while (ck1 > 1) and tinka (ck1 - 1, s1, s2, s3, s4, s5) do
    begin
      dec (ck1);
      if ciki (ck1, s1, s2, s3, s4, s5) and
         ((((nr = 1) or (nr = 2)) and not nuliai (ck1)) or (nr > 2)) then
      begin
        pildyk (nr, ck1, mas);
        rask (nr + 1, viso, mas, ats)
      end
    end;

    ck1 := ck;
    while (ck1 < pirm.kiek) and tinka (ck1 + 1, s1, s2, s3, s4, s5) do
    begin
      inc (ck1);
      if ciki (ck1, s1, s2, s3, s4, s5) and
         ((((nr = 1) or (nr = 2)) and not nuliai (ck1)) or (nr > 2)) then
      begin
        pildyk (nr, ck1, mas);
        rask (nr + 1, viso, mas, ats)
      end
    end
  end
end;

function maz (var mas1, mas2 : Tmas) : boolean;
var
  jau : boolean;
  ckx, cky : Integer;
begin
  jau := false;
  ckx := 1;
  cky := 1;
  while not jau do
  if mas1 [ckx, cky] <> mas2 [ckx, cky] then jau := true
  else
  if ckx = 5 then
  begin
    if cky = 5 then jau := true
               else inc (cky);
    ckx := 1
  end
  else inc (ckx);
  maz := mas1 [ckx, cky] < mas2 [ckx, cky]
end;

function daug (var mas1, mas2 : Tmas) : boolean;
var
  jau : boolean;
  ckx, cky : Integer;
begin
  jau := false;
  ckx := 1;
  cky := 1;
  while not jau do
  if mas1 [ckx, cky] <> mas2 [ckx, cky] then jau := true
  else
  if ckx = 5 then
  begin
    if cky = 5 then jau := true
               else inc (cky);
    ckx := 1
  end
  else inc (ckx);
  daug := mas1 [ckx, cky] > mas2 [ckx, cky]
end;

procedure rikiuok (r1, r2 : Integer; var ats : Tats);
var
  v, pg : Tmas;
  v1, v2 : integer;
begin
  v1 := r1;
  v2 := r2;
  v := ats [(v1 + v2) div 2];
  repeat
    while maz (ats [v1], v) do inc (v1);
    while daug (ats [v2], v) do dec (v2);
    if v1 <= v2 then
    begin
      pg := ats [v1];
      ats [v1] := ats [v2];
      ats [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if r1 < v2 then rikiuok (r1, v2, ats);
  if v1 < r2 then rikiuok (v1, r2, ats)
end;

procedure varyk (var viso : Integer; var ats : Tats);
var
  mas : Tmas;
begin
  viso := 0;
  if suma mod 2 = 1 then
  begin
    pirminiai (pirm);
    mas [1, 1] := pirmas;
    rask (1, viso, mas, ats);
    if viso > 0 then rikiuok (1, viso, ats)
  end
end;

Procedure rasymas (var viso : integer; var ats : Tats);
var
  f : Text;
  ck, ckx, cky : Integer;
begin
  assign (f, 'prime3.out');
  rewrite (f);
  if viso = 0 then writeln (f, 'NONE')
  else
  for ck := 1 to viso do
  begin
    if ck > 1 then writeln (f);
    for cky := 1 to 5 do
    begin
      for ckx := 1 to 5 do
      write (f, ats [ck, ckx, cky]);
      writeln (f)
    end
  end;
  close (f)
end;

begin
  nuskaitymas (suma, pirmas);
  varyk (viso, ats);
  rasymas (viso, ats)
end.
