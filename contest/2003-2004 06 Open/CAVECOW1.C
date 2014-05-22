/*
PROG: cavecow1
LANG: C
*/

#include <stdio.h>

#define min(a, b) ((a) < (b) ? (a) : (b))
#define max(a, b) ((a) < (b) ? (b) : (a))


int mas[100][100];
int yra[100];
int atst[100];
int jau[100];
int ats, viso;

void
nuskaitymas ()
{
  FILE *f = fopen ("cavecow1.in", "r");
  int kiek1, kiek2, ck, v2, v1, pg;

  fscanf (f, "%d %d %d", &viso, &kiek2, &kiek1);
  for (ck = 0; ck < kiek1; ck++) {
    fscanf (f, "%d", &v1);
    yra[v1-1] = 1;
  }
  for (ck = 0; ck < kiek2; ck++) {
    fscanf (f, "%d %d %d", &v1, &v2, &pg);
    mas[v2-1][v1-1] = mas[v1-1][v2-1] = pg;
  }
  fclose (f);
  
  return;
}

void
rasymas ()
{
  FILE *f = fopen ("cavecow1.out", "w");
  
  fprintf (f, "%d\n", ats);
  fclose (f);
  
  return;
}

void
raskAtst ()
{
  int eil[1000];
  int gal, uod, ck, v, pg;
  
  atst[0] = 10000;
  eil[0] = 0;
  for (gal = 0, uod = 1; gal < uod; gal++) {
    v = eil[gal];
    for (ck = 0; ck < viso; ck++)
      if (mas [v][ck]) {
	pg = min (mas[v][ck], atst[v]);
	if (pg > atst[ck]) {
	  atst[ck] = pg;
	  eil[uod++] = ck;
	}
      }
  }
  
  return;
}

void
lisk (int v, int ilg)
{
   int ck;
  
   for (ck = 0; ck < viso; ck++)
     if (!jau[ck] && mas[v][ck]) {
       jau[ck] = 1;
       lisk (ck, ilg);
       if (v > 0 && yra[v] && atst[ck] >= ilg + 1) {
	 if (ilg + 1 > ats)
	   ats = ilg + 1;
	 lisk (ck, ilg + 1);
       }
       jau[ck] = 0;
    }
    
   return;
}

int
main ()
{
  nuskaitymas ();
  raskAtst ();
  jau[0] = 1;
  lisk (0, 0);
  if (yra[0])
    ats++;
  rasymas ();

  return 0;
}
