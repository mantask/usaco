/*
PROB: bday
LANG: C++
*/

#include <fstream>

using namespace std;

int weekday;
int year, month, day;
char* weekdays[] = {"monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"};
int months[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

void Read()
{
	ifstream f("bday.in");
	f >> year >> month >> day;
	f.close();	
}

void Write()
{
	ofstream f("bday.out");
	f << weekdays[weekday] << endl;
	f.close();
}

void Do()
{
	long days = 2;
	
	for (int ck = 1800; ck < year; ck++)
		if (ck % 400 == 0)
			days += 366;
		else if (ck % 100 == 0)
			days += 365;
		else if (ck % 4 == 0)
			days += 366;
		else 
			days += 365;

	month--;
	for (int ck = 0; ck < month; ck++)
		days += months[ck];

	if (month > 1 && ((year %  400 == 0) || (year % 100 != 0 && year % 4 == 0)))
		days++;

	days += day - 1;
	
	weekday = days % 7;
}

int main()
{
	Read();
	Do();
	Write();
	
	return 0;
}

