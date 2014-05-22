/*
PROG: elevator
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>


struct Tmas {
	int h, max_h, kiek;
} mas[400];
int viso;
int ats;

void
nuskaitymas()
{
	int ck;
	FILE *f = fopen("elevator.in", "r");
	fscanf(f, "%d", &viso);
	for (ck = 0; ck < viso; ck++)
		fscanf(f, "%d %d %d", &mas[ck].h, &mas[ck].max_h, &mas[ck].kiek);
	fclose(f);
}

void
rasymas()
{
	FILE *f = fopen("elevator.out", "w");
	fprintf(f, "%d\n", ats);
	fclose(f);
}

int
cmp(const void *x, const void *y)
{
	struct Tmas *xx = (struct Tmas *) x;
	struct Tmas *yy = (struct Tmas *) y;
	
	return xx->max_h - yy->max_h;
}

void
rask()
{
	int ck, ck_i;
	int rusis[40001], kiekis[40001];
	
	qsort(mas, viso, sizeof(mas[0]), cmp);
	
	rusis[0] = 0;
	for (ck = 1; ck < 40001; ck++)
		rusis[ck] = -1;
	
	// imam rusis pagal max_h
	for (ck_i = 0; ck_i < viso; ck_i++)
		// su kiekvienu einam per kiekviena langeli ir ji pildom
		for (ck = 0; ck <= mas[ck_i].max_h - mas[ck_i].h; ck++)
			if (rusis[ck] != -1 &&					// jei dar nedeta cia bloko
				rusis[ck + mas[ck_i].h] == -1 && 	// jei uzdejus, negausim jau turimo aukscio
				(rusis[ck] != ck_i || (rusis[ck] == ck_i && kiekis[ck] < mas[ck_i].kiek))) // ir nevirsysim blokeliu kiekio
			{
				rusis[ck + mas[ck_i].h] = ck_i;
				if (rusis[ck] == ck_i)
					kiekis[ck + mas[ck_i].h] = kiekis[ck] + 1;
				else
					kiekis[ck + mas[ck_i].h] = 1;
			}

	for (ats = mas[viso - 1].max_h; rusis[ats] == -1 && ats > 0; ats--);
}

int
main ()
{
	nuskaitymas();
	rask();
	rasymas();

	return 0;
}
