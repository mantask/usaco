{
ID: vkanapo001
PROG: fence8
}

Program FENCE8;

type
  Tmas = array [1 .. 1023] of integer;
  Tjau = array [1 .. 1023] of boolean;

var
  kup, obj : Tmas;
  ats, visoK, visoO : Integer;
  sumaK, sumaO : Longint;

procedure nuskaitymas (var visoKUP, visoOBJ : integer; var sumaK, sumaO : Longint;
                       var kup, obj : Tmas);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'fence8.in');
  reset (f);
  sumaK := 0;
  readln (f, visoKUP);
  for ck := 1 to visoKUP do
  begin
    readln (f, kup [ck]);
    inc (sumaK, kup [ck])
  end;
  sumaO := 0;
  readln (f, visoOBJ);
  for ck := 1 to visoOBJ do
  begin
    readln (f, obj [ck]);
    inc (sumaO, obj [ck])
  end;
  close (f)
end;

procedure rikiuok (r1, r2 : Integer; var mas : Tmas);
var
  pg, v, v1, v2 : Integer;
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
  if r1 < v2 then rikiuok (r1, v2, mas);
  if v1 < r2 then rikiuok (v1, r2, mas)
end;

procedure prastink (var viso : integer; var sumaK, sumaO : Longint);
begin
  while sumaK < sumaO do
  begin
    dec (sumaO, obj [viso]);
    dec (viso)
  end
end;

procedure sukisk (var ok : boolean; liko : integer; var maz : Integer; var pgjau,
                  jau : Tjau; var visoK, visoO : integer; var kup, obj : Tmas);
var
  ck : Integer;
begin
  if liko < maz then
  begin
    jau := pgjau;
    maz := liko;
    if liko = 0 then ok := false;
  end;

  for ck := visoO downto 1 do
  if not pgjau [ck] and (obj [ck] <= liko) and ok then
  begin
    pgjau [ck] := true;
    sukisk (ok, liko - obj [ck], maz, pgjau, jau, visoK, visoO, kup, obj);
    pgjau [ck] := false
  end
end;

function bandyk (n : integer; var jau : Tjau; var visoO : integer;
                 var kup, obj : Tmas) : boolean;
var
  sum, ck : Integer;
begin
  sum := 0;
  for ck := 1 to visoO do
  if not jau [ck] then
  begin
    inc (sum, obj [ck]);
    if sum > kup [n] then
    begin
      bandyk := false;
      exit
    end
  end;
  fillchar (jau, sizeof (jau), 1);
  bandyk := true
end;

function tikrink (var visoK, visoO : integer; var kup, obj : Tmas) : boolean;
var
  pgjau, jau : Tjau;
  maz, ck : Integer;
  ok : boolean;
begin
  fillchar (jau, sizeof (jau), 0);
  for ck := 1 to visoK do
  begin
    pgjau := jau;
    ok := true;
    maz := kup [ck];
    if bandyk (ck, jau, visoO, kup, obj)
    then break
    else sukisk (ok, KUP [ck], maz, pgjau, jau, visoK, visoO, kup, obj)
  end;

  for ck := 1 to visoO do
  if not jau [ck] then
  begin
    tikrink := false;
    exit
  end;

  tikrink := true
end;

function rask (visoK, visoO : integer; sumaK, sumaO : Longint;
               var kup, obj : Tmas) : integer;
begin
  rikiuok (1, visoK, kup);
  rikiuok (1, visoO, obj);
  prastink (visoO, sumaK, sumaO);
  while not tikrink (visoK, visoO, kup, obj) do dec (visoO);
  rask := visoO
end;

procedure rasymas (ats : Integer);
var
  f : Text;
begin
  assign (f, 'fence8.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (visoK, visoO, sumaK, sumaO, KUP, OBJ);
  ats := rask (visoK, visoO, sumaK, sumaO, KUP, OBJ);
  rasymas (ats)
end.
