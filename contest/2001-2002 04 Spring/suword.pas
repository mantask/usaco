{
PROG: suword
LANG: PASCAL
}

Program SUWORD;
{reiketu perdaryti kada nors su kruskalo algoritmu}
type
  Tmas = array [1 .. 100] of record
    z : string;
    ilg : integer
  end;
  Tz = array [1 .. 7500] of char;
  Taib = set of 1 .. 100;

var
  viso, ats : Integer;
  mas : Tmas;
  aib : Taib;
  z, sz : Tz;

procedure nuskaitymas (var viso : integer; var mas : Tmas);
var
  f : Text;
  ck : integer;
begin
  assign (f, 'suword.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    readln (f, mas [ck].z);
    mas [ck].ilg := length (mas [ck].z)
  end;
  close (f)
end;

function prij (s1, s2 : integer) : integer;
var
  pz, ck : Integer;
  ok, pg : boolean;
begin
  pz := pos (mas [s2].z [1], mas [s1].z);
  if pz = 0 then
  begin
    prij := 1;
    exit
  end;
  ok := false;
  while not ok {and (pz <= mas [s1].ilg)} do
  begin
    pg := true;
    for ck := pz to mas [s1].ilg do
    if mas [s1].z [ck] <> mas [s2].z [ck + 1 - pz] then
    begin
      pg := false;
      break
    end;
    ok := pg;
    inc (pz)
  end;
  prij := mas [s1].ilg + 3 - pz
end;

procedure varom (var aib : Taib; gyl, poz, pz : integer;
                 var z, sz : tz; var ats : integer);
var
  nuo, ck, ck1 : integer;
begin
  if gyl = viso then
  begin
    if (poz < ats) or (ats = 0) then
    begin
      sz := z;
      ats := poz - 1
    end;
    exit
  end;
  for ck := 1 to viso do
  if pz = 0 then
  begin
    aib := aib + [ck];
    for ck1 := 1 to mas [ck].ilg do
    z [ck1] := mas [ck].z [ck1];
    varom (aib, 1, mas [ck].ilg + 1, ck, z, sz, ats);
    aib := aib - [ck]
  end
  else
  if not (ck in aib) then
  begin
    nuo := prij (pz, ck);
    aib := aib + [ck];
    for ck1 := nuo to mas [ck].ilg do
    z [poz + ck1 - nuo] := mas [ck].z [ck1];
    varom (aib, gyl + 1, poz + 1 + mas [ck].ilg - nuo, ck, z, sz, ats);
    aib := aib - [ck]
  end
end;

procedure rasyk (var sz : Tz; ilg : integer);
var
  f : text;
  ck : integer;
begin
  assign (f, 'suword.out');
  rewrite (f);
  for ck := 1 to ilg do
  write (f, sz [ck]);
  writeln (f);
  close (f)
end;

begin
  nuskaitymas (viso, mas);
  aib := [];
  ats := 0;
  varom (aib, 0, 1, 0, z, sz, ats);
  rasyk (sz, ats)
end.
