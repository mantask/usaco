{
ID: vkanapo001
PROG: namenum
}

Program NAMENUM;

Type
  Tkl = array [2 .. 9] of set of char;
  Tsk = array [1 .. 12] of 2 .. 9;

var
  sk : Tsk;
  ilg : byte;
  Fin, Fout : text;
  eil : string;
  kl : Tkl;
  yra : boolean;

procedure nuskaitymas (var ilg : byte; var sk : Tsk);
var
  f : Text;
  c : char;
begin
  ilg := 0;
  assign (f, 'namenum.in');
  reset (f);
  while not eoln (f) do
  begin
    inc (ilg);
    read (f, c);
    sk [ilg] := ord (c) - 48
  end;
  close (f)
end;

function gerai (eil : string) : boolean;
var
  ok : boolean;
  ck : byte;
begin
  ok := true;
  if length (eil) <> ilg then ok := false;
  if ok then
  for ck := 1 to ilg do
  if not (eil [ck] in kl [sk [ck]]) then
  begin
    ok := false;
    break
  end;
  gerai := ok
end;

begin
  kl [2] := ['A', 'B', 'C'];
  kl [3] := ['D', 'E', 'F'];
  kl [4] := ['G', 'H', 'I'];
  kl [5] := ['J', 'K', 'L'];
  kl [6] := ['M', 'N', 'O'];
  kl [7] := ['P', 'R', 'S'];
  kl [8] := ['T', 'U', 'V'];
  kl [9] := ['W', 'X', 'Y'];
  nuskaitymas (ilg, sk);
  assign (fin, 'dict.txt');
  reset (fin);
  assign (fout, 'namenum.out');
  rewrite (fout);
  yra := false;
  while not eof (fin) do
  begin
    readln (fin, eil);
    if gerai (eil) then
    begin
      writeln (fout, eil);
      yra := true;
    end
  end;
  if not yra then writeln (fout, 'NONE');
  close (fin);
  close (fout)
end.
