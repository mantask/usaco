/*
ID: vkanapo001
LANG: C
PROG: theme
*/

#include <stdio.h>

int viso;
int mas[5000];
int ats;

void
nuskaitymas()
{
	int ck;
	FILE *f = fopen("theme.in", "r");
	fscanf(f, "%d", &viso);
	for (ck = 0; ck < viso; ck++)
		fscanf(f, "%d", &mas[ck]);
	fclose(f);
}

void
rasymas()
{
	FILE *f = fopen("theme.out", "w");
	fprintf(f, "%d\n", ats);
	fclose(f);
}

void
rask()
{
	int ck1, ck2;
	int pg1, pg2;
	int ilg;
	int ck;
	
	viso--;
	for (ck = 0; ck < viso; ck++)
		mas[ck] = mas[ck + 1] - mas[ck];
	
	ats = 3;
	for (ck1 = 0; ck1 <= viso - (ats + 1) * 2; ck1++)
		for (ck2 = ck1 + ats + 1; ck2 < viso - ats; ck2++)
			if (mas[ck1] == mas[ck2])
			{
				pg1 = ck1 + 1;
				pg2 = ck2 + 1;
				ilg = 1;
				while (pg1 < ck2 - 1 && pg2 < viso && mas[pg1] == mas[pg2])
				{
					pg1++;
					pg2++;
					ilg++;
				}
				if (ilg > ats)
					ats = ilg;
			}
		
	ats = (ats > 3) ? ats + 1 : 0;
}

int
main()
{
	nuskaitymas();
	rask();
	rasymas();
	return 0;
}

