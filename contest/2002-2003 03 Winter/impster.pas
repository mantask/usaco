{
PROG: impster
LANG: PASCAL
}

Program IMPSTER;

const
  bits : array [1 .. 16] of word =
   (1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768);

Type
  Tmas = array [1 .. 100] of word;

var
  mas : Tmas;
  kiek, ilg, viso : Integer;
  ats, sk : word;

function versk (eil : string; ilg : integer) : word;
var
  ck : Integer;
  pg : Word;
begin
  pg := 0;
  for ck := 1 to ilg do
  if eil [ilg + 1 - ck] = '1' then pg := pg + bits [ck];
  versk := pg
end;

Procedure nuskaitymas (var ilg, viso : Integer; var sk : word; var mas : Tmas);
var
  f : Text;
  eil : string;
  ck : Integer;
begin
  assign (f, 'impster.in');
  reset (f);
  readln (f, ilg, viso);
  readln (f, eil);
  sk := versk (eil, ilg);
  for ck := 1 to viso do
  begin
    readln (f, eil);
    mas [ck] := versk (eil, ilg)
  end;
  close (f)
end;

function skirtumai (sk1, sk2 : word) : integer;
var
  kiek, ck : Integer;
  pg : word;
begin
  kiek := 0;
  pg := sk1 xor sk2;
  for ck := 1 to ilg do
  if pg and bits [ck] = bits [ck] then inc (kiek);
  skirtumai := kiek
end;

procedure rask (var kiek : integer; var ats : word);
var
  jau : array [0 .. 65535] of boolean;
  eil : array [1 .. 65536, 1 .. 2] of word;
  ski, nauji : integer;
  pg, ck1, ck2, galas, uod : word;
begin
  ski := maxint;
  fillchar (jau, sizeof (jau), 0);
  uod := 1;
  for ck1 := 1 to viso do
  begin
    jau [mas [ck1]] := true;
    eil [uod, 1] := mas [ck1];
    eil [uod, 2] := 0;
    pg := skirtumai (sk, mas [ck1]);
    if (ski > pg) or ((ski = pg) and (ats > mas [ck1])) then
    begin
      ski := pg;
      ats := mas [ck1];
      kiek := 0
    end;
    inc (uod)
  end;

  repeat
    nauji := 0;
    galas := uod;
    for ck1 := 1 to galas do
    for ck2 := ck1 + 1 to galas do
    begin
      pg := eil [ck1, 1] xor eil [ck2, 1];
      if not jau [pg] then
      begin
        jau [pg] := true;
        eil [uod, 1] := pg;
        eil [uod, 2] := eil [ck1, 2] + eil [ck2, 2] + 1;
        pg := skirtumai (sk, eil [uod, 1]);
        if (ski > pg) or ((ski = pg) and (ats > eil [uod, 1])) then
        begin
          ski := pg;
          ats := eil [uod, 1];
          kiek := eil [uod, 2]
        end;
        inc (uod);
        inc (nauji)
      end
    end
  until (nauji = 0) or jau [sk];
  if jau [sk] then
  begin
    kiek := eil [uod - 1, 2];
    ats := eil [uod - 1, 1]
  end
end;

procedure rasymas (kiek : Integer; ats : word);
var
  ck : Integer;
  f : text;
begin
  assign (f, 'impster.out');
  rewrite (f);
  writeln (f, kiek);
  for ck := ilg downto 1 do
  if ats and bits [ck] = bits [ck]
  then write (f, '1')
  else write (f, '0');
  writeln (f);
  close (f)
end;

begin
  nuskaitymas (ilg, viso, sk, mas);
  rask (kiek, ats);
  rasymas (kiek, ats)
end.
