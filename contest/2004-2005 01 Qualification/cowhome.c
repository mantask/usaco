/*
PROG: cowhome
LANG: C
*/

#include <stdio.h>

#define oo 1000000000


int m[1000][1000];
int viso;
int ats;

void
nuskaitymas ()
{
	int v1, v2, d, ck, kiek;
	FILE *f = fopen ("cowhome.in", "r");
	fscanf (f, "%d %d", &kiek, &viso);

	for (v1 = 0; v1 < viso; v1++)
		for (v2 = 0; v2 < viso; v2++)
			m[v1][v2] = oo;
	
	for (ck = 0; ck < kiek; ck++)
	{
		fscanf (f, "%d %d %d", &v1, &v2, &d);
		v1--;
		v2--;
		if (m[v1][v2] > d)
		{
			m[v1][v2] = d;
			m[v2][v1] = d;
		}
	}
	fclose (f);
}

void
rasymas ()
{
	FILE *f = fopen ("cowhome.out", "w");
	fprintf (f, "%d\n", ats);
	fclose (f);
}

void
rask ()
{
	long ilg[1000];
	int jau[1000];
	int ck, v;
	int to = viso - 1;
	
	for (ck = 0; ck < 1000; ck++)
	{
		ilg[ck] = oo;
		jau[ck] = 0;
	}

	ilg[0] = 0;
	while (!jau[to])
	{
		v = -1;
		for (ck = 0; ck < viso; ck++)
			if (!jau[ck] && (v == -1 || ilg[ck] < ilg[v]))
				v = ck;
		jau[v] = 1;
		for (ck = 0; ck < viso; ck++)
			if (m[v][ck] && ilg[ck] > ilg[v] + m[v][ck])
				ilg[ck] = ilg[v] + m[v][ck];
	}
	ats = ilg[to];
}

int
main ()
{
	nuskaitymas ();
	rask ();
	rasymas();
	return 0;
}
