/*
PROG: jpol
LANG: C
*/

#include <stdio.h>
#include <stdlib.h>


struct el {
	int ind, kiek, gr;
} mas[180];
int viso;

void
nuskaitymas()
{
	int ck;
	FILE *f = fopen("jpol.in", "r");
	fscanf(f, "%d", &viso);
	for (ck=0; ck<viso*3; ck++)
	{
		fscanf(f, "%d", &mas[ck].kiek);
		mas[ck].ind = ck;
	}
	fclose(f);
}

void
rasymas()
{
	int ck;
	FILE *f = fopen("jpol.out", "w");
	for (ck=0; ck<3*viso; ck++)
		fprintf(f, "%d\n", mas[ck].ind);
	fclose(f);
}

int
cmp(const void *sk1, const void *sk2)
{
	struct el *el1 = (struct el*) sk1;
	struct el *el2 = (struct el*) sk2;
	return el1->kiek - el2->kiek;
}

/*
void
rask()
{
	long S=0;
	long m[120000];
	int kiek[120000];
	long ck;
	
	
	qsort(mas, viso*3, sizeof(mas[0]), cmp);
	for (ck=2*viso; ck<3*viso; ck++)
		mas[ck].gr=2;
	
	for (ck=0; ck<viso*2; ck++)
		S+=mas[ck].kiek;
	
	for (ck=0; ck<120000; ck++)
		m[ck]=-1;
	m[0]=0;
	kiek[0]=0;
	
	for (ck=0; ck<viso*2; ck++)
		for (ck1=0; ck1<120000; ck1++)
			if (m[ck]!=-1)
			{
				if (kiek )
				m[ck+mas[ck]]=
			}
}
*/

int
main ()
{
	nuskaitymas();
	qsort(mas, viso*3, sizeof(mas[0]), cmp);
//	rask();
	rasymas();

	return 0;
}
