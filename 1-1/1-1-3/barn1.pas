{
ID: vkanapo001
PROG: barn1
}

Program BARN1;

type
  Tmas = array [1 .. 200] of boolean;

var
  tv : Tmas;
  ats, lent, viso : integer;

procedure nuskaitymas (var lent, viso : integer; var tv : Tmas);
var
  f : text;
  ck, v, pg : integer;
begin
  fillchar (tv, sizeof (tv), 0);
  assign (f, 'barn1.in');
  reset (f);
  readln (f, lent, viso, v);
  for ck := 1 to v do
  begin
    readln (f, pg);
    tv [pg] := true
  end;
  close (f)
end;

function skaiciuok (lent, viso : integer; var tv : Tmas) : integer;
var
  ats, poz, pz, ilg, max, ck, uzd : integer;
begin
  uzd := 0;
  for ck := 1 to viso do
  if tv [ck] and ((ck = 1) or not tv [ck - 1]) then inc (uzd);
  if uzd = 0 then
  begin
    skaiciuok := 0;
    exit
  end;
  while uzd > lent do
  begin
    pz := 0;
    max := 1000;
    ilg := 0;
    for ck := 1 to viso do
    if not tv [ck] then
    begin
      inc (ilg);
      if (ilg = 1) and (ck > 1) then pz := ck
    end
    else
    begin
      if (ilg > 0) and (ilg < max) and (pz <> 0) then
      begin
        poz := pz;
        max := ilg
      end;
      ilg := 0
    end;
    ck := poz;
    while not tv [ck] do
    begin
      tv [ck] := true;
      inc (ck)
    end;
    uzd := 0;
    for ck := 1 to viso do
    if tv [ck] and ((ck = 1) or not tv [ck - 1]) then inc (uzd);
    if uzd = 0 then
    begin
      skaiciuok := 0;
      exit
    end;
  end;
  ats := 0;
  for ck := 1 to viso do
  if tv [ck] then inc (ats);
  skaiciuok := ats
end;

procedure rasyk (ats : integer);
var
  f : Text;
begin
  assign (f, 'barn1.out');
  rewrite (f);
  writeln (f, ats);
  close (F)
end;

begin
  nuskaitymas (lent, viso, tv);
  ats := skaiciuok (lent, viso, tv);
  rasyk (ats)
end.
