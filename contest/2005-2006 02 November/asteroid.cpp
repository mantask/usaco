/*
PROB: asteroid
LANG: C++
*/

#include <cstdio>

int size, total;
bool ast[500][500];
int row[500], col[500];
int shots;

void Read()
{
	FILE *f = fopen("asteroid.in", "r");
	fscanf(f, "%d %d", &size, &total);
	for (int ck = 0; ck < total; ck++)
	{
		int x, y;
		fscanf(f, "%d %d", &y, &x);
		x--; y--;
		row[y]++;
		col[x]++;
		ast[x][y] = true;
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("asteroid.out", "w");
	fprintf(f, "%d\n", shots);
	fclose(f);
}

void Do()
{
	while (true)
	{
		// pick-up the largest row/col (500 op)
		int maxRow = 0;
		int maxCol = 0;
		for (int ck = 1; ck < total; ck++)
		{
			if (row[ck] > row[maxRow])
				maxRow = ck;
			if (col[ck] > col[maxCol])
				maxCol = ck;
		}
		
		// clear all asteroids in row/col
		// decrease corresponding col/row number (500 op)
		if (row[maxRow] > col[maxCol])
		{
			// we are dealing with a ROW
			row[maxRow] = 0;
			for (int ck = 0; ck < size; ck++)
				if (ast[ck][maxRow])
				{
					ast[ck][maxRow] = false;
					col[ck]--;
				}
		}
		else
		{
			// there are no more asteroids left
			if (col[maxCol] == 0)
				break;
			
			// we are dealing with a COLUMN
			col[maxCol] = 0;
			for (int ck = 0; ck < size; ck++)
				if (ast[maxCol][ck])
				{
					ast[maxCol][ck] = false;
					row[ck]--;
				}
		}
		
		// add 1 to shots
		shots++;
	}
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}



