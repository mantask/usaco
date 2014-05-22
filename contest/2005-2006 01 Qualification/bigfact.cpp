/*
PROB: bigfact
LANG: C++
*/

#include <fstream>
#include <math.h>

using namespace std;

bool IsPrime(int number)
{
	if (number % 2 == 0)
		return false;
	int upto = floor(sqrt((double)number));
	for (int ck = 3; ck <= upto; ck = ck + 2)
		if (number % ck == 0)
			return false;
	return true;
}

int main()
{
	int bigNumber, bigPrime = 0;

	int total;
	ifstream fin("bigfact.in");
	fin >> total;
	for (int ck = 0; ck < total; ck++)
	{
		int number;
		fin >> number;
		for (int prime = number; prime > bigPrime; prime--)
			if (number % prime == 0 && IsPrime(prime))
			{
				bigPrime = prime;
				bigNumber = number;
				break;
			}
	}
	fin.close();	
	
	ofstream fout("bigfact.out");
	fout << bigNumber << endl;
	fout.close();

	return 0;
}


