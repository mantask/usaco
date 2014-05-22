/*
PROB: mooo
LANG: C++
*/

#include <cstdio>

const int MAX_COWS = 50000;

int totalCows;
int h[MAX_COWS];
int v[MAX_COWS];
int maxV;
int sum[MAX_COWS];

void Read()
{
	FILE *f = fopen("mooo.in", "r");
	fscanf(f, "%d", &totalCows);
	for (int i = 0; i < totalCows; i++)
	{
		fscanf(f, "%d %d", &h[i], &v[i]);
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("mooo.out", "w");
	fprintf(f, "%d\n", maxV);
	fclose(f);
}

void Do()
{
	int q[MAX_COWS+1];
	q[0] = -1;

	for (int i = 0; i < totalCows; i++)
	{
		// randam pozicija
		int poz = 0;
		while (q[poz] != -1 && h[q[poz]] >= h[i])
		{
			poz++;
		}

		// tevui pridedam savo verte
		int tevoPoz = poz - 1;
		while (tevoPoz >= 0 && h[q[tevoPoz]] == h[i])
		{
			tevoPoz--;
		}
		if (tevoPoz >= 0)
		{
			sum[q[tevoPoz]] += v[i];
		}

		// vaiku vertes pridedam sau
		for (int j = poz; q[j] != -1; j++)
		{
			sum[i] += v[q[j]];
		}

		// panaikinam vaika ir pridedam save
		q[poz] = i;
		q[poz+1] = -1;
	}

	// randam didziausia 
	maxV = 0;
	for (int i = 0; i < totalCows; i++)
	{
		if (sum[i] > maxV)
		{
			maxV = sum[i];
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
