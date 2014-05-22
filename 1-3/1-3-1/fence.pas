{
ID: vkanapo001
PROG: fence
}

Program FENCE;

type
  Tmas = array [1 .. 1024] of integer;
  Pvirs = ^Tvirs;
  Tvirs = record
    s : integer;
    kita : Pvirs
  end;
  Tg = array [1 .. 1024] of Pvirs;

var
  g : Tg;
  kiek, mas : Tmas;
  viso, ilg : integer;

procedure prij (s1, s2 : integer; var g : Tg);
var
  pg, pries, n : Pvirs;
begin
  if g [s1] = nil then
  begin
    new (N);
    n^.s := s2;
    n^.kita := nil;
    g [s1] := n
  end
  else
  begin
    pg := g [s1];
    pg := pg^.kita;
    pries := g [s1];
    if s2 < pries^.s then
    begin
      new (n);
      n^.s := s2;
      n^.kita := pries;
      g [s1] := n
    end
    else
    begin
      while (pg <> Nil) and (pg^.s <= s2) do
      begin
        pries := pries^.kita;
        pg := pg^.kita
      end;
      new (n);
      n^.s := s2;
      n^.kita := pg;
      pries^.kita := n
    end
  end;

  if g [s2] = nil then
  begin
    new (n);
    n^.s := s1;
    N^.kita := nil;
    g [s2] := n
  end
  else
  begin
    pg := g [s2];
    pg := pg^.kita;
    pries := g [s2];
    if s1 < pries^.s then
    begin
      new (n);
      n^.s := s1;
      n^.kita := pries;
      g [s2] := n;
    end
    else
    begin
      while (pg <> nil) and (pg^.s <= s1) do
      begin
        pries := pries^.kita;
        pg := pg^.kita
      end;
      new (n);
      n^.s := s1;
      n^.kita := pg;
      pries^.kita := n
    end
  end
end;

procedure nuskaitymas (var viso : Integer; var g : Tg; var kiek : Tmas);
var
  ck, pg, s1, s2 : Integer;
  f : Text;
begin
  viso := 0;
  assign (f, 'fence.in');
  reset (f);
  readln (f, pg);
  for ck := 1 to pg do
  begin
    readln (f, s1, s2);
    if s1 > viso then viso := s1;
    if s2 > viso then viso := s2;
    prij (s1, s2, g);
    inc (kiek [s1]);
    inc (kiek [s2])
  end;
  close (f)
end;

procedure ismek (s1, s2 : Integer; var G : Tg);
var
  pg, pries : Pvirs;
begin
  pg := g [s2];
  if pg^.kita = nil then g [s2] := nil
  else
  begin
    if pg^.s = s1 then g [s2] := pg^.kita
    else
    begin
      pg := pg^.kita;
      pries := g [s2];
      while pg^.s <> s1 do
      begin
        pries := pries^.kita;
        pg := pg^.kita
      end;
      pries^.kita := pg^.kita
    end
  end
end;

procedure rask (virs : integer; var ilg : integer; var mas : Tmas; var g : Tg);
var
  pg : Pvirs;
  s : Integer;
begin
  if g [virs] = nil then
  begin
    inc (ilg);
    mas [ilg] := virs
  end
  else
  begin
    while g [virs] <> nil do
    begin
      pg := g [virs];
      g [virs] := pg^.kita;
      s := pg^.s;
      dispose (pg);
      ismek (virs, s, g);
      rask (s, ilg, mas, g)
    end;
    inc (ilg);
    mas [ilg] := virs
  end
end;

procedure varyk (var g : Tg; var mas, kiek : Tmas; var ilg : integer);
var
  ck : Integer;
begin
  for ck := 1 to viso do
  if odd (kiek [ck]) then
  begin
    rask (ck, ilg, mas, g);
    exit
  end;
  ck := 1;
  while g [ck] = nil do inc (ck);
  rask (ck, ilg, mas, g)
end;

procedure rasymas (ilg : Integer; var mas : Tmas);
var
  f : text;
  ck : Integer;
begin
  assign (f, 'fence.out');
  rewrite (f);
  for ck := ilg downto 1 do
  writeln (f, mas [ck]);
  close (f)
end;

begin
  nuskaitymas (viso, g, kiek);
  ilg := 0;
  varyk (g, mas, kiek, ilg);
  rasymas (ilg, mas)
end.
