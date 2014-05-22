{
ID: vkanapo001
PROG: milk4
}

Program MILK4;

type
  Ttalpa = array [1 .. 100] of integer;
  Tats = array [0 .. 100] of integer;

var
  turis, kiek : Integer;
  talpa : Ttalpa;
  mas, ats : Tats;

procedure nuskaitymas (var turis, kiek : integer; var talpa : Ttalpa; var ats : Tats);
var
  f : text;
  viso, ck, ck1, pg : integer;
  buvo : boolean;
begin
  assign (f, 'milk4.in');
  reset (f);
  read (f, turis, viso);
  kiek := 0;
  for ck := 1 to viso do
  begin
    read (f, pg);
    buvo := false;
    for ck1 := 1 to kiek do
    if talpa [ck1] = pg then
    begin
     buvo := true;
     break
    end;
    if not buvo then
    begin
      inc (kiek);
      talpa [kiek] := pg
    end
  end;
  close (f);

  for ck := 0 to 100 do
  ats [ck] := maxint;
end;

Procedure quicksort (r1, r2 : Integer; var mas : Ttalpa);
var
  v1, v2, v, pg : Integer;
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
  if v1 < r2 then quicksort (v1, r2, mas);
  if r1 < v2 then quicksort (r1, v2, mas)
end;

function maziau (var mas, ats : Tats) : boolean;
var
  ck : integer;
begin
  for ck := 1 to mas [0] do
  if mas [ck] > ats [ck] then
  begin
    maziau := false;
    exit
  end;
  maziau := true
end;

procedure lisk (gylis, liko : integer; var mas, ats : Tats);
var
  ck : integer;
begin
  if liko = 0 then
  begin
    if (mas [0] < ats [0]) or (mas [0] = ats [0]) and maziau (mas, ats) then ats := mas;
    exit
  end;

  if (gylis > kiek) or (ats [0] < mas [0]) or (liko < talpa [gylis])
  then exit;

  inc (mas [0]);
  for ck := liko div talpa [gylis] downto 1 do
  begin
    mas [mas [0]] := talpa [gylis];
    lisk (gylis + 1, liko - ck * talpa [gylis], mas, ats);
  end;
  dec (mas [0]);
  lisk (gylis + 1, liko, mas, ats)
end;

procedure rasymas (var ats : Tats);
var
  f : Text;
  ck : integer;
begin
  assign (f, 'milk4.out');
  rewrite (f);
  write (f, ats [0], ' ');
  for ck := 1 to ats [0] - 1 do
  write (f, ats [ck], ' ');
  writeln (f, ats [ats [0]]);
  close (f)
end;

begin
  nuskaitymas (turis, kiek, talpa, ats);
  quicksort (1, kiek, talpa);
  lisk (1, turis, mas, ats);
  rasymas (ats)
end.
