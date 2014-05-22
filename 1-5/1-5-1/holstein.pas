{
ID: vkanapo001
PROG: holstein
}

Program HOLSTEIN;

type
  Tats = array [1 .. 15] of integer;
  Tel = array [1 .. 25] of integer;
  Tmas = array [1 .. 15] of Tel;

var
  kiekATS, viso, kiek : Integer;
  ats : Tats;
  m : Tel;
  mas : Tmas;

procedure nuskaitymas (var viso, kiek : Integer; var m : Tel; var mas : Tmas);
var
  f : Text;
  ck, ck1 : integer;
begin
  assign (f, 'holstein.in');
  reset (f);
  readln (f, kiek);
  for ck := 1 to kiek do
  read (f, m [ck]);
  readln (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    for ck1 := 1 to kiek do
    read (f, mas [ck, ck1]);
    readln (f)
  end;
  close (f)
end;

function tinka (var el : Tel) : boolean;
var
  ck : integer;
begin
  for ck := 1 to kiek do
  if el [ck] < m [ck] then
  begin
    tinka := false;
    exit
  end;
  tinka := true
end;

procedure lisk (gyl : Integer; var max : Integer; var el : Tel;
                var ats : Tats; var jau : boolean);
var
  nuo, ck, ck1 : Integer;
begin
  if jau then exit;

  if gyl = max then
  begin
    jau := tinka (el);
    exit
  end;

  if gyl = 1 then nuo := 1
             else nuo := ats [gyl - 1] + 1;
  for ck := nuo to viso do
  begin
    ats [gyl] := ck;
    for ck1 := 1 to kiek do
    inc (el [ck1], mas [ck, ck1]);
    lisk (gyl + 1, max, el, ats, jau);
    if jau then break;
    for ck1 := 1 to kiek do
    dec (el [ck1], mas [ck, ck1])
  end
end;

procedure skaiciavimas (var kiekATS : Integer; var ats : Tats);
var
  jau : boolean;
  ck : integer;
  el : Tel;
begin
  jau := false;
  for ck := 2 to viso + 1 do
  begin
    fillchar (el, sizeof (el), 0);
    lisk (1, ck, el, ats, jau);
    if jau then break
  end;
  kiekATS := ck - 1
end;

procedure rasymas (kiekATS : INteger; var ats : Tats);
var
  f : text;
  ck : Integer;
begin
  assign (f, 'holstein.out');
  rewrite (f);
  write (f, kiekATS, ' ');
  for ck := 1 to kiekATS - 1 do
  write (f, ats [ck], ' ');
  writeln (f, ats [kiekATS]);
  close (f)
end;

begin
  nuskaitymas (viso, kiek, m, mas);
  skaiciavimas (kiekATS, ATS);
  rasymas (kiekATS, ATS)
end.
