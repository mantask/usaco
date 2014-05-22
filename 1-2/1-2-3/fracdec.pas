{
ID: vkanapo001
PROG: fracdec
}

Program FRACDEC;

type
  Tmas = array [1 .. 200000] of 0 .. 9;
  Tliek = array [1 .. 200000] of -1 .. 999999;

var
  ilg, T, vnt, s1, s2 : longint;
  mas : Tmas;

procedure nuskaitymas (var s1, s2 : longint);
var
  f : Text;
begin
  assign (f, 'fracdec.in');
  reset (f);
  readln (f, s1, s2);
  close (f)
end;

function per (sk, ilg : longint; var liek : Tliek) : longint;
var
  pg, ck : longint;
begin
  pg := 0;
  for ck := 1 to ilg do
  if liek [ck] = sk then
  begin
    pg := ck;
    break
  end;
  per := pg
end;

procedure varyk (s1, s2 : longint; var ilg, T : longint; var mas : Tmas);
var
  pg, l : longint;
  liek : Tliek;
begin
  T := 0;
  ilg := 0;
  l := 0;
  while (T = 0) and (s1 <> 0) do
  begin
    if s1 < s2 then s1 := s1 * 10;
    while s1 < s2 do
    begin
      s1 := s1 * 10;
      inc (ilg);
      mas [ilg] := 0
    end;
    T := per (s1, l, liek);
    if T > 0 then continue;
    inc (l);
    liek [l] := s1;
    inc (ilg);
    mas [ilg] := s1 div s2;
    s1 := s1 mod s2
  end;

  if t = 0 then exit;
  pg := 0;
  while mas [T + pg] = 0 do inc (pg);
  while (mas [ilg] = 0) and (pg > 0) do
  begin
    dec (ilg);
    dec (pg)
  end
end;

function skaic (vnt : integer) : integer;
var
  pg : integer;
begin
  if vnt = 0 then pg := 1
             else pg := 0;
  while vnt <> 0 do
  begin
    vnt := vnt div 10;
    inc (pg)
  end;
  skaic := pg
end;

procedure rasyk (vnt : integer; var mas : Tmas; ilg, T : longint);
var
  f : Text;
  ck, pz : longint;
begin
  assign (f, 'fracdec.out');
  rewrite (f);
  write (f, vnt, '.');
  pz := skaic (vnt) + 1;
  if ilg <> 0 then
  begin
    if T <> 0 then
    begin
      for ck := 1 to T - 1 do
      begin
        inc (pz);
        write (f, mas [ck]);
        if pz = 76 then
        begin
          writeln (f);
          pz := 0
        end
      end;
      inc (pz);
      write (f, '(');
      if pz = 76 then
      begin
        writeln (f);
        pz := 0
      end;
      for ck := t to ilg do
      begin
        inc (pz);
        write (f, mas [ck]);
        if pz = 76 then
        begin
          writeln (f);
          pz := 0
        end
      end;
      write (f, ')')
    end
    else
    for ck := 1 to ilg do
    begin
      inc (pz);
      write (f, mas [ck]);
      if pz = 76 then
      begin
        writeln (f);
        pz := 0
      end
    end
  end
  else write (f, '0');
  writeln (f);
  close (f)
end;


begin
  nuskaitymas (s1, s2);
  vnt := s1 div s2;
  s1 := s1 mod s2;
  varyk (s1, s2, ilg, T, mas);
  rasyk (vnt, mas, ilg, T)
end.
