{
ID: vkanapo001
PROG: milk3
}

Program MILK3;

type
  Tmas = array [0 .. 20, 0 .. 20] of byte;

var
  A, B, C : byte;
  mas : Tmas;

procedure nuskaitymas (var A, B, C : byte);
var
  f : Text;
begin
  assign (f, 'milk3.in');
  reset (f);
  readln (f, a, b, c);
  close (f)
end;

function min (sk1, sk2 : byte) : byte;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

procedure varyk (aa, bb, cc : byte; var mas : Tmas);
var
  delta : byte;
begin
  if mas [aa, bb] = cc then exit;

  mas [aa, bb] := cc;

  if aa < A then
  begin
    if bb > 0 then
    begin
      delta := min (bb, A - aa);
      varyk (aa + delta, bb - delta, cc, mas)
    end;
    if cc > 0 then
    begin
      delta := min (cc, A - aa);
      varyk (aa + delta, bb, cc - delta, mas)
    end
  end;

  if bb < B then
  begin
    if aa > 0 then
    begin
      delta := min (aa, B - bb);
      varyk (aa - delta, bb + delta, cc, mas)
    end;
    if cc > 0 then
    begin
      delta := min (cc, b - bb);
      varyk (aa, bb + delta, cc - delta, mas)
    end
  end;

  if cc < C then
  begin
    if aa > 0 then
    begin
      delta := min (aa, c - cc);
      varyk (aa - delta, bb, cc + delta, mas)
    end;
    if bb > 0 then
    begin
      delta := min (bb, c - cc);
      varyk (aa, bb - delta, cc + delta, mas)
    end
  end
end;

procedure rasyk (var mas : Tmas);
var
  f : Text;
  ck, pg : byte;
begin
  assign (f, 'milk3.out');
  rewrite (f);
  pg := 100;
  for ck := B downto 0 do
  begin
    if pg <> 100 then write (f, pg, ' ');
    pg := mas [0, ck]
  end;
  writeln (f, pg);
  close (f)
end;

begin
  nuskaitymas (A, b, c);
  fillchar (mas, sizeof (mas), 100);
  varyk (0, 0, C, mas);
  rasyk (mas)
end.
