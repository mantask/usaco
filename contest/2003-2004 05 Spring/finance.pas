{
PROG: finance
LANG: PASCAL
}

Program FINANCE;

Const
  MaxViso = 19999;
  maxTalpa = 1000000;

Type
  Tduom = array [1 .. 100000] of longint;

var
  svoris, verte : array [0 .. MaxViso, 0 .. MaxTalpa] of integer;
  kiek, viso, talpa : longint;
  ats : array [1 .. MaxViso] of longint;
  mas : ^Tmas;

Procedure nuskaitymas;
var
  f : Text;
  ck : longint;
begin
  assign (f, 'finance.in');
  reset (f);
  readln (f, kiek, viso, talpa);
  for ck := 1 to viso do
  readln (f, verte [ck], svoris [ck]);
  close (f)
end;


procedure rask;
var
  ckKIEK, ckSVORIS : longint;
begin
  for ckSVORIS := 0 to TALPA do
  begin
    mas [0, ckSVORIS] := 0;
    for ckKIEK := 1 to VISO do
    begin
      mas [ckKIEK, ckSVORIS] := mas [ckKIEK - 1, ckSVORIS];
      if svoris [ckKIEK] <= ckSVORIS
      then mas [ckKIEK, ckSVORIS] := max (mas [ckKIEK - 1, ckSVORIS - svoris [ckKIEK]] +
                                          verte [ckKIEK], mas [ckKIEK, ckSVORIS])
    end
  end
end;

procedure atsek;
var
  ckKIEK, ckSVORIS : integer;
begin
  ckSVORIS := TALPA;
  for ckKIEK := kiek downto 1 do
  if mas [ckKIEK, ckSVORIS] <> mas [ckKIEK - 1, ckSVORIS] then
  begin
    inc (visoATS);
    ats [visoATS] := verte [ckKIEK];
    ckSVORIS := ckSVORIS - svoris [ckKIEK]
  end
end;

Procedure quicksort (r1, r2 : longint);
var
  v1, v2, v, pg : longint;
begin
  v1 := r1;
  v2 := r2;
  v := ats [(v1 + v2) div 2];
  repeat
    while ats [v1] < v do inc (v1);
    while ats [v2] > v do dec (v2);
    if v1 <= v2 then
    begin
      pg := ats [v1];
      ats [v1] := ats [v2];
      ats [v2] := pg;
      inc (v1);
      dec (v2)
    end
  until v1 > v2;
  if v1 < r2 then quicksort (v1, r2);
  if r1 < v2 then quicksort (r1, v2)
end;


procedure rasymas;
var
  f : text;
begin
  assign (f, 'finance.out');
  rewrite (f);
  writeln (f, ats [kiek div 2 + 1]);
  close (f)
end;

begin
  nuskaitymas;
  rask;
  atsek;
  quicksort (1, kiek);
  rasymas
end.
