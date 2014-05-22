{
ID: vkanapo001
PROG: window
}

Program WINDOW;

const
  NULL = #0;

type
  Tmas = array [char] of record
    x1, x2, y1, y2 : integer;
    pries, po : Char
  end;
  Teil = array [1 .. 1000] of record
    nuo, iki : integer
  end;

var
  fin, fout : text;
  mas : Tmas;
  c, kom, lang, pirm, pask : char;
  x1, x2, y1, y2 : integer;

function min (sk1, sk2 : Integer) : Integer;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

function max (sk1, sk2 : Integer) : Integer;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

procedure komanda;
var
  pgeil, eil : string;
  poz, pg : longint;
  xx1, yy1, xx2, yy2 : integer;
begin
  read (fin, kom, c, lang, c);

  if kom = 'w' then
  begin
    readln (fin, eil);
    val (eil, xx1, poz);
    pgeil := copy (eil, 1, poz - 1);
    val (pgeil, xx1, pg);

    eil := copy (eil, poz + 1, length (eil) - poz);
    val (eil, yy1, poz);
    pgeil := copy (eil, 1, poz - 1);
    val (pgeil, yy1, pg);

    eil := copy (eil, poz + 1, length (eil) - poz);
    val (eil, xx2, poz);
    pgeil := copy (eil, 1, poz - 1);
    val (pgeil, xx2, pg);

    eil := copy (eil, poz + 1, length (eil) - poz);
    val (eil, yy2, poz);
    pgeil := copy (eil, 1, poz - 1);
    val (pgeil, yy2, pg)
  end
  else readln (fin);
  x1 := min (xx1, xx2);
  x2 := max (xx1, xx2);
  y1 := max (yy1, yy2);
  y2 := min (yy1, yy2)
end;

procedure prijunk;
begin
  if pirm = NULL then pirm := lang
                 else mas[pask].po := lang;
  mas[lang].pries := pask;
  mas[lang].x1 := x1;
  mas[lang].x2 := x2;
  mas[lang].y1 := y1;
  mas[lang].y2 := y2;
  mas[lang].po := NULL;
  pask := lang;
end;

procedure ismesk;
begin
  mas[mas[lang].po].pries := mas[lang].pries;
  mas[mas[lang].pries].po := mas[lang].po;

  if pask = lang then pask := mas[lang].pries;
  if pirm = lang then pirm := mas [lang].po
end;

procedure priekin;
begin
  ismesk;
  mas[pask].po := lang;
  mas[lang].po := NULL;
  mas[lang].pries := pask;
  pask := lang;
  if pirm = NULL then pirm := lang
end;

procedure galan;
begin
  ismesk;
  mas[pirm].pries := lang;
  mas[lang].pries := NULL;
  mas[lang].po := pirm;
  pirm := lang;
  if pask = NULL then pask := lang
end;

procedure idek (var eil : Teil; var kiek : Integer);
var
  kuris, ck : integer;
begin
  kuris := kiek;
  for ck := kiek - 1 downto 1 do
  if max (eil[kuris].nuo, eil[ck].nuo) < min (eil[ck].iki, eil[kuris].iki) then
  begin
    eil[ck].nuo := min (eil[kuris].nuo, eil[ck].nuo);
    eil[ck].iki := max (eil[ck].iki, eil[kuris].iki);
    eil[kuris].nuo := -1;
    eil[kuris].iki := -1;
    kuris := ck
  end
end;

procedure plotas;
var
  s : longint;
  kiek, ck, cky : integer;
  kuris : char;
  eil : Teil;
begin
  s := (mas[lang].y1 - mas[lang].y2);
  s:= s * (mas[lang].x2 - mas[lang].x1);
  if s = 0 then
  begin
    writeln (fout, 0.0 :0 :3);
    exit
  end;

  for ckY := mas[lang].y2 to mas[lang].y1 - 1 do
  begin
    kiek := 0;

    kuris := mas[lang].po;
    while kuris <> NULL do
    begin
      if (max (ckY, mas[kuris].y2) < min (cky + 1, mas[kuris].y1)) and
         (max (mas[kuris].x1, mas[lang].x1) < min (mas[kuris].x2, mas[lang].x2)) then
      begin
        inc (kiek);
        eil[kiek].nuo := max (mas[kuris].x1, mas[lang].x1);
        eil[kiek].iki := min (mas[kuris].x2, mas[lang].x2);
        idek (eil, kiek);
      end;
      kuris := mas[kuris].po
    end;

    for ck := 1 to kiek do
    s := s - (eil[ck].iki - eil[ck].nuo)
  end;

  writeln (fout, s / (mas[lang].y1 - mas[lang].y2) / (mas[lang].x2 - mas[lang].x1) * 100 :0 : 3)
end;

begin
  assign (fin, 'window.in');
  reset (fin);
  assign (fout, 'window.out');
  rewrite (fout);

  pirm := NULL;
  pask := NULL;

  while not eof (fin) do
  begin
    komanda;
    case kom of
      'w' : prijunk;
      't' : priekin;
      'b' : galan;
      'd' : ismesk;
      's' : plotas
    end
  end;

  close (fin);
  close (fout)
end.
