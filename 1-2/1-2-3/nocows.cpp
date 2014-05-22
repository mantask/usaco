/*
ID: vkanapo001
PROB: nocows
LANG: C++
*/

#include <cstdio>

const int MODULUS = 9901;
const int EMPTY = -1;
const int T = 0; // FALSE
const int F = 1; // TRUE

int n, h;
int total;
int m[200][100][2];

void Read()
{
	FILE *f = fopen("nocows.in", "r");
	fscanf(f, "%d %d", &n, &h);
	fclose(f);
}

void Write()
{
	FILE *f = fopen("nocows.out", "w");
	fprintf(f, "%d\n", total);
	fclose(f);
}

int f(int n, int h, int TF) 
{
	if (m[n][h][TF] == EMPTY)
	{
		int sum = 0;
		for (int i = 0; i < n; i++)
		{
			if (TF == F) {
				sum += f(i, h-1, F) * f(n-i-1, h-1, F);
			} else {
				int TF = f(i, h-1, T) * f(n-i-1, h-1, F);
				int FT = f(i, h-1, F) * f(n-i-1, h-1, T);
				int TT = f(i, h-1, T) * f(n-i-1, h-1, T);
				sum += TF + FT - TT;
			}
			sum %= MODULUS;
		}
		m[n][h][TF] = sum;
	}

	return m[n][h][TF];
}

void Do()
{
	// clear array
	for (int i = 0; i < 200; i++)
	{
		for (int j = 0; j < 100; j++)
		{
			m[i][j][T] = EMPTY;
			m[i][j][F] = EMPTY;
		}
	}

	// set presets
	for (int i = 0; i < 200; i++) { 
		m[i][0][T] = 0; 
		m[i][0][F] = 0; 
	}
	for (int j = 0; j < 100; j++) { 
		m[0][j][T] = 0; 
		m[0][j][F] = 1; 
	}
	m[0][0][T] = 1;

	// find aswer
	total = (n % 2 != 0) ? f((n-1)/2, h-1, T) : 0;
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
