{
ID: vkanapo001
PROG: dualpal
}

Program DUALPAL;

type
  Tmas = array [1 .. 100] of 0 .. 9;

var
  nuo, kiek : longint;

procedure nuskaitymas (var nuo, kiek : longint);
var
  f : text;
begin
  assign (f, 'dualpal.in');
  reset (f);
  readln (f, kiek, nuo);
  close (f)
end;

procedure versk (sk, pagr : longint; var ilg : longint; var mas : Tmas);
begin
  ilg := 0;
  while sk > 0 do
  begin
    inc (ilg);
    mas [ilg] := sk mod pagr;
    sk := sk div pagr
  end
end;

function pal (ilg : Longint; var mas : Tmas) : boolean;
var
  ck : Integer;
begin
  for ck := 1 to ilg div 2 do
  if mas [ck] <> mas [ilg + 1 - ck] then
  begin
    pal := false;
    exit
  end;
  pal := true
end;

procedure varyk (nuo, kiek : longint);
var
  ilg, sk, ck, k : longint;
  f : text;
  mas : Tmas;
begin
  assign (f, 'dualpal.out');
  rewrite (f);

  sk := nuo + 1;
  while kiek > 0 do
  begin
    k := 0;
    for ck := 2 to 10 do
    if k > 1 then break
    else
    begin
      versk (sk, ck, ilg, mas);
      if pal (ilg, mas) then inc (k)
    end;

    if k = 2 then
    begin
      dec (kiek);
      writeln (f, sk)
    end;

    inc (sk)
  end;
  close (f)
end;

begin
  nuskaitymas (nuo, kiek);
  varyk (nuo, kiek)
end.
