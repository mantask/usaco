{
ID: vkanapo001
PROG: msquare
}

Program MSQUARE;

const
  max = 50000;

Type
  Tel = array [1 .. 8] of 1 .. 8;
  Teil = array [1 .. max] of Tel;
  Tats = array [1 .. max] of 0 .. 3;
  Tyra = array [1 .. 40320] of boolean;

var
  v : Tel;
  ats : Tats;
  viso : integer;

procedure nuskaitymas (var v : Tel);
var
  f : text;
  ck : integer;
begin
  assign (f, 'msquare.in');
  reset (f);
  for ck := 1 to 8 do
  read (f, v [ck]);
  close (f)
end;

procedure T (nr : integer; var el1, el2 : Tel);
var
  ck : integer;
begin
  if nr = 1 then
  for ck := 1 to 8 do
  el2 [ck] := el1 [9 - ck]
  else
  if nr = 2 then
  begin
    for ck := 1 to 3 do
    el2 [ck + 1] := el1 [ck];
    el2 [1] := el1 [4];
    for ck := 5 to 7 do
    el2 [ck] := el1 [ck + 1];
    el2 [8] := el1 [5]
  end
  else
  begin
    el2 [1] := el1 [1];
    el2 [2] := el1 [7];
    el2 [3] := el1 [2];
    el2 [4] := el1 [4];
    el2 [5] := el1 [5];
    el2 [6] := el1 [3];
    el2 [7] := el1 [6];
    el2 [8] := el1 [8]
  end
end;

function lygu (var el1, el2 : Tel) : boolean;
var
  ck : integer;
begin
  for ck := 1 to 8 do
  if el1 [ck] <> el2 [ck] then
  begin
    lygu := false;
    exit
  end;
  lygu := true
end;

function kod (el : Tel) : longint;
var
  ck : Integer;
  pg : longint;
begin
  pg := (el [1] - 1) * 5040;
  for ck := 2 to 8 do
  if el [ck] > el [1] then dec (el [ck]);
  inc (pg, (el [2] - 1) * 720);
  for ck := 3 to 8 do
  if el [ck] > el [2] then dec (el [ck]);
  inc (pg, (el [3] - 1) * 120);
  for ck := 4 to 8 do
  if el [ck] > el [3] then dec (el [ck]);
  inc (pg, (el [4] - 1) * 24);
  for ck := 5 to 8 do
  if el [ck] > el [4] then dec (el [ck]);
  inc (pg, (el [5] - 1) * 6);
  for ck := 6 to 8 do
  if el [ck] > el [5] then dec (el [ck]);
  inc (pg, (el [6] - 1) * 2);
  for ck := 7 to 8 do
  if el [ck] > el [6] then dec (el [ck]);
  inc (pg, el [7] - 1);
  kod := pg + 1
end;

procedure skaiciuok (var viso : Integer; var ats : Tats);
var
  eil : Teil;
  ish : array [1 .. max] of longint;
  kaip : array [1 .. max] of 0 .. 3;
  ck, nuo : integer;
  kuris, gal, uod : LONGINT;
  jau : boolean;
  el : Tel;
  yra : Tyra;
  pg : longint;
begin
  fillchar (yra, sizeof (yra), 0);
  gal := 1;
  uod := 2;
  for ck := 1 to 8 do
  eil [1, ck] := ck;
  ish [1] := 0;
  kaip [1] := 0;
  jau := false;

  if not lygu (v, eil [1]) then
  while not jau do
  begin
    if (kaip [gal] = 3) or (kaip [gal] = 0) then nuo := 1
                                            else nuo := 2;
    for ck := nuo to 3 do
    begin
      t (ck, eil [gal], el);
      pg := kod (el);
      if not yra [pg] then
      begin
        yra [pg] := true;
        eil [uod] := el;
        ish [uod] := gal;
        kaip [uod] := ck;
        inc (uod);
        jau := jau or lygu (el, v);
        if jau then break
      end
    end;
    inc (gal)
  end;

  kuris := uod - 1;
  viso := 0;
  while kuris <> 1 do
  begin
    inc (viso);
    ats [viso] := kaip [kuris];
    kuris := ish [kuris]
  end
end;

procedure rasymas (viso : Integer; var ats : Tats);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'msquare.out');
  rewrite (f);
  writeln (f, viso);
  for ck := viso downto 1 do
  case ats [ck] of
    1 : write (f, 'A');
    2 : write (f, 'B');
    3 : write (f, 'C')
  end;
  writeln (f);
  close (f)
end;

begin
  nuskaitymas (v);
  skaiciuok (viso, ats);
  rasymas (viso, ats)
end.
