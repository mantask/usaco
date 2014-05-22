{
PROG: lock
LANG: PASCAL
}

Program lock;

const
  fname = 'lock';

var
  f : Text;
  ck, ck2, viso, ats, kiek : longint;
  mas : array [1 .. 250000] of record
    x1, x2, y1, y2, gylis : longint
  end;

begin
  ats := 0;
  kiek := 0;
  assign (f, fname + '.in');
  reset (f);
  readln (f, viso);
  for ck := 1 to viso do
  begin
    with mas [ck] do
    readln (f, x1, y1, x2, y2);
    mas [ck].gylis := 1;
    for ck2 := 1 to ck - 1 do
    if (mas [ck2].x1 < mas [ck].x1) and (mas [ck].x2 < mas [ck2].x2) and
       (mas [ck2].y1 < mas [ck].y1) and (mas [ck].y2 < mas [ck2].y2) and
       (mas [ck2].gylis + 1 > mas [ck].gylis)
    then mas [ck].gylis := mas [ck2].gylis + 1;
    if mas [ck].gylis > ats then
    begin
      ats := mas [ck].gylis;
      kiek := 1
    end
    else if mas [ck].gylis = ats then inc (kiek)
  end;
  close (f);

  assign (f, fname + '.out');
  rewrite (f);
  writeln (f, ats, ' ', kiek);
  close (f)
end.
