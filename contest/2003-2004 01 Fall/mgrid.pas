{
PROG: mgrid
LANG: PASCAL
}

Program MGRID;

Type
  Teil = array [1 .. 75] of char;
  Tmas = array [1 .. 10000] of Teil;

var
  xx, yy : integer;
  ats : longint;
  mas : Tmas;
  f : Text;
  dx, dy, ckx, cky : integer;

begin
  assign (f, 'mgrid.in');
  reset (f);
  readln (f, yy, xx);
  dx := 0;
  dy := 0;
  for cky := 1 to yy do
  begin
    for ckx := 1 to xx do
    begin
      read (f, mas [cky, ckx]);
      if dx < ckx then
      begin
        if dx = 0 then inc (dx)
        else
        if mas [cky, ckx] <> mas [cky, ckx - dx] then dx := ckx
      end
    end;
    if dy < cky then
    begin
      if dy = 0 then inc (dy)
      else
      if mas [cky] <> mas [cky - dy] then dy := cky
    end;
    readln (f)
  end;
  close (f);

  ats := dx * dy;
  assign (f, 'mgrid.out');
  rewrite (f);
  writeln (f, ats{, ' ', dx, ' x ', dy});
  close (f)
end.
