/*
PROB: ddayz
LANG: C++
*/

#include <cstdio>

using namespace std;

int totalSum, totalCost;
char *totalWays;


class BigInt
{
private:
	static const int BASE = 10000;
	static const int MAX_LENGTH = 10;
	int digits[MAX_LENGTH];
	int length;
public:
	BigInt()
	{
		for (int i = 0; i < MAX_LENGTH; i++) { digits[i] = 0; }
		length = 1;
	}

	void Add(BigInt big) 
	{
		length = (length > big.length) ? length : big.length;
		for (int i = 0; i < length; i++)
		{
			digits[i] += big.digits[i];
			digits[i + 1] += digits[i] / BASE;
			digits[i] %= BASE;
		}
		if (digits[length] > 0) { length++; }
	}

	void SetOne()
	{
		digits[0] = 1;
		length = 1;
	}

	bool IsZero()
	{
		return (length == 1 && digits[0] == 0);
	}

	char* ToString()
	{
		char *c = new char[MAX_LENGTH * 4];

		if (IsZero())
		{
			c[0] = '0';
			c[1] = '\0';
			return c;
		}

		for (int i = length - 1; i >= 0; i--) { sprintf(c + ((length - 1 - i) * 4), "%04d", digits[i]); }
		c[length * 4] = '\0';
		while (*c == '0') { c++; }
		return c;
	}
};

void Read()
{
	FILE* f = fopen("ddayz.in", "r");
	fscanf(f, "%d %d", &totalSum, &totalCost);
	fclose(f);
}

void Write()
{
	FILE* f = fopen("ddayz.out", "w");
	fprintf(f, "%s\n", totalWays);
	fclose(f);
}

void Do()
{
	BigInt ways[1001];
	
	ways[0].SetOne();

	// take each possible cost
	for (int cost = 1; cost <= totalCost; cost++)
	{
		// add to already computed sum
		for (int sum = totalSum - cost; sum >= 0; sum--)
		{
			if (!ways[sum].IsZero())
			{
				for (int newSum = sum + cost; newSum <= totalSum; newSum += cost)
				{
					ways[newSum].Add(ways[sum]);
				}
			}
		}
	}

	totalWays = ways[totalSum].ToString();
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
