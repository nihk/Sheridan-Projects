/*
Nicholas Rose - Java 2 - Encryption/Decryption Assignment - 2-17-2015
*/

import java.io.*;

public class Encrypt extends Decrypt
{
	public static void main(String[] args) throws IOException
	{
		File thisFile = null;
		File thatFile = null;
		try
		{
			thisFile = new File(args[0]);
			thatFile = new File(args[1]);
			String password = args[2];
			if (!password.equals("secret"))
			{
				System.out.println("\tIncorrect password. Quitting...");
				System.exit(1);
			}
		}
		catch (ArrayIndexOutOfBoundsException aioobe)
		{
			System.out.println("\tPlease correctly enter all arguments.");
			System.exit(1);
		}
		FileReader fr = new FileReader(thisFile);
		BufferedReader br = new BufferedReader(fr);
		FileWriter fw = new FileWriter(thatFile);
		PrintWriter pw = new PrintWriter(fw);
		String read = null;
		while ((read = br.readLine()) != null)
		{
			writeEncryption(encryptLine(read), pw);
		}
		pw.close();
		br.close();
		thisFile.delete();
		System.out.println("\tEncryption successful.");
	}
	public static String encryptLine(String s)
	{
		char[] charArray = s.toCharArray();
		char[] charArrayEncrypted = new char[charArray.length];
		for (int i = 0; i < charArray.length; i++)
		{
			switch(charArray[i])
			{
				case 'A': charArrayEncrypted[i] = 'Q'; break;
				case 'a': charArrayEncrypted[i] = 'q'; break;
				case 'B': charArrayEncrypted[i] = 'A'; break;
				case 'b': charArrayEncrypted[i] = 'a'; break;
				case 'C': charArrayEncrypted[i] = 'Z'; break;
				case 'c': charArrayEncrypted[i] = 'z'; break;
				case 'D': charArrayEncrypted[i] = 'X'; break;
				case 'd': charArrayEncrypted[i] = 'x'; break;
				case 'E': charArrayEncrypted[i] = 'S'; break;
				case 'e': charArrayEncrypted[i] = 's'; break;
				case 'F': charArrayEncrypted[i] = 'W'; break;
				case 'f': charArrayEncrypted[i] = 'w'; break;
				case 'G': charArrayEncrypted[i] = 'E'; break;
				case 'g': charArrayEncrypted[i] = 'e'; break;
				case 'H': charArrayEncrypted[i] = 'D'; break;
				case 'h': charArrayEncrypted[i] = 'd'; break;
				case 'I': charArrayEncrypted[i] = 'C'; break;
				case 'i': charArrayEncrypted[i] = 'c'; break;
				case 'J': charArrayEncrypted[i] = 'V'; break;
				case 'j': charArrayEncrypted[i] = 'v'; break;
				case 'K': charArrayEncrypted[i] = 'F'; break;
				case 'k': charArrayEncrypted[i] = 'f'; break;
				case 'L': charArrayEncrypted[i] = 'R'; break;
				case 'l': charArrayEncrypted[i] = 'r'; break;
				case 'M': charArrayEncrypted[i] = 'T'; break;
				case 'm': charArrayEncrypted[i] = 't'; break;
				case 'N': charArrayEncrypted[i] = 'G'; break;
				case 'n': charArrayEncrypted[i] = 'g'; break;
				case 'O': charArrayEncrypted[i] = 'B'; break;
				case 'o': charArrayEncrypted[i] = 'b'; break;
				case 'P': charArrayEncrypted[i] = 'N'; break;
				case 'p': charArrayEncrypted[i] = 'n'; break;
				case 'Q': charArrayEncrypted[i] = 'H'; break;
				case 'q': charArrayEncrypted[i] = 'h'; break;
				case 'R': charArrayEncrypted[i] = 'Y'; break;
				case 'r': charArrayEncrypted[i] = 'y'; break;
				case 'S': charArrayEncrypted[i] = 'U'; break;
				case 's': charArrayEncrypted[i] = 'u'; break;
				case 'T': charArrayEncrypted[i] = 'J'; break;
				case 't': charArrayEncrypted[i] = 'j'; break;
				case 'U': charArrayEncrypted[i] = 'M'; break;
				case 'u': charArrayEncrypted[i] = 'm'; break;
				case 'V': charArrayEncrypted[i] = 'P'; break;
				case 'v': charArrayEncrypted[i] = 'p'; break;
				case 'W': charArrayEncrypted[i] = 'O'; break;
				case 'w': charArrayEncrypted[i] = 'o'; break;
				case 'X': charArrayEncrypted[i] = 'L'; break;
				case 'x': charArrayEncrypted[i] = 'l'; break;
				case 'Y': charArrayEncrypted[i] = 'I'; break;
				case 'y': charArrayEncrypted[i] = 'i'; break;
				case 'Z': charArrayEncrypted[i] = 'K'; break;
				case 'z': charArrayEncrypted[i] = 'k'; break;
				case '1': charArrayEncrypted[i] = '3'; break;
				case '2': charArrayEncrypted[i] = '8'; break;
				case '3': charArrayEncrypted[i] = '1'; break;
				case '4': charArrayEncrypted[i] = '6'; break;
				case '5': charArrayEncrypted[i] = '5'; break;
				case '6': charArrayEncrypted[i] = '4'; break;
				case '7': charArrayEncrypted[i] = '7'; break;
				case '8': charArrayEncrypted[i] = '2'; break;
				case '9': charArrayEncrypted[i] = '0'; break;
				case '0': charArrayEncrypted[i] = '9'; break;
				case ',': charArrayEncrypted[i] = '+'; break;
				case '.': charArrayEncrypted[i] = '-'; break;
				case '?': charArrayEncrypted[i] = '!'; break;
				case ':': charArrayEncrypted[i] = '\''; break;
				case ';': charArrayEncrypted[i] = '\"'; break;
				case '\"': charArrayEncrypted[i] = ';'; break;
				case '\'': charArrayEncrypted[i] = ':'; break;
				case '!': charArrayEncrypted[i] = '?'; break;
				case '-': charArrayEncrypted[i] = '.'; break;
				case '+': charArrayEncrypted[i] = ','; break;
				case ' ': charArrayEncrypted[i] = ' '; break;
				default: charArrayEncrypted[i] = charArray[i];  break;
			}
		}
		String sEncrypted = new String(charArrayEncrypted);
		return sEncrypted;
	}
	public static void writeEncryption(String sEncrypted, PrintWriter pw)
	{
		pw.println(sEncrypted);
	}
}

/*
> java Encrypt
        Please correctly enter all arguments.

> java Encrypt thisFile.txt thatFile.txt test
        Incorrect password. Quitting...

> java Encrypt thisFile.txt thatFile.txt secret
        Encryption successful.
*/