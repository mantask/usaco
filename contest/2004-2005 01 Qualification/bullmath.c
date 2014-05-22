/*
PROG: bullmath
LANG: C
*/

#include <stdio.h>

int sk[1000];
int sk1[1000];
int sk2[1000];
int ilg1 = 0;
int ilg2 = 0;

void
nuskaitymas ()
{
	char c;
	FILE *f = fopen ("bullmath.in", "r");
	for (fscanf (f, "%c", &c); c != '\n'; fscanf (f, "%c", &c))
		sk1[ilg1++] = c - '0';
	for (fscanf (f, "%c", &c); c != '\n'; fscanf (f, "%c", &c))
		sk2[ilg2++] = c - '0';
	fclose (f);
}

void
rasymas ()
{
	int ck;
	FILE *f = fopen ("bullmath.out", "w");
	for (ck = 999; sk[ck] == 0; ck--);
	for ( ; ck >= 0; ck--)
		fprintf (f, "%c", sk[ck] + '0');
	fprintf (f, "\n");
	fclose (f);
}

void
apsuk (int ilg, int m[])
{
	int ck, pg;
	int iki = (ilg - 1) / 2;
	for (ck = 0; ck <= iki; ck++)
	{
		pg = m[ck];
		m[ck] = m[ilg-ck-1];
		m[ilg-ck-1] = pg;
	}
}

void
plius (int nuo, int s)
{
	int pg;
	for ( ; s; nuo++)
	{
		pg = sk[nuo] + s % 10;
		sk[nuo] = pg % 10;
		s = s / 10 + pg / 10;
	}
}

void
daug (int s, int nuo)
{
	int ck;
	int pg = 0;
	for (ck = 0; ck < ilg1; ck++)
	{
		pg += sk1[ck] * s;
		plius (nuo + ck, pg % 10);
		pg /= 10;
	}
	for ( ; pg; ck++)
	{
		plius (nuo+ck, pg % 10);
		pg /= 10;
	}
}

void
daugD ()
{
	int ck;
	for (ck = 0; ck < ilg2; ck++)
		daug (sk2[ck], ck);
}

int
main ()
{
	nuskaitymas ();
	apsuk (ilg1, sk1);
	apsuk (ilg2, sk2);
	daugD ();
	rasymas();
	return 0;
}
