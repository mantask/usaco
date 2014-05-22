{
ID: vkanapo001
PROG: prefix
}

Program PREFIX;

Type
  Tmas = array [1 .. 201] of record
    il : 0 .. 10;
    s : array [1 .. 10] of 1 .. 26
  end;
  Teil = array [1 .. 200000] of 1 .. 26;
  Tsk = 0 .. 200000;

var
  kiek : Integer;
  ilg, ats : Tsk;
  eil : Teil;
  mas : Tmas;

procedure nuskaitymas (var kiek : Integer; var mas : Tmas;
                       var ilg : Tsk; var eil : Teil);
var
  f : Text;
  k : Integer;
  c : char;
begin
  k := ord ('A') - 1;
  kiek := 0;
  ilg := 0;
  assign (f, 'prefix.in');
  reset (f);

  while true do
  begin
    while not eoln (f) do
    begin
      inc (kiek);
      mas [kiek].il := 0;
      while not eoln (f) do
      begin
        read (f, c);
        if (c = '.') or (c = ' ') then break;
        inc (mas [kiek].il);
        mas [kiek].s [mas [kiek].il] := ord (c) - k
      end
    end;
    readln (f);
    if c = '.' then break
  end;
  dec (kiek);

  while not eof (F) do
  begin
    while not eoln (F) do
    begin
      read (f, c);
      inc (ilg);
      eil [ilg] := ord (c) - k
    end;
    readln (f)
  end;
  close (f)
end;

function galima (nuo : Tsk; kuris : Integer) : boolean;
var
  ck : Tsk;
begin
  for ck := 1 to mas [kuris].il do
  if eil [nuo + ck] <> mas [kuris].s [ck] then
  begin
    galima := false;
    exit
  end;
  galima := true
end;

function rask : Tsk;
var
  yra : array [0 .. 200000] of boolean;
  pg, max, ck1 : Tsk;
  ck2 : Integer;
begin
  fillchar (yra, sizeof (yra), 0);
  yra [0] := true;
  max := 0;
  for ck1 := 0 to ilg do
  if yra [ck1] then
  begin
    for ck2 := 1 to kiek do
    if galima (ck1, ck2) then
    begin
      pg := ck1 + mas [ck2].il;
      if max < pg then max := pg;
      yra [pg] := true
    end
  end;
  rask := max
end;

procedure rasymas (ats : Tsk);
var
  f : Text;
begin
  assign (f, 'prefix.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (kiek, mas, ilg, eil);
  ats := rask;
  rasymas (ats)
end.
