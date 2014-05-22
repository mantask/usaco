/*
PROB: skilift
LANG: C++
*/

#include <cstdio>

const int MAX_PLOTS = 5000;
const int oo = 1000000000;

int totalPlots;
int maxLength;
int plots[MAX_PLOTS];
int count[MAX_PLOTS];

void Read()
{
	FILE *f = fopen("skilift.in", "r");
	fscanf(f, "%d %d", &totalPlots, &maxLength);
	for (int i = 0; i < totalPlots; i++)
	{
		fscanf(f, "%d", &plots[i]);
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("skilift.out", "w");
	fprintf(f, "%d\n", count[totalPlots-1]);
	fclose(f);
}

void Do()
{
	for (int i = 0; i < totalPlots; i++)
	{
		count[i] = +oo;
	}

	count[0] = 1;
	for (int i = 0; i < totalPlots; i++)
	{
		double angle = -oo;
		for (int j = 1; j <= maxLength; j++)
		{
			int ii = i + j;
			if (!(ii < totalPlots)) { break; }

			double newAngle = (plots[ii] - plots[i]) / (ii - i);
			if (newAngle >= angle)
			{
				angle = newAngle;
				if (count[ii] > count[i] + 1)
				{
					count[ii] = count[i] + 1;
				}
			}
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
