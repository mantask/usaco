{
ID: vkanapo001
PROG: clocks
}

Program CLOCKS;

const
  Cpas : array [1 .. 9, 1 .. 9] of 0 .. 1 =
    ((1, 1, 0, 1, 1, 0, 0, 0, 0),
     (1, 1, 1, 0, 0, 0, 0, 0, 0),
     (0, 1, 1, 0, 1, 1, 0, 0, 0),
     (1, 0, 0, 1, 0, 0, 1, 0, 0),
     (0, 1, 0, 1, 1, 1, 0, 1, 0),
     (0, 0, 1, 0, 0, 1, 0, 0, 1),
     (0, 0, 0, 1, 1, 0, 1, 1, 0),
     (0, 0, 0, 0, 0, 0, 1, 1, 1),
     (0, 0, 0, 0, 1, 1, 0, 1, 1));

type
  Tmas = array [1 .. 9] of 0 .. 3;
  Teil = array [1 .. 40] of 1 .. 9;

var
  mas : Tmas;
  il, ilg : integer;
  eil, ats : Teil;

procedure nuskaitymas (var mas : Tmas);
var
  f : text;
  s1, s2, s3 : integer;
begin
  assign (f, 'clocks.in');
  reset (f);
  readln (f, s1, s2, s3);
  mas [1] := s1 div 3 - 1;
  mas [2] := s2 div 3 - 1;
  mas [3] := s3 div 3 - 1;
  readln (f, s1, s2, s3);
  mas [4] := s1 div 3 - 1;
  mas [5] := s2 div 3 - 1;
  mas [6] := s3 div 3 - 1;
  readln (f, s1, s2, s3);
  mas [7] := s1 div 3 - 1;
  mas [8] := s2 div 3 - 1;
  mas [9] := s3 div 3 - 1;
  close (f)
end;

procedure pakeisk (Nr : Integer; var mas : Tmas);
var
  ck : integer;
begin
  for ck := 1 to 9 do
  mas [ck] := (mas [ck] + Cpas [nr, ck]) mod 4;
end;

procedure atkeisk (Nr : integer; var mas : Tmas);
var
  ck : Integer;
begin
  for ck := 1 to 9 do
  if Cpas [nr, ck] = 1 then mas [ck] := (mas [ck] + 3) mod 4
end;

function jau (var mas : Tmas) : boolean;
var
  ok : boolean;
  ck : integer;
begin
  ok := true;
  for ck := 1 to 9 do
  if mas [ck] <> 3 then
  begin
    ok := false;
    break
  end;
  jau := ok
end;

function maz (ilg : integer; var eil, ats : Teil) : boolean;
var
  ok : boolean;
  ck : Integer;
begin
  ok := true;
  for ck := 1 to ilg do
  if eil [ck] > ats [ck] then
  begin
    ok := false;
    break
  end;
  maz := ok
end;

procedure varyk (gyl : Integer; var mas : Tmas; var eil, Ats: teil; var il, ilg : Integer);
var
  ck, ck1 : Integer;
begin
  if jau (mas) and ((ilg = 0) or (il < ilg) or ((ilg = il) and maz (il, eil, ats))) then
  begin
    ilg := il;
    ats := eil;
    exit
  end;

  if gyl = 10 then exit;

  for ck := 0 to 3 do
  begin
    for ck1 := 1 to ck do
    begin
      pakeisk (gyl, mas);
      inc (il);
      eil [il] := gyl
    end;
    if gyl <= 9 then varyk (gyl + 1, mas, eil, ats, il, ilg);
    for ck1 := 1 to ck do
    begin
      atkeisk (gyl, mas);
      dec (il)
    end
  end;
end;

procedure rasyk (ilg : integer; var ats : Teil);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'clocks.out');
  rewrite (f);
  if ilg = 0 then writeln (f, 0)
  else
  begin
   for ck := 1 to ilg - 1 do
    write (f, ats [ck], ' ');
    writeln (f, ats [ilg])
  end;
  close (f)
end;

begin
  nuskaitymas (mas);
  il := 0;
  ilg := 0;
  varyk (1, mas, eil, ats, il, ilg);
  rasyk (ilg, ats)
end.
