/*
PROB: trt
LANG: C++
*/

#include <cstdio>

const int MAX = 2000;

int value[MAX];
int total;

long sum;


void Read()
{
	FILE *f = fopen("trt.in", "r");
	fscanf(f, "%d\n", &total);
	for (int i = 0; i < total; i++)
	{
		fscanf(f, "%d\n", &value[i]); 
	}
	fclose(f);
}

void Write()
{
	FILE *f = fopen("trt.out", "w");
	fprintf(f, "%d\n", sum);
	fclose(f);
}

inline long Max(long i, long j)
{
	return (i > j) ? i : j;
}

void Do()
{
	//long f[MAX][MAX];

	//for (int i = 0; i < total; i++)
	//{
	//	f[i][i] = Age(i, i) * value[i];
	//}

	//for (int i = 1; i < total; i++)
	//	for (int j = 0; j + i < total; j++)
	//	{
	//		int a1 = j;
	//		int a2 = j + i;
	//		f[a1][a2] = Max(f[a1+1][a2] + value[a1]*Age(a1,a2), 
	//					  f[a1][a2-1] + value[a2]*Age(a1,a2));
	//	}	

	//sum = f[0][total-1];
	
	long *m_1 = new long[total];
	long *m = new long[total];

	for (int i = 0; i < total; i++)	
	{ 
		m[i] = total * value[i];	
	}

	for (int i = total - 1; i > 0; i--)
	{
		// swap arrays
		long *tmp = m_1;
		m_1 = m;
		m = tmp;

		for (int j = 0; j < i; j++)
		{
			m[j] = Max(m_1[j+1] + i*value[j],
					   m_1[j] + i*value[j+(total-i)]);
		}
	}

	sum = m[0];

	delete[] m_1;
	delete[] m;
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
