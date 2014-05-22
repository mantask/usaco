{
ID: vkanapo001
PROG: lamps
}

Program LAMPS;

Type
  Tjung = array [1 .. 100] of integer;
  Telem = array [1 .. 100] of boolean;
  Tmas = array [1 .. 8] of Telem;

var
  skI, skIS, viso, imta : Integer;
  Ijung, ISjung : Tjung;
  mas : Tmas;

procedure nuskaitymas (var viso, imta, ski, skis : integer;
                       var Ijung, isjung : Tjung);
var
  f : Text;
  pg : Integer;
begin
  fillchar (isjung, sizeof (isjung), 0);
  fillchar (ijung, sizeof (ijung), 0);
  assign (f, 'lamps.in');
  reset (f);
  readln (f, viso);
  readln (f, imta);
  skI := 0;
  read (f, pg);
  while pg <> -1 do
  begin
    inc (skI);
    Ijung [skI] := pg;
    read (f, pg)
  end;
  readln (f);
  skIs := 0;
  read (f, pg);
  while pg <> -1 do
  begin
    inc (skIs);
    Isjung [skIs] := pg;
    read (f, pg)
  end;
  close (f)
end;

procedure keisk (ind : Integer; var elem : Telem);
var
  ck : Integer;
begin
  if ind = 1 then
  for ck := 1 to viso do
  elem [ck] := not elem [ck]
  else
  if ind = 2 then
  begin
    ck := 1;
    while ck <= viso do
    begin
      elem [ck] := not elem [ck];
      inc (ck, 2)
    end
  end
  else
  if ind = 3 then
  begin
    ck := 2;
    while ck <= viso do
    begin
      elem [ck] := not elem [ck];
      inc (ck, 2)
    end
  end
  else
  if ind = 4 then
  begin
    ck := 1;
    while ck <= viso do
    begin
      elem [ck] := not elem [ck];
      inc (ck, 3)
    end
  end
end;

procedure formuok (var mas : Tmas);
begin
  keisk (1, mas [1]);
  keisk (1, mas [2]);
  keisk (2, mas [2]);
  keisk (4, mas [2]);
  keisk (2, mas [3]);
  keisk (4, mas [4]);
  keisk (2, mas [5]);
  keisk (3, mas [5]);
  keisk (4, mas [5]);
  keisk (3, mas [6]);
  keisk (1, mas [7]);
  keisk (3, mas [7]);
  keisk (4, mas [7]);
  keisk (1, mas [8]);
  keisk (2, mas [8]);
  keisk (3, mas [8])
end;

function lygink (var elem : Telem) : boolean;
var
  ck : Integer;
begin
  for ck := 1 to skI do
  if not elem [Ijung [ck]] then
  begin
    lygink := false;
    exit
  end;
  for ck := 1 to skIS do
  if elem [ISjung [ck]] then
  begin
    lygink := false;
    exit
  end;
  lygink := true
end;

procedure rasymas (var f : text; var elem : Telem);
var
  ck : Integer;
begin
  for ck := 1 to viso do
  if elem [ck] then write (f, '1')
               else write (f, '0');
  writeln (f)
end;

procedure varyk (var mas : Tmas);
var
  f : text;
  prad : Telem;
  ck : Integer;
  jau : boolean;
begin
  fillchar (mas, sizeof (mas), 1);
  fillchar (prad, sizeof (prad), 1);
  formuok (mas);
  assign (f, 'lamps.out');
  rewrite (f);

  jau := false;

  if imta = 0 then
  begin
    if skIs > 0 then writeln (f, 'IMPOSSIBLE')
                else rasymas (f, prad)
  end;

  if imta = 1 then
  begin
    if lygink (mas [1]) then
    begin
      rasymas (f, mas [1]);
      jau := true
    end;
    if lygink (mas [3]) then
    begin
      rasymas (f, mas [3]);
      jau := true
    end;
    if lygink (mas [4]) then
    begin
      rasymas (f, mas [4]);
      jau := true
    end;
    if lygink (mas [6]) then
    begin
      rasymas (f, mas [6]);
      jau := true
    end;
    if not jau then writeln (f, 'IMPOSSIBLE')
  end;

  if imta > 1 then
  begin
    for ck := 1 to 8 do
    if lygink (mas [ck]) then
    begin
      rasymas (f, mas [ck]);
      jau := true
    end;
    if not jau then writeln (f, 'IMPOSSIBLE')
  end;

  close (f)
end;

begin
  nuskaitymas (viso, imta, ski, skIS, ijung, isjung);
  varyk (mas)
end.

