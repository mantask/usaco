{
ID: vkanapo001
PROG: contact
}

Program CONTACT;

const
  Cbits : array [1 .. 13] of integer =
   (1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096);
  CC = 300;

type
  Tr = 0 .. 1;
  Tmas = array [1 .. 12, 0 .. 8191] of longint;
  Tbuf = array [1 .. 12] of Tr;
  Telem = record
    kiek : integer;
    el1, el2 : array [1 .. CC] of longint { el1 - ilgis, el2 - skaicius }
  end;
  Tdidz = array [1 .. 50] of Telem;

var
  f : Text;
  nuo, iki, kiek,
  ck1, ck, pg : integer;
  c : char;
  mas : Tmas;
  buf : Tbuf;
  didz : Tdidz;

procedure pridek (R : Tr; ilg : integer; var buf : Tbuf);
var
  ck : integer;
begin
  if ilg = iki then
  begin
    for ck := 1 to ilg - 1 do
    buf [ck] := buf [ck + 1];
    buf [ilg] := r
  end
  else buf [ilg + 1] := r
end;

procedure pildyk (ilg : integer; var mas : Tmas; var buf : Tbuf);
var
  pg, ck : integer;
begin
  pg := 0;
  for ck := 1 to ilg do
  begin
    pg := pg + buf [ilg + 1 - ck] * Cbits [ck];
    if ck >= nuo then inc (mas [ck, pg])
  end
end;

procedure perstumk (ck : integer; var didz : Tdidz);
var
  ck1 : integer;
begin
  for ck1 := kiek downto ck + 1 do
  didz [ck1] := didz [ck1 - 1];
  fillchar (didz [ck], sizeof (didz [ck]), 0)
end;

procedure plius (ilg, sk : integer; var elem : Telem);
var
  ck, ck1 : Integer;
begin
  for ck := 1 to CC do
  if (((sk < elem.el2 [ck]) and (ilg = elem.el1 [ck])) or (elem.el1 [ck] = 0))
  then break;
  if ck < CC then
  begin
    for ck1 := CC downto ck + 1 do
    begin
      elem.el1 [ck1] := elem.el1 [ck1 - 1];
      elem.el2 [ck1] := elem.el2 [ck1 - 1]
    end;
    elem.el1 [ck] := ilg;
    elem.el2 [ck] := sk
  end
end;

procedure rask (var didz : Tdidz);
var
  ck1, ck2, ck : integer;
  jau : boolean;
begin
  for ck1 := nuo to iki do
  for ck2 := 0 to Cbits [ck1 + 1] - 1 do
  begin
    ck := 1;
    jau := false;
    while (ck <= kiek) and not jau do
    begin
      if (mas [ck1, ck2] = didz [ck].kiek) and (didz [ck].kiek <> 0) then
      begin
        plius (ck1, ck2, didz [ck]);
        jau := true
      end;
      if not jau and (mas [ck1, ck2] > didz [ck].kiek) then
      begin
        perstumk (ck, didz);
        didz [ck].kiek := mas [ck1, ck2];
        didz [ck].el1 [1] := ck1;
        didz [ck].el2 [1] := ck2;
        jau := true
      end;
      inc (ck)
    end
  end
end;

function dvej (ilg, sk : Integer) : string;
var
  eil : string;
  ck : integer;
begin
  eil := '';
  for ck := 1 to ilg do
  if (Cbits [ck] and sk) = Cbits [ck]
  then eil := '1' + eil
  else eil := '0' + eil;
  dvej := eil
end;

begin
  fillchar (didz, sizeof (didz), 0);
  fillchar (mas, sizeof (mas), 0);
  fillchar (buf, sizeof (buf), 0);
  pg := 0;
  assign (f, 'contact.in');
  reset (f);
  readln (f, nuo, iki, kiek);
  while not eof (f) do
  begin
    while not eoln (f) do
    begin
      read (f, c);
      case c of
        '0' : pridek (0, pg, buf);
        '1' : pridek (1, pg, buf)
      end;
      if pg < iki then inc (pg);
      pildyk (pg, mas, buf)
    end;
    readln (f)
  end;
  close (F);

  rask (didz);

  assign (f, 'contact.out');
  rewrite (f);
  for ck := 1 to kiek do
  if didz [ck].kiek = 0 then break
  else
  begin
    writeln (f, didz [ck].kiek);
    ck1 := 1;
    while (didz [ck].el1 [ck1 + 1] <> 0) do
    begin
      if ck1 mod 6 = 0
      then writeln (F, dvej (didz [ck].el1 [ck1], didz [ck].el2 [ck1]))
      else write (f, dvej (didz [ck].el1 [ck1], didz [ck].el2 [ck1]), ' ');
      inc (ck1)
    end;
    writeln (F, dvej (didz [ck].el1 [ck1], didz [ck].el2 [ck1]))
  end;
  close (F)
end.
