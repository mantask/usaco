/*
PROB: twalk
LANG: C++
*/

#include <cstdio>

int yy, xx;
char grid[30][30];
char buf[1000];
long total;

void Read()
{
	FILE *f = fopen("twalk.in", "r");
	fscanf(f, "%d %d\n", &yy, &xx);
	for (int y = yy - 1; y >= 0; y--)
	{
		for (int x = 0; x < xx; x++)
			fscanf(f, "%c", &grid[x][y]);
		fscanf(f, "%*c");
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("twalk.out", "w");
	fprintf(f, "%ld\n", total);
	fclose(f);
}

long trace(int x, int y, char* word)
{
	if (*word == '\n')
		return 1;
	
	long sum = 0;
	for (int ckx = x; ckx < xx; ckx++)
		for (int cky = y; cky < yy; cky++)
			if (*word == grid[ckx][cky] && (ckx != x || cky != y))
			{
				sum += trace(ckx, cky, word+1);
			}
	return sum;
}

void Do()
{
	FILE* f = fopen("dict.txt", "r");
	while (!feof(f)) 
	{
		fgets(buf, 1000, f);
		total += trace(0, 0, buf);
	}
	fclose(f);
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}



