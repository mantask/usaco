/*
PROB: corral
LANG: C++
*/

#include <cstdio>
#include <cstdlib>

using namespace std;

const int oo = 1000000000;

int totalFields;
int minFields;

struct Field {
	int x, y;
} fields[500];

int minEdge = +oo;


void Read()
{
	FILE* f = fopen("corral.in", "r");
	fscanf(f, "%d %d\n", &minFields, &totalFields);
	for (int i = 0; i < totalFields; i++)
	{
		fscanf(f, "%d %d\n", &fields[i].x, &fields[i].y);
	}
	fclose(f);
}

void Write()
{
	FILE* f = fopen("corral.out", "w");
	fprintf(f, "%d\n", minEdge);
	fclose(f);
}

int CmpFields(const void *f1, const void *f2)
{
	Field field1 = *(Field*)f1;
	Field field2 = *(Field*)f2;

	if (field1.x < field2.x) return -1;
	if (field1.y < field2.y) return -1;

	if (field1.x > field2.x) return +1;
	if (field1.y > field2.y) return +1;

	return 0;
}

int FindMinEdge(int startField)
{
	int currentTotalFields = 1;
	int currentEdge = 1;
	int nextField = startField + 1;

	// while our current fields number too small and we still have fields to visit
	while (currentTotalFields < minFields && nextField < totalFields)
	{
		// grow edge
		currentEdge++;

		while (fields[nextField].x < fields[startField].x + currentEdge &&
			   fields[nextField].y < fields[startField].y + currentEdge)
		{
			currentTotalFields++;
			nextField++;
		}
	}
	
	return currentEdge;
}

void Do()
{
	// sort fields
	qsort(fields, totalFields, sizeof(fields[0]), CmpFields);

	// pick each field as a starting point
	for (int i = 0; i < totalFields; i++)
	{
		// find minimum edge
		int currentMinEdge = FindMinEdge(i);
		if (currentMinEdge < minEdge)
		{
			minEdge = currentMinEdge;
		}
	}
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
