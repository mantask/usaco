/*
PROB: mqueue
LANG: C++
*/

#include <cstdio>
#include <algorithm>

using namespace std;

const int MAX_COWS = 20000;
const int oo = 1000000000;

struct Cow {
	int a, b;
} cows[MAX_COWS];

int totalCows;
bool cowsTaken[MAX_COWS];
int minTime;

void Read()
{
	FILE *f = fopen("mqueue.in", "r");
	fscanf(f, "%d", &totalCows);
	for (int i = 0; i < totalCows; i++)
	{
		fscanf(f, "%d %d", &cows[i].a, &cows[i].b);
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("mqueue.out", "w");
	fprintf(f, "%d\n", minTime);
	fclose(f);
}

int Space(int x)
{
	// no spaces
	// Max(B_i - A_i), where A_i <= x
	int maxX = -oo;
	int which;
	for (int i = 0; i < totalCows && cows[i].a <= x; i++)
	{
		if (cowsTaken[i]) { continue; }

		if (cows[i].b - cows[i].a > maxX) 
		{ 
			maxX = cows[i].b - cows[i].a; 
			which = i;
		}
	}

	if (maxX != -oo) 
	{ 
		cowsTaken[which] = true;
		return Space(x + maxX);
	}

	// if not succeeded without spaces, fetch one with spaces
	int minSpace = +oo;
	for (int i = 0; i < totalCows; i++)
	{
		if (cowsTaken[i]) { continue; }

		cowsTaken[i] = true;
		int tmpMinSpace = cows[i].a - x + Space(cows[i].b);
		cowsTaken[i] = false;

		if (tmpMinSpace < minSpace) { minSpace = tmpMinSpace; }
	}
	
	return (minSpace == +oo) ? 0 : minSpace;
}

int CmpCowsByA(const void* a, const void* b)
{
	Cow *cowA = (Cow*)a;
	Cow *cowB = (Cow*)b;
	return cowA->a - cowB->a;
}

void Do()
{
	qsort(cows, totalCows, sizeof(cows[0]), CmpCowsByA);

	// minTime = minSpaces + Sum(B_i)
	minTime = Space(0);
	for (int i = 0; i < totalCows; i++)
	{
		minTime += cows[i].b;
	}
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}

