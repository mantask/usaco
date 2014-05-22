{
ID: vkanapo001
PROG: gift1
}

Program GIFT1;

type
  Telem = record
    v : string;
    s, k : integer;
    m : array [1 .. 10] of boolean;
  end;
  Tzm = array [1 .. 10] of Telem;

var
  viso : Integer;
  zm : Tzm;

procedure nuskaitymas (var viso : integer; var zm : Tzm);
var
  f : Text;
  ck, z, zz, pg, ck1, ck2 : integer;
  pz : longint;
  pgeil, eil : string;
begin
  fillchar (zm, sizeof (zm), 0);
  assign (f, 'gift1.in');
  reset (f);
  readln (f, viso);
  readln (f, eil);
  for ck := 1 to viso do
  begin
    pz := pos (' ', eil);
    if pz = 0 then
    begin
      zm [ck].v := eil;
      if ck <> viso then readln (f, eil)
    end
    else
    begin
      zm [ck].v := copy (eil, 1, pz - 1);
      delete (eil, 1, pz)
    end
  end;
  for ck := 1 to viso do
  begin
    readln (f, eil);
    pz := pos (' ', eil);
    pgeil := copy (eil, 1, pz - 1);
    delete (eil, 1, pz);
    for z := 1 to viso do
    if zm [z].v = pgeil then
    begin
      z := z;
      break
    end;
    pz := pos (' ', eil);
    pgeil := copy (eil, 1, pz - 1);
    delete (eil, 1, pz);
    val (pgeil, zm [z].s, pz);
    pz := pos (' ', eil);
    pgeil := copy (eil, 1, pz - 1);
    delete (eil, 1, pz);
    val (pgeil, pg, pz);
    zm [Z].k := pg;
    for ck1 := 1 to pg do
    begin
      pz := pos (' ', eil);
      if pz = 0 then
      begin
        pgeil := eil;
        if ck1 <> pg then readln (f, eil)
      end
      else
      begin
        pgeil := copy (eil, 1, pz - 1);
        delete (eil, 1, pz)
      end;
      for ck2 := 1 to viso do
      if zm [ck2].v = pgeil then
      begin
        zz := ck2;
        break
      end;
      zm [z].m [zz] := true
    end
  end;
  close (f)
end;

procedure surasyk (viso : Integer; zm : Tzm);
var
  F : text;
  pg, ck, ckz, gal : integer;
begin
  assign (f, 'gift1.out');
  rewrite (f);
  for ck := 1 to viso do
  begin
    gal := 0;
    for ckz := 1 to viso do
    if (zm [ckz].m [ck]) and (zm [ckz].k <> 0) then
    gal := gal + zm [ckz].s div zm [ckz].k;

    if zm [ck].k <> 0 then pg := gal - zm [ck].s + zm [ck].s mod zm [ck].k
                      else pg := gal - zm [ck].s + zm [ck].s;
    writeln (f, zm [ck].v, ' ', pg)
  end;
  close (f)
end;

begin
  nuskaitymas (viso, zm);
  surasyk (viso, zm)
end.
