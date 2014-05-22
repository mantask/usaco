/*
PROG: ombro
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>

#define oo 100000000

int karviu[200], vietu[200];
long g[200][200];
int viso;
long ats;

void
nuskaitymas()
{
	int kiek, ck;
	int v1, v2, sv;
	FILE *f = fopen("ombro.in", "r");
	fscanf(f, "%d %d", &viso, &kiek);
	for (ck = 0; ck < viso; ck++)
		fscanf(f, "%d %d", &karviu[ck], &vietu[ck]);
	for (ck = 0; ck < kiek; ck++)
	{
		fscanf(f, "%d %d %d", &v1, &v2, &sv);
		v1--;
		v2--;
		if (g[v1][v2] == 0 || g[v1][v2] > sv)
		{
			g[v1][v2] = sv;
			g[v2][v1] = sv;
		}			
	}
	fclose(f);
}

void
rasymas()
{
	FILE *f = fopen("ombro.out", "w");
	fprintf(f, "%d\n", ats);
	fclose(f);
}

void
find_closest(int nuo, int *v, int *svoris)
{
	int ats[200];
	int jau[200];
	int pg_v, ck;
	
	for (ck = 0; ck < viso; ck++)
	{
		ats[ck] = +oo;
		jau[ck] = 0;
	}
	ats[nuo] = 0;
	
	for (;;)
	{
		pg_v = -1;
		for (ck = 0; ck < viso; ck++)
			if (!jau[ck] && (pg_v == -1 || ats[ck] < ats[pg_v]))
				pg_v = ck;
			
		jau[pg_v] = 1;
		
		if (karviu[pg_v] < vietu[pg_v])
		{
			*v = pg_v;
			*svoris = ats[pg_v];
			return;
		}
		
		for (ck = 0; ck < viso; ck++)
			if (g[ck][pg_v] && ats[ck] > g[ck][pg_v] + ats[pg_v])
				ats[ck] = g[ck][pg_v] + ats[pg_v];
	}
	
}

void
rask()
{
	long suma_karviu = 0, suma_vietu = 0;
	int ck;
	int buvo = 1;
	int v, pg, svoris;
	
	for (ck = 0; ck < viso; ck++)
	{
		suma_karviu += karviu[ck];
		suma_vietu += vietu[ck];
	}
	
	if (suma_karviu > suma_vietu)
	{
		ats = -1;
		return;
	}
	
	ats = 0;
	while (buvo)
	{
		buvo = 0;
		for (ck = 0; ck < viso; ck++)
		if (karviu[ck] > vietu[ck])
		{
			buvo = 1;
			find_closest(ck, &v, &svoris);
			if (svoris > ats)
				ats = svoris;
			pg = (karviu[ck] - vietu[ck] < vietu[v] - karviu[v]) ? karviu[ck] - vietu[ck] : vietu[v] - karviu[v];
			karviu[ck] -= pg;
			karviu[v] += pg;
		}
	}
}

int
main ()
{
	nuskaitymas();
	rask();
	rasymas();

	return 0;
}
