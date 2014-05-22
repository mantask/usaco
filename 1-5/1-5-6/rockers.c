/*
ID: vkanapo001
LANG: C
PROG: rockers
*/

#include <stdio.h>

int viso_dainu, viso_cd, max_min;
int mas[20];
int ats;

void
nuskaitymas()
{
	int ck;
	FILE *f = fopen("rockers.in", "r");
	fscanf(f, "%d %d %d", &viso_dainu, &max_min, &viso_cd);
	for (ck = 0; ck < viso_dainu; ck++)
		fscanf(f, "%d", &mas[ck]);
	fclose(f);
}

void
rasymas()
{
	FILE *f = fopen("rockers.out", "w");
	fprintf(f, "%d\n", ats);
	fclose(f);
}

int
lisk(int daina, int cd, int min, int imta)
{
	int pg_imam = -1, pg_neimam;
	
	if (daina < viso_dainu)
	{
		pg_neimam = lisk(daina + 1, cd, min, imta); 
		if (min + mas[daina] <= max_min)
			pg_imam = lisk(daina + 1, cd, min + mas[daina], imta + 1);
		else if (cd + 1 <= viso_cd && mas[daina] <= max_min)
			pg_imam = lisk(daina + 1, cd + 1, mas[daina], imta + 1);

		return (pg_imam > pg_neimam) ? pg_imam : pg_neimam;
	}
	else
		return imta;
}

void
rask()
{
	ats = lisk(0, 1, 0, 0);
}

int
main()
{
	nuskaitymas();
	rask();
	rasymas();
	return 0;
}
