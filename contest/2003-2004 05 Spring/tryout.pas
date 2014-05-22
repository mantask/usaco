{
PROG: tryout
LANG: PASCAL
}

Program TRYOUT;

Type
  Tlent = array [1 .. 1000, 1 .. 1000] of record
    ilg, minw, minh, maxh, maxw : longint
  end;
  Tmas = array [1 .. 1000] of record
    w, h : longint
  end;

var
  viso, a, b, c, ats : longint;
  mas : Tmas;

Procedure nuskaitymas (var viso, a, b, c : longint; var mas : TMas);
var
  f : Text;
  ck : longint;
begin
  assign (f, 'tryout.in');
  reset (f);
  readln (f, viso);
  readln (f, a, b, c);
  for ck := 1 to viso do
  readln (f, mas [ck].h, mas[ck].w);
  close (f)
end;

function min (sk1, sk2 : longint) : longint;
begin
  if sk1 < sk2 then min := sk1
               else min := sk2
end;

function max (sk1, sk2 : longint) : longint;
begin
  if sk1 > sk2 then max := sk1
               else max := sk2
end;

function rask (viso, a, b, c : longint; var mas : Tmas) : longint;
var
  ckNUO, ckilg, minh, minw, maxh, maxw : longint;
  lent : ^Tlent;
begin
  new (lent);

  for ckNUO := 1 to viso do
  with lent^ [ckNUO, ckNUO] do
  begin
    ilg := 1;
    maxh := mas [ckNUO].h;
    maxw := mas [ckNUO].w;
    minw := mas [ckNUO].w;
    minh := mas [ckNUO].h
  end;

  for ckILG := 1 to viso - 1 do
  for ckNUO := 1 to viso - ckILG + 1 do
  begin
    minh := min (lent^ [ckNUO, ckNUO + ckILG - 1].minh, lent^ [ckNUO + 1, ckNUO + ckILG].minh);
    maxh := max (lent^ [ckNUO, ckNUO + ckILG - 1].maxh, lent^ [ckNUO + 1, ckNUO + ckILG].maxh);
    minw := min (lent^ [ckNUO, ckNUO + ckILG - 1].minw, lent^ [ckNUO + 1, ckNUO + ckILG].minw);
    maxw := max (lent^ [ckNUO, ckNUO + ckILG - 1].maxw, lent^ [ckNUO + 1, ckNUO + ckILG].maxw);

    if A * (maxh - minh) + B * (maxw - minw) <= C then
    begin
      lent^ [ckNUO, ckNUO + ckILG].ilg := max (lent^ [ckNUO, ckNUO + ckILG - 1].ilg, lent^ [ckNUO + 1, ckNUO + ckILG].ilg) + 1;
      lent^ [ckNUO, ckNUO + ckILG].minw := minw;
      lent^ [ckNUO, ckNUO + ckILG].minh := minh;
      lent^ [ckNUO, ckNUO + ckILG].maxw := maxw;
      lent^ [ckNUO, ckNUO + ckILG].maxh := maxh
    end
    else
    if lent^ [ckNUO, ckNUO + ckILG - 1].ilg > lent^ [ckNUO + 1, ckNUO + ckILG].ilg
    then lent^ [ckNUO, ckNUO + ckILG] := lent^ [ckNUO, ckNUO + ckILG - 1]
    else lent^ [ckNUO, ckNUO + ckILG] := lent^ [ckNUO + 1, ckNUO + ckILG]
  end;

  rask := lent^ [viso, viso].ilg;

  dispose (lent)
end;

procedure rasymas (ats : longint);
var
  f : text;
begin
  assign (f, 'tryout.out');
  rewrite (f);
  writeln (f, ats);
  close (f)
end;

begin
  nuskaitymas (viso, a, b, c, mas);
  ats := rask (viso, a, b, c, mas);
  rasymas (ats)
end.
