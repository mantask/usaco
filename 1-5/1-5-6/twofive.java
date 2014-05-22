/*
ID: vkanapo001
LANG: JAVA
PROG: twofive
*/

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;


public class twofive {
	
	/**
	 * Marks the taken letters
	 */
	static boolean taken[] = new boolean[25+1];
	
	/**
	 * Current actual word. Used for counting words with this prefix.
	 * Last position curWord[25]=0 and servers as a buffer when using
	 * topPositoin and leftPosition for boundary cases
	 */
	static int[] curWord = new int[25+1];
	
	/**
	 * Stores the top neighbor position in the curWord array
	 */
	static int[] topPosition = new int[25]; 

	/**
	 * Stores the left neighbor position in the curWord array
	 */
	static int[] leftPosition = new int[25];
	
	/**
	 * Stores the lengths of each row in the current word.
	 */
	static int[] lengths = new int[5];
	
	/**
	 * Stores pre-computed number or words in each state
	 */
	static long[][][][][] states = new long[6][6][6][6][6];
	
	
	/**
	 * Finds the number of words with known prefix, e.g. ABC*
	 * @param len marks the length of known prefix, e.g. len(ABC*) == 3
	 * @return
	 */
	static long count() {

		// recursively calculate state information if it is not cached
		if (states[lengths[0]][lengths[1]][lengths[2]][lengths[3]][lengths[4]] == -1) {
			
			// pick smallest unused letter
			int letter = -1;
			for (int i = 1; i <= 25; i++) {
				if (!taken[i]) {
					letter = i;
					break;
				}
			}
			
			// not all letters have been used (else we have already pre-computed states[5][5][5][5][5] 

			long count = 0;
			
			// take the letter
			taken[letter] = true;
			
			// try to put current letter at the end of each row
			for (int row = 0; row < 5; row++) {
				
				// calculate neighboring letters
				int topLetter = (row > 0) ? curWord[(row - 1) * 5 + lengths[row]] : 0;
				int leftLetter = (lengths[row] > 0) ? curWord[row * 5 + lengths[row] - 1] : 0;
				
				// if it is possible to add letter here
				if (lengths[row] < 5 && (row == 0 || lengths[row-1] > lengths[row]) &&
						topLetter < letter && leftLetter < letter) {
					
					// set the letter and row lengths
					curWord[row * 5 + lengths[row]] = letter;
					lengths[row]++;
					
					// count recursively
					count += count();
					
					// remove row lengths. no need to reset the letter
					lengths[row]--;
				}
			}
			
			// release letter
			taken[letter] = false;
			
			// store the count of words in the cache
			states[lengths[0]][lengths[1]][lengths[2]][lengths[3]][lengths[4]] = count;
		}

		// return state information from the cache
		return states[lengths[0]][lengths[1]][lengths[2]][lengths[3]][lengths[4]];
	}
	
	/**
	 * Gets the number of the word in the dictionary
	 * @param word the word of length=25
	 * @return
	 */
	public static long getNumber(String word) {

		initialize();
		long number = 0;
		
		// iterate from the second letter
		for (int pos = 0; pos < 25; pos++) {

			// pick the actual letter
			int actualLetter = word.charAt(pos) - 'A' + 1;
			
			// pick the top and left letters
			int topLetter = curWord[topPosition[pos]];
			int leftLetter = curWord[leftPosition[pos]];
			
			// pick the interval
			int letterMin = Math.max(topLetter, leftLetter) + 1;

			// try all smaller letters in current position, which are free and can be added
			for (int letter = letterMin; letter < actualLetter; letter++) {
				if (!taken[letter]) {
					
					// add it
					taken[letter] = true;
					curWord[pos] = letter;
					lengths[pos / 5]++;
					
					// count the number of such words
					clearStates();
					number += count();
					
					// remove it
					taken[letter] = false;
					lengths[pos / 5]--;
				}
			}

			// remember the actual letter and proceed with the next position
			curWord[pos] = actualLetter;
			taken[actualLetter] = true;
			lengths[pos / 5]++;
		}
		
		return number + 1;
	}
	
	public static String getWord(long number) {
		// initialize
		initialize();
		
		long count = 0;
		
		// the words starts with a letter 'A'
		taken[1] = true;
		curWord[0] = 1;
		lengths[0] = 1;

		// iterate from the second letter
		for (int pos = 1; pos < 25; pos++) {

			// pick the top and left letters
			int topLetter = curWord[topPosition[pos]];
			int leftLetter = curWord[leftPosition[pos]];
			
			// try all possible letters in current position
			int letter = Math.max(topLetter, leftLetter) + 1;
			while (count < number) {
				if (!taken[letter]) {
					
					// add it
					taken[letter] = true;
					curWord[pos] = letter;
					lengths[pos / 5]++;
					
					// count the number of such words
					clearStates();
					long curCount = count();
					
					// check if we have not yet found a letter
					if (number <= count + curCount) {
						break;
					}
					
					// add the number of occurrences
					count += curCount;
					
					// remove it
					taken[letter] = false;
					lengths[pos / 5]--;
				}
				letter++;
			}
		}
		
		
		// reconstruct a string from curWord array
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < 25; i++) {
			sb.append((char) (curWord[i] + 'A' - 1));
		}
		return sb.toString();
	}
	
	/**
	 * Clears the taken array (sets all values to FALSE) and 
	 * lengths array (sets all to 0)
	 */
	static void initialize() {

		// initialize positions for top and left
		for (int pos = 0; pos < 25; pos++) {
			topPosition[pos] = (pos >= 5) ? pos - 5 : 25;
			leftPosition[pos] = (pos % 5 != 0) ? pos - 1 : 25;
		}
		
		for (int i = 1; i <= 25; i++) {
			taken[i] = false;
		}
		for (int i = 0; i < 5; i++) {
			lengths[i] = 0;
		}
	}

	/**
	 * All states are reset
	 */
	static void clearStates() {

		// reset state information
		for (int i1 = 0; i1 < 6; i1++) {
			for (int i2 = 0; i2 < 6; i2++) {
				for (int i3 = 0; i3 < 6; i3++) {
					for (int i4 = 0; i4 < 6; i4++) {
						for (int i5 = 0; i5 < 6; i5++) {
							states[i1][i2][i3][i4][i5] = -1;
						}
					}
				}
			}
		}

		// when all letters are used, we have a single state
		states[5][5][5][5][5] = 1;
	}
	
	/**
	 * Main entry point.
	 * @param args command line arguments. not used.
	 * @throws IOException
	 */
	public static void main(final String[] args) throws IOException {
		
		// read input
		
		BufferedReader reader = new BufferedReader(new FileReader("twofive.in"));
		String line1 = reader.readLine();
		String line2 = reader.readLine();
		reader.close();
		
		// handle calculations 
		
		String output; 
		if ("N".equals(line1)) {
			
			// we are looking for the Nth word in the dictionary
			long number = Long.parseLong(line2);
			output = getWord(number);
			
		} else if ("W".equals(line1)) {
			
			// we are looking for the number of given word in the dictionary 
			long number = getNumber(line2);
			output = Long.toString(number);
			
		} else {
			throw new IOException("Illegal input.");
		}
		
		// write output
		
		PrintWriter writer = new PrintWriter(new BufferedWriter(new FileWriter("twofive.out")));
		writer.println(output);
		writer.close();
	}
}
