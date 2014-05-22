{
ID: vkanapo001
PROG: cryptcow
}

Program CRYPTCOW;

type
  Tmas = array [1 .. 75] of char;

const
  e = 'Begin the Escape execution at the Break of Dawn';
  eil : array [1 .. 47] of char =
  ('B', 'e', 'g', 'i', 'n', ' ', 't', 'h', 'e', ' ',
   'E', 's', 'c', 'a', 'p', 'e', ' ', 'e', 'x', 'e',
   'c', 'u', 't', 'i', 'o', 'n', ' ', 'a', 't', ' ',
   't', 'h', 'e', ' ', 'B', 'r', 'e', 'a', 'k', ' ',
   'o', 'f', ' ', 'D', 'a', 'w', 'n');

var
  ck, n, nuo, iki, viso : Integer;
  mas : Tmas;
  ok : boolean;

function nuskaitymas (var viso, nuo, iki, n : Integer; var mas : Tmas) : boolean;
var
  f : Text;
  pgeil : string;
  sk1, sk2, sk3 : Integer;
  taip : boolean;
begin
  sk1 := 0;
  sk2 := 0;
  sk3 := 0;
  viso := 0;
  nuo := 0;
  pgeil := '';
  assign (f, 'cryptcow.in');
  reset (f);
  while not eoln (f) do
  begin
    inc (viso);
    read (f, mas [viso]);
    taip := true;
    case mas [viso] of
      'C' : inc (sk1);
      'O' : inc (sk2);
      'W' : begin inc (sk3); iki := viso end
      else taip := false
    end;
    if (nuo = 0) and (sk1 = 1) then nuo := viso;
    if taip then
    begin
      if (pgeil <> '') and (pos (pgeil, e) = 0) then
      begin
        nuskaitymas := false;
        exit
      end;
      pgeil := ''
    end
    else pgeil := pgeil + mas [viso]
  end;
  close (f);
  n := sk1;
  if (sk1 <> sk2) or (sk2 <> sk3) or (viso - sk1 - sk2 - sk3 <> 47) then
  begin
    nuskaitymas := false;
    exit
  end;
  sk1 := 1;
  while (sk1 <= viso) and (mas [sk1] <> 'C') do
  begin
    if mas [sk1] <> eil [sk1] then
    begin
      nuskaitymas := false;
      exit
    end;
    inc (sk1);
  end;
  sk2 := viso;
  while (sk2 > 1) and (mas [sk2] <> 'W') do
  begin
    if mas [sk2] <> eil [47 + sk2 - viso] then
    begin
      nuskaitymas := false;
      exit
    end;
    dec (sk2)
  end;
  nuskaitymas := true
end;

procedure sukeisk (s1, s2, s3 : Integer; var viso : integer; var mas : Tmas);
var
  pgMAS : Tmas;
  ck, pg : Integer;
begin
  for ck := s1 + 1 to s2 - 1 do
  pgMAS [ck] := mas [ck];
  pg := s2 - s1 + 1;
  for ck := s2 + 1 to s3 - 1 do
  mas [ck - pg] := mas [ck];
  pg := s3 - pg - s1 - 1;
  for ck := s1 + 1 to s2 - 1 do
  mas [ck + pg] := pgMAS [ck];
  for ck := s3 - 2 to viso - 3 do
  mas [ck] := mas [ck + 3];
  dec (viso, 3)
end;

function oki (viso : Integer; var mas : Tmas) : boolean;
var
  ck : Integer;
  pgeil : string;
begin
  pgEIL := '';
  for ck := 1 to viso do
  if (mas [ck] = 'C') or (mas [ck] = 'O') or (mas [ck] = 'W') then
  begin
    if (pgeil <> '') and (pos (pgeil, e) = 0) then
    begin
      oki := false;
      exit
    end;
    pgeil := ''
  end
  else pgeil := pgeil + mas [ck];
  if (pgeil <> '') and (pos (pgeil, e) = 0) then oki := false
                                            else oki := true
end;

procedure lisk (var nuo, iki, viso : Integer; var mas : Tmas; var ats : boolean);
var
  pgNUO, pgIKI, pgVISO,
  ck1, ck2, ck3 : Integer;
  pgMAS : Tmas;
begin
  if ats then exit;
  for ck2 := nuo to viso do
  if not ok and (mas [ck2] = 'O') then
  for ck1 := nuo to ck2 - 1 do
  if not ok and (mas [ck1] = 'C') then
  for ck3 := iki downto ck2 + 1 do
  if not ok and (mas [ck3] = 'W') then
  begin
    pgVISO := viso;
    pgMAS := mas;
    sukeisk (ck1, ck2, ck3, pgVISO, pgMAS);
    pgNUO := nuo;
    pgIKI := iki - 3;
    while (pgNUO < pgVISO) and (pgMAS [pgNUO] = eil [pgNUO]) do inc (pgNUO);
    while (pgIKI > 1) and (pgMAS [pgIKI] = eil [47 - (pgVISO - pgIKI)]) do dec (pgIKI);
    if pgNUO = pgVISO then
    begin
      ats := true;
      exit
    end
    else
    if (pgMAS [pgNUO] = 'C') and (pgMAS [pgIKI] = 'W') and Oki (pgViso, pgMAS)
    then lisk (pgnuo, pgiki, pgviso, pgmas, ats);
  end
end;

procedure rasymas (sk1, sk2 : integer);
var
  f : Text;
begin
  assign (f, 'cryptcow.out');
  rewrite (f);
  writeln (f, sk1, ' ', sk2);
  close (f)
end;

begin
  if nuskaitymas (viso, nuo, iki, n, mas) then
  begin
    ok := true;
    for ck := 1 to viso do
    if mas [ck] <> eil [ck] then
    begin
      ok := false;
      break
    end;
    lisk (nuo, iki, viso, mas, ok);
    if ok then rasymas (1, n)
          else rasymas (0, 0)
  end
  else rasymas (0, 0)
end.
