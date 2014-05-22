/*
PROB: waves
LANG: C++
*/

#include <fstream>

using namespace std;


int pTotal, bank1x, bank2x, displayTime;
int px[5], py[5], pTime[5];
char map[9][9];


void Read()
{
	ifstream f("waves.in");
	f >> pTotal >> bank1x >> bank2x >> displayTime;
	for (int ck = 0; ck < pTotal; ck++)
		f >> px[ck] >> py[ck] >> pTime[ck];
	f.close();	
}

void Write()
{
	ofstream f("waves.out");
	for (int cky = 8; cky >= 0; cky--)
	{
		for (int ckx = 0; ckx < 9; ckx++)
			f << map[ckx][cky];
		f << endl;
	}
	f.close();
}

inline void DrawBank(int x)
{
	if (-4 <= x && x <= 4)
		for (int ck = 0; ck < 9; ck++)
			map[x + 4][ck] = 'X';
}

inline void Convert(char &value)
{
	if (value < 0)
		value = 'o';
	else if (value == 0)
		value = '-';
	else 
		value = '*';
}

void Visualize()
{
	for (int ckx = 0; ckx < 9; ckx++)
		for (int cky = 0; cky < 9; cky++)
			Convert(map[ckx][cky]);
		
	DrawBank(bank1x);
	DrawBank(bank2x);
}

inline void Put(int s, int x, int y)
{
	if (-4 <= x && x <= 4 && -4 <= y && y <= 4)
		map[x + 4][y + 4] += s;
}

inline int min(int a, int b)
{
	return (a < b) ? a : b;
}

inline int max(int a, int b)
{
	return (a > b) ? a : b;
}

void Cascade(int s, int &x, int& y, int dx, int dy, int t, int x0)
{
	for (int ck = 0; ck < t; ck++)
	{
		int maxBank = max(bank1x, bank2x);
		int minBank = min(bank1x, bank2x);
		
		if (-4 <= y && y <= 4)
		{
			int xx = x;
			while (true)
			{
				if (xx < x0)
				{
					// xx < maxx b < x0
					if (maxBank < x0 && xx <= maxBank)
						xx = maxBank + (maxBank - xx + 1);
					// xx < min b < x0
					else if (minBank < x0 && xx <= minBank)
						xx = minBank + (minBank - xx + 1);
					// xx < x0 < min b or max b < xx < x0
					else
						break;
				}
				else if (x0 < xx)
				{
					// x0 < min b < xx
					if (x0 < minBank && minBank <= xx)
						xx =  minBank - (xx - minBank + 1);
					// x0 < max b < x0
					else if (x0 < maxBank && maxBank <= xx)
						xx = maxBank - (xx - maxBank + 1);
					// max b < x0 < xx or x0 < xx < min b
					else
						break;
				}
				else
					break;
			}
			
			Put(s, xx, y);
		}
		
		x += dx;
		y += dy;
	}
}

void MarkWave(int s, int x, int y, int t)
{
	if (t == 0)
		Put(s, x, y);
	else
	{
		int x0 = x;
		y -= t;
		Cascade(s, x, y, -1, +1, t, x0);
		Cascade(s, x, y, +1, +1, t, x0);
		Cascade(s, x, y, +1, -1, t, x0);
		Cascade(s, x, y, -1, -1, t, x0);
	}
}

void Do()
{
	for (int ckp = 0; ckp < pTotal; ckp++)
		if (displayTime >= pTime[ckp])
		{
			MarkWave(+1, px[ckp], py[ckp], displayTime - pTime[ckp]);
			MarkWave(-1, px[ckp], py[ckp], displayTime - pTime[ckp] - 2);
		}
	Visualize();
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}
