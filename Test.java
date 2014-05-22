import java.io.*;
import java.util.*;


public class Test {

	static final String inputFilename = "test.in";
	static final String outputFilename = "test.out";
	
	static int i1;
	static int i2;
	
	static int sum;
	
	
	static void read() throws IOException {

		// Use BufferedReader rather than RandomAccessFile; it's much faster
		BufferedReader f = new BufferedReader(new FileReader(inputFilename));

		// Use StringTokenizer vs. readLine/split -- lots faster
	    StringTokenizer st = new StringTokenizer(f.readLine());

	    // Get line, break into tokens
		
	    i1 = Integer.parseInt(st.nextToken()); 
		i2 = Integer.parseInt(st.nextToken());
	    
		f.close();
	}
	
	static void write() throws IOException {
		PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(outputFilename)));
	    out.println(sum);
	    out.close();
	}
	
	static void go() {
		sum = i1 + i2;
	}
	
	public static void main(String... args) throws IOException {
	    read();
	    go();
	    write();
	    System.exit(0);
	}

}
