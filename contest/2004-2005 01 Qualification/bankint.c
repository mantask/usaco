/*
PROG: bankint
LANG: C
*/

#include <stdio.h>

long suma;
int pal, metai;

void
nuskaitymas ()
{
	FILE *f = fopen ("bankint.in", "r");
	fscanf (f, "%d %ld %d", &pal, &suma, &metai);
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("bankint.out", "w");
	fprintf (f, "%ld\n", suma);
	fclose (f);
}

void
rask ()
{
	int ck;
	double pg = suma;
	double p = 1.0 + (double) pal / 100;
	for (ck = 0; ck < metai; ck++)
		pg *= p;
	suma = (long) pg;
}

int
main ()
{
	nuskaitymas ();
	rask ();
	rasymas();
	return 0;
}
