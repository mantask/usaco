{
ID: vkanapo001
PROG: calfflac
}

Program CALFFLAC;

Const
  Simb : set of char = ['A' .. 'Z', 'a' .. 'z'];

type
  Tvisi = array [1 .. 20000] of char;
  Tmas = array [1 .. 20000] of record
    nr : integer;
    c : char
  end;

var
  visi : Tvisi;
  mas : Tmas;
  kiek, nuo, viso, ilg : Integer;

procedure nuskaitymas (var viso, ilg : integer; var mas : Tmas; var visi : Tvisi);
var
  f : Text;
  c : char;
begin
  viso := 0;
  ilg := 0;
  assign (f, 'calfflac.in');
  reset (F);
  while not eof (f) do
  begin
    read (f, c);
    inc (viso);
    visi [viso] := c;
    if c in Simb then
    begin
      inc (ilg);
      mas [ilg].c := upcase (c);
      mas [ilg].nr := viso
    end
  end;
  close (f)
end;

procedure max1 (pz : Integer; var kiek, nuo : Integer; var mas : Tmas);
var
  l : integer;
begin
  l := 0;
  while (pz + l < ilg) and (pz - l > 1) and
        (mas [pz + l + 1].c = mas [pz - l - 1].c) do inc (l);
  kiek := l * 2 + 1;
  nuo := mas [pz - l].nr
end;

procedure max2 (pz : Integer; var kiek, nuo : Integer; var mas : Tmas);
var
  l : integer;
begin
  l := 0;
  while (pz + l + 1 < ilg) and (pz - l > 1) and
        (mas [pz + l + 2].c = mas [pz - l - 1].c) do inc (l);
  kiek := l * 2 + 1;
  nuo := mas [pz - l].nr
end;

procedure ieskok (var nuo, kiek : Integer; var mas : Tmas);
var
  pgkiek, pgnuo, ck : integer;
begin
  kiek := 0;
  for ck := 1 to ilg do
  begin
    max1 (ck, pgkiek, pgnuo, mas);
    if kiek < pgkiek then
    begin
      kiek := pgkiek;
      nuo := pgnuo
    end;
    if (ck + 1 <= ilg) and (mas [ck].c = mas [ck + 1].c) then
    begin
      max2 (ck, pgkiek, pgnuo, mas);
      if kiek < pgkiek then
      begin
        kiek := pgkiek + 1;
        nuo := pgnuo
      end
    end
  end
end;

procedure rasymas (nuo, kiek : integer; var visi : Tvisi);
var
  f : Text;
  poz : integer;
begin
  assign (f, 'calfflac.out');
  rewrite (f);
  writeln (f, kiek);
  poz := nuo;
  while kiek > 0 do
  begin
    write (f, visi [poz]);
    if visi [poz] in simb then dec (kiek);
    inc (poz)
  end;
  writeln (f);
  close (f)
end;

begin
  nuskaitymas (viso, ilg, mas, visi);
  ieskok (nuo, kiek, mas);
  rasymas (nuo, kiek, visi)
end.
