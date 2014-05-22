/*
PROG: middle
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>

int viso;
long m[10000];
long ats;

void
nuskaitymas ()
{
	int ck;
	FILE *f = fopen ("middle.in", "r");
	fscanf (f, "%d", &viso);
	for (ck = 0; ck < viso; ck++)
		fscanf (f, "%ld", &m[ck]); 
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("middle.out", "w");
	fprintf (f, "%ld\n", ats);
	fclose (f);
}

int
cmp (void const *sk1, void const *sk2)
{
	return (*(long*)sk1 - *(long*)sk2);
}

int
main ()
{
	nuskaitymas ();
	qsort (m, viso, sizeof (m[0]), cmp);
	ats = m[viso/2];
	rasymas();
	return 0;
}
