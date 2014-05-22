/*
PROB: graze1
LANG: C++
*/

#include <cstdio>

using namespace std;

typedef struct { int value, iteration, next; } Cow;

const int MAX_COWS = 10000;

int totalCows;
long totalLocations;
int cowsPoz[MAX_COWS];

int minTime;

void Read()
{
	FILE* f = fopen("graze1.in", "r");
	fscanf(f, "%d %ld\n", &totalCows, &totalLocations);
	for (int i = 0; i < totalCows; i++)
	{
		fscanf(f, "%d\n", &cowsPoz[i]);
	}
	fclose(f);
}

void Write()
{
	FILE* f = fopen("graze1.out", "w");
	fprintf(f, "%d\n", minTime);
	fclose(f);
}

inline void Swap(Cow **a, Cow **b)
{
	Cow *tmp;

	tmp = *a;
	*a = *b;
	*b = tmp;
}

inline int abs(int x)
{
	return (x >= 0) ? x : -x;
}

void Do()
{
	int D = totalLocations / (totalCows - 1);

	Cow *i_1Cows, *iCows;
	i_1Cows = new Cow[totalLocations + 1];
	iCows = new Cow[totalLocations + 1];

	int iCowsFirst = -1; int iCowsLast = -1;
	int i_1CowsFirst = -1; int i_1CowsLast = -1;

	// set start case for first cow
	iCowsFirst = iCowsLast = 0;
	iCows[0].value = cowsPoz[0];
	iCows[0].iteration = 0;
	iCows[0].next = -1;

	// go with other cases
	for (int i = 1; i < totalCows; i++)
	{
		// swap i-1(st) and i(th) cows
		Swap(&iCows, &i_1Cows);
		i_1CowsFirst = iCowsFirst;
		i_1CowsLast = iCowsLast;

		// clear i(th) cow's posible positions
		iCowsFirst = -1;
		iCowsLast = -1;

		// with each possible position for i-1(st) cow find all possible best positions for i(th) cow
		for (int j = i_1CowsFirst; j != -1; j = i_1Cows[j].next)
		{
			int pos = j;
			int f = i_1Cows[j].value;
			
			// we try j+D and j+D+1
			for (int newPos = pos + D; newPos <= pos + D + 1; newPos++)
			{
				int newValue = f + abs(newPos - cowsPoz[i]);

				if (newPos <= totalLocations && (iCows[newPos].iteration < i || iCows[newPos].value > newValue))
				{
					iCows[newPos].value = newValue;
					iCows[newPos].iteration = i;
					iCows[newPos].next = -1;

					if (iCowsFirst == -1)
					{
						iCowsFirst = iCowsLast = newPos;
					}
					else
					{
						iCows[iCowsLast].next = newPos;
						iCowsLast = newPos;
					}
				}
			}

		}
	
	}
	
	minTime = iCows[totalLocations].value;
	
	delete [] iCows;
	delete [] i_1Cows;
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
