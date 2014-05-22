{
PROG: journal
LANG: PASCAL
}

Program JOURNAL;

Type
  Tpar = array [1 .. 30, 1 .. 2] of integer;
  Tpav = array [1 .. 30] of integer;

var
  pav : Tpav;
  par : Tpar;
  P, T, eil, viso, pask : Integer;

Procedure nuskaitymas (var P, T, eil : integer; var par : Tpar; var pav : Tpav);
var
  f : Text;
  ck : Integer;
begin
  assign (f, 'journal.in');
  reset (f);
  readln (f, P, T, eil);
  for ck := 1 to T do
  readln (f, par [ck, 1], par [ck, 2]);
  for ck := 1 to P do
  readln (f, pav [ck]);
  close (f)
end;

procedure rask (var viso, pask : Integer);
var
  psl : array [1 .. 60, -1 .. 0] of integer;
  ck, kuris : integer;
  jau : boolean;
begin
  fillchar (psl, sizeof (psl), 0);
  kuris := 1;
  for ck := 1 to T do
  begin
    jau := par [ck, 2] = 0;
    if not jau and (kuris > 1) and (psl [kuris - 1, 0] + pav [par [ck, 2]] <= eil) then
    begin
      inc (psl [kuris - 1, 0], pav [par [ck, 2]]);
      jau := true
    end;
    while psl [kuris, 0] + par [ck, 1] > eil do
    begin
      if not jau and (psl [kuris, 0] + pav [par [ck, 2]] <= eil) then
      begin
        inc (psl [kuris, 0], pav [par [ck, 2]]);
        jau := true
      end;
      inc (kuris)
    end;
    inc (psl [kuris, -1]);
    inc (psl [kuris, 0], par [ck, 1]);
    if not jau and (psl [kuris, 0] + pav [par [ck, 2]] <= eil) then
    begin
      inc (psl [kuris, 0], pav [par [ck, 2]]);
      jau := true
    end;
    if not jau then inc (psl [kuris + 1, 0], pav [par [ck, 2]]);
  end;
  if psl [kuris + 1, 0] > 0 then viso := kuris + 1
                            else viso := kuris;
  pask := psl [viso, 0]
end;

Procedure rasymas (viso, pask : Integer);
var
  f : Text;
begin
  assign (f, 'journal.out');
  rewrite (f);
  writeln (f, viso, ' ', pask);
  close (f)
end;

begin
  nuskaitymas (P, T, eil, par, pav);
  rask (viso, pask);
  rasymas (viso, pask)
end.
