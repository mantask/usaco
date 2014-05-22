/*
PROG: cavecow2
LANG: C
*/

#include <stdio.h>

#define min(a, b) (a < b) ? a : b
#define oo 100000000

long viso;
long mas[16][25000];

long
maz (long nuo, long iki)
{
  long n, sk;

  if (nuo == iki)
    return mas[0][nuo];

  if (nuo > iki)
    return oo;

  for (n = 0, sk = 1; (nuo + (sk << 1) - 1) <= iki; n++, sk <<= 1);

  return min (mas[n][nuo], maz (nuo + sk, iki));
}

void
daryk (void)
{
  long ck, n, sk;

  for (sk = 1, n = 1; sk << 1 <= viso; n++, sk <<= 1)
     for (ck = 0; (ck + sk << 1 - 1) <= viso; ck++)
	mas[n][ck] = min (mas[n-1][ck], mas[n-1][ck+sk]);
}

int
main ()
{
  FILE *fin, *fout;
  long kiek, ck, nuo, iki;
  
  fin = fopen ("cavecow2.in", "r");
  fscanf (fin, "%d %d", &viso, &kiek);
  for (ck = 0; ck < viso; ck++)
    fscanf (fin, "%ld", &mas[0][ck]);
  daryk ();

  fout = fopen ("cavecow2.out", "w");
  for (ck = 0; ck < kiek; ck++) {
    fscanf (fin, "%ld %ld", &nuo, &iki);
    fprintf (fout, "%ld\n", maz (nuo - 1, iki - 1));
  }
  fclose (fin);  
  fclose (fout);
  
  return 0;
}

