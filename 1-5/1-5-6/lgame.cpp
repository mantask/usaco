/*
ID: vkanapo001
LANG: C++
PROG: lgame
*/

/*
	1. filter dictionary leaving only words containing valid combination of letters and store length of every word
	2. with each word
		a. go forward searching for a word of appropriate length and appropriate combination of letters
*/

#include <fstream>
#include <string>

using namespace std;


const int MAX_ATS = 100;
const int MAX_DICT = 40000;

long total_dict;		// size of dictionary
char dict[MAX_DICT][8];	// dictionary
int len_dict[MAX_DICT];	// length of words in dictionary
int letters_len;		// number of given letters
char letters[255];		// can use this number of given letters

long total_max_words, max_value;// total words with best value and the value itself
char max_words[MAX_ATS][9];	// words with best value

int value[255];			// values of each letter


// see if it's possible to construct current word from given letters
bool possible(int len, char word[])
{
	bool ok = true;
	for (int ck = 0; ck < len; ck++)
		ok &= (--letters[(int)word[ck]]) >= 0;
	
	for (int ck = 0; ck < len; ck++)
		letters[(int)word[ck]]++;
	
	return ok;
}

void nuskaitymas()
{
	// read given letters
	char letters_str[8];
	ifstream fin("lgame.in");
	fin.getline(letters_str, 8);
	fin.close();

	letters_len = strlen(letters_str);
	for (int ck = 0; ck < letters_len; ck++)
		letters[(int)letters_str[ck]]++;

	// read dictionary
	ifstream fdict("lgame.dict");
	for ( ; ; ) 
	{
		fdict.getline(dict[total_dict], 8);
		if (dict[total_dict][0] == '.')
			break;
		len_dict[total_dict] = strlen(dict[total_dict]);
		if (possible(len_dict[total_dict], dict[total_dict]))
			total_dict++;
	}
	fdict.close();
}

void rasymas()
{
	ofstream fout("lgame.out");
	fout << max_value << endl;
	for (int ck = 0; ck < total_max_words; ck++)
		fout << max_words[ck] << endl;
	fout.close();
}

// if the value is greater than best so far, adds the word to the best list
inline void add_to_max1(int current_value, char *word)
{
	if (current_value >= max_value)
	{
		if (current_value > max_value)
			total_max_words = 0;
		max_value = current_value;
		strcpy(max_words[total_max_words++], word);
	}
}

// if the value is greater than best so far, adds the pair of words to the best list
inline void add_to_max2(int current_value, char *word1, char *word2)
{
	if (current_value >= max_value)
	{
		if (current_value > max_value)
			total_max_words = 0;
		max_value = current_value;
		
		if (strcmp(word1, word2) < 0)
		{
			strcpy(max_words[total_max_words], word1);
			char *tmp = max_words[total_max_words] + strlen(word1);
			*tmp++ = ' ';
			strcpy(tmp, word2);
		}
		else 
		{
			strcpy(max_words[total_max_words], word2);
			char *tmp = max_words[total_max_words] + strlen(word2);
			*tmp++ = ' ';
			strcpy(tmp, word1);
		}
		
		total_max_words++;
	}
}

void rask()
{
	// assign values to letters
	value[(int)' '] = 0;
	value[(int)'e'] = value[(int)'s'] = value[(int)'i'] = 1;
	value[(int)'a'] = value[(int)'r'] = value[(int)'t'] = value[(int)'n'] = 2;
	value[(int)'o'] = value[(int)'l'] = 3;
	value[(int)'u'] = value[(int)'d'] = value[(int)'c'] = 4;
	value[(int)'p'] = value[(int)'y'] = value[(int)'g'] = value[(int)'h'] = value[(int)'m'] = value[(int)'b'] = 5;
	value[(int)'w'] = value[(int)'f'] = value[(int)'k'] = value[(int)'v'] = 6;
	value[(int)'q'] = value[(int)'j'] = value[(int)'z'] = value[(int)'x'] = 7;

	for (int ck1 = 0; ck1 < total_dict; ck1++)
	{
		int sum1 = 0;
		
		for (int ck = 0; ck < len_dict[ck1]; ck++)
		{
			// mark letters of current word as used
			letters[(int)dict[ck1][ck]]--;
			
			// calculate the total value of this word
			sum1 += value[(int)dict[ck1][ck]];
		}
		
		// try to add word to the list of answers
		add_to_max1(sum1, dict[ck1]);
	
		int letters_left = letters_len - len_dict[ck1];
		
		// try to find a pair to the current word in the dict
		if (letters_left > 0)
			for (int ck2 = ck1; ck2 < total_dict; ck2++)
				if (len_dict[ck2] <= letters_left && possible(len_dict[ck2], dict[ck2]))
				{
					int sum2 = 0;
	
					// calculate total value of the second word
					for (int ck = 0; ck < len_dict[ck2]; ck++)
						sum2 += value[(int)dict[ck2][ck]];
					
					// try to add word pair to the list of answers
					add_to_max2(sum1 + sum2, dict[ck1], dict[ck2]);
				}
		
		// unmark letters of current word
		for (int ck = 0; ck < len_dict[ck1]; ck++)
			letters[(int)dict[ck1][ck]]++;
	}
	
	// sort output
	char tmp[9];
	for (int ck1 = total_max_words - 1; ck1 >= 0; ck1--)
		for (int ck2 = 0; ck2 < ck1; ck2++)
			if (strcmp(max_words[ck2], max_words[ck2 + 1]) > 0)
			{
				strcpy(tmp, max_words[ck2]);
				strcpy(max_words[ck2], max_words[ck2+1]);
				strcpy(max_words[ck2+1], tmp);
			}
}

int main()
{
	nuskaitymas();
	rask();
	rasymas();
	return 0;
}
