{
PROG: wiggle
LANG: PASCAL
}

Program WIGGLE;

var
  f : text;
  daug, ok : boolean;
  sk1, sk2 : Integer;
  viso : longint;
  c : char;

begin
  assign (f, 'wiggle.in');
  reset (f);
  ok := true;

  viso := 1;
  read (f, c);
  sk1 := ord (c) - 48;

  if not eoln (f) then
  begin
    read (f, c);
    sk2 := ord (c) - 48;
    if sk1 = sk2 then ok := false
    else
    begin
      if sk1 > sk2 then daug := true
                   else daug := false;
      inc (viso)
    end;
    sk1 := sk2
  end;

  while (ok) and not eoln (f) do
  begin
    read (f, c);
    sk2 := ord (c) - 48;
    if daug then ok := sk1 < sk2
            else ok := sk1 > sk2;
    if ok then
    begin
      daug := not daug;
      sk1 := sk2;
      inc (viso)
    end
  end;
  close (f);

  assign (f, 'wiggle.out');
  rewrite (f);
  writeln (f, viso);
  close (F)
end.
