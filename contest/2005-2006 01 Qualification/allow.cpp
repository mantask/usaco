/*
PROB: allow
LANG: C++
*/

#include <fstream>
#include <cstdlib>

using namespace std;

struct Coin {
	long value, count;
} coins[20];
long sum, totalCoins;
long weeks;

void Read()
{
	ifstream f("allow.in");
	f >> totalCoins >> sum;
	for (int ck = 0; ck < totalCoins; ck++)
		f >> coins[ck].value >> coins[ck].count;
	f.close();	
}

void Write()
{
	ofstream f("allow.out");
	f << weeks << endl;
	f.close();
}

int cmpReverse(const void* a, const void* b)
{
	return ((Coin*)b)->value - ((Coin*)a)->value;
}

inline long min(long a, long b)
{
	return (a < b) ? a : b;
}

void Go(long sum, int depth)
{
	if (depth == totalCoins)
	{
		for (int ck = totalCoins - 1; ck >= 0; ck--)
			if (coins[ck].count != 0)
			{
				coins[ck].count--;
				break;
			}
		return;
	}

	long count = min(sum / coins[depth].value, coins[depth].count);
	coins[depth].count -= count;
	long left = sum - count * coins[depth].value;

	Go(left, depth + 1);
}

void Do()
{
	qsort(coins, totalCoins, sizeof(Coin), cmpReverse);

	// remove coins with greater value than needed per week
	int from = 0;
	while (from < totalCoins && coins[from].value >= sum)
	{
		weeks += coins[from].count;
		coins[from].count = 0;
		from++;
	}

	// count for multiple weeks at once
	// repeat this procedure, while nothing is left
	// count adds to weeks if at the end everyting is ok
	if (from < totalCoins)
		Go(sum, from);
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}

