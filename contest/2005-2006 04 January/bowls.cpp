/*
PROB: bowls
LANG: C++
*/

#include <cstdio>
#include <queue>

using namespace std;

int num = 0;
int minFlips;
int fliped[1048576];


void Read()
{
	FILE* f = fopen("bowls.in", "r");
	int c = 1;
	for (int i = 0; i < 20; i++)
	{
		int d;
		fscanf(f, "%d", &d);
		num += c * d;
		c <<= 1;
	}
	fclose(f);
}

void Write()
{
	FILE* f = fopen("bowls.out", "w");
	fprintf(f, "%d\n", minFlips);
	fclose(f);
}

void Do()
{
	// initiate flips
	int flips[20];
	flips[0] = 3;
	flips[1] = 7;
	for (int i = 2; i < 20 - 1; i++) { flips[i] = flips[i - 1] << 1; }
	flips[19] = 0xC0000;
	
	// start BFS
	queue<int> q;
	q.push(num);
	fliped[num] = 1;

	while (!q.empty())
	{
		int n = q.front(); q.pop();
		for (int i = 0; i < 20; i++)
		{
			if ((n & flips[i]) != 0 && fliped[n ^ flips[i]] == 0)
			{
				fliped[n ^ flips[i]] = fliped[n] + 1;
				q.push(n ^ flips[i]);
			}
		}
	}

	minFlips = fliped[0] - 1;
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
