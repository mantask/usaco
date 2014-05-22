{
ID: vkanapo001
PROG: latin
}

Program LATIN;

type
  Teil = array [1 .. 7, 1 .. 7] of boolean;
  Tnxt = array [1 .. 7] of integer;

var
  viso : integer;
  nxt : Tnxt;
  ats : int64;

procedure nuskaitymas (var viso : integer);
var
  f : Text;
begin
  assign (f, 'latin.in');
  reset (f);
  readln (f, viso);
  close (f)
end;

procedure israsyk (x, y : integer; var kiek : int64; var xx, yy : teil);
var
  ck : Integer;
  pg : Int64;
begin
  if y = viso then inc (kiek)
  else
  for ck := 1 to viso do
  if not (xx [x, ck] or yy [y, ck]) then
  begin
    xx [x, ck] := true;
    yy [y, ck] := true;
    if (y = 2) and (x + 1 = ck) then
    begin
      pg := 0;
      israsyk (nxt [x], y + x div viso, pg, xx, yy);
      kiek := kiek + pg * (viso - x);
      xx [x, ck] := false;
      yy [y, ck] := false;
      exit
    end
    else israsyk (nxt [x], y + x div viso, kiek, xx, yy);
    xx [x, ck] := false;
    yy [y, ck] := false
  end

end;

function rask (viso : integer) : int64;
var
  xx, yy : Teil;
  pg : int64;
  ck : integer;
begin
  fillchar (xx, sizeof (xx), 0);
  fillchar (yy, sizeof (yy), 0);
  for ck := 1 to viso do
  begin
    xx [ck, ck] := true;
    yy [ck, ck] := true;
    nxt [ck] := ck + 1
  end;
  nxt [viso] := 2;

  pg := 0;
  israsyk (2, 2, pg, xx, yy);

  for ck := 2 to viso - 1 do
  pg := pg * ck;

  rask := pg
end;

procedure rasymas (ats : int64);
var
  f : text;
begin
  assign (f, 'latin.out');
  rewrite (f);
  writeln (F, ats);
  close (f)
end;

begin
  nuskaitymas (viso);
  ats := rask (viso);
  rasymas (ats)
end.
