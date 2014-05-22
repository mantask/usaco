/*
PROG: aggr
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>

#define min(a,b) (a)<(b)?(a):(b)


long mas[100000];
long viso, karviu;
long ats;

int
cmp(const void *sk1, const void *sk2)
{
	long *s1 = (long *) sk1;
	long *s2 = (long *) sk2;
	return *s1 - *s2;
}

void
nuskaitymas()
{
	long ck;
	FILE *f = fopen("aggr.in", "r");
	fscanf(f, "%ld %ld", &viso, &karviu);
	for (ck=0; ck<viso; ck++)
		fscanf(f, "%ld", &mas[ck]);
	fclose(f);
}

void
rasymas()
{
	FILE *f = fopen("aggr.out", "w");
	fprintf(f, "%ld\n", ats);
	fclose(f);
}

void
rask()
{
	long n=viso-1, k=karviu-2;
	long S[100000];
	long *K_naujas, *K_senas, *tmp;
	long ck_n, ck_k, ck, pg;
	
	qsort(mas, viso, sizeof(mas[0]), cmp);
	
	for (ck_n=0; ck_n<n; ck_n++)
		mas[ck_n]=mas[ck_n+1]-mas[ck_n];
	
	S[0] = mas[0];
	for (ck_n=1; ck_n<n; ck_n++)
		S[ck_n]=S[ck_n-1]+mas[ck_n];
	
	K_naujas = (long *) malloc (10000*sizeof(long));
	K_senas = (long *) malloc (10000*sizeof(long));
	
	for (ck_n=0; ck_n<n; ck_n++)
		K_senas[ck_n]=S[ck_n];

	for (ck_k=1; ck_k<=k; ck_k++)
	{
		for (ck_n=ck_k; ck_n<n; ck_n++)
		{
			K_naujas[ck_n]=-1;
			for (ck=ck_k-1; ck<ck_n; ck++)
			{
				pg = min(K_senas[ck], S[ck_n]-S[ck]);
				if (pg > K_naujas[ck_n])
					K_naujas[ck_n]=pg;
			}
		}

		tmp = K_naujas;
		K_naujas = K_senas;
		K_senas = tmp;
	}
	
	ats = K_senas[n-1];
	
	free(K_naujas);
	free(K_senas);
}

int
main ()
{
	nuskaitymas();
	rask();
	rasymas();

	return 0;
}
