/*
Nicholas Rose - Java 2 - Encryption/Decryption Assignment - 2-17-2015
*/

import java.io.*;

public class Decrypt
{
	public static void main(String[] args) throws IOException
	{
		File thatFile = null;
		File thisFile = null;
		try
		{
			thatFile = new File(args[0]);
			thisFile = new File(args[1]);
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
		FileReader fr = new FileReader(thatFile);
		BufferedReader br = new BufferedReader(fr);
		FileWriter fw = new FileWriter(thisFile);
		PrintWriter pw = new PrintWriter(fw);
		String read = null;
		while ((read = br.readLine()) != null)
		{
			writeDecryption(decryptLine(read), pw);
		}
		pw.close();
		br.close();
		thatFile.delete();
		System.out.println("\tDecryption successful.");
	}
	public static String decryptLine(String s)
	{
		char[] charArray = s.toCharArray();
		char[] charArrayDecrypted = new char[charArray.length];
		for (int i = 0; i < charArray.length; i++)
		{
			switch(charArray[i])
			{
				case 'Q': charArrayDecrypted[i] = 'A'; break;
				case 'q': charArrayDecrypted[i] = 'a'; break;
				case 'A': charArrayDecrypted[i] = 'B'; break;
				case 'a': charArrayDecrypted[i] = 'b'; break;
				case 'Z': charArrayDecrypted[i] = 'C'; break;
				case 'z': charArrayDecrypted[i] = 'c'; break;
				case 'X': charArrayDecrypted[i] = 'D'; break;
				case 'x': charArrayDecrypted[i] = 'd'; break;
				case 'S': charArrayDecrypted[i] = 'E'; break;
				case 's': charArrayDecrypted[i] = 'e'; break;
				case 'W': charArrayDecrypted[i] = 'F'; break;
				case 'w': charArrayDecrypted[i] = 'f'; break;
				case 'E': charArrayDecrypted[i] = 'G'; break;
				case 'e': charArrayDecrypted[i] = 'g'; break;
				case 'D': charArrayDecrypted[i] = 'H'; break;
				case 'd': charArrayDecrypted[i] = 'h'; break;
				case 'C': charArrayDecrypted[i] = 'I'; break;
				case 'c': charArrayDecrypted[i] = 'i'; break;
				case 'V': charArrayDecrypted[i] = 'J'; break;
				case 'v': charArrayDecrypted[i] = 'j'; break;
				case 'F': charArrayDecrypted[i] = 'K'; break;
				case 'f': charArrayDecrypted[i] = 'k'; break;
				case 'R': charArrayDecrypted[i] = 'L'; break;
				case 'r': charArrayDecrypted[i] = 'l'; break;
				case 'T': charArrayDecrypted[i] = 'M'; break;
				case 't': charArrayDecrypted[i] = 'm'; break;
				case 'G': charArrayDecrypted[i] = 'N'; break;
				case 'g': charArrayDecrypted[i] = 'n'; break;
				case 'B': charArrayDecrypted[i] = 'O'; break;
				case 'b': charArrayDecrypted[i] = 'o'; break;
				case 'N': charArrayDecrypted[i] = 'P'; break;
				case 'n': charArrayDecrypted[i] = 'p'; break;
				case 'H': charArrayDecrypted[i] = 'Q'; break;
				case 'h': charArrayDecrypted[i] = 'q'; break;
				case 'Y': charArrayDecrypted[i] = 'R'; break;
				case 'y': charArrayDecrypted[i] = 'r'; break;
				case 'U': charArrayDecrypted[i] = 'S'; break;
				case 'u': charArrayDecrypted[i] = 's'; break;
				case 'J': charArrayDecrypted[i] = 'T'; break;
				case 'j': charArrayDecrypted[i] = 't'; break;
				case 'M': charArrayDecrypted[i] = 'U'; break;
				case 'm': charArrayDecrypted[i] = 'u'; break;
				case 'P': charArrayDecrypted[i] = 'V'; break;
				case 'p': charArrayDecrypted[i] = 'v'; break;
				case 'O': charArrayDecrypted[i] = 'W'; break;
				case 'o': charArrayDecrypted[i] = 'w'; break;
				case 'L': charArrayDecrypted[i] = 'X'; break;
				case 'l': charArrayDecrypted[i] = 'x'; break;
				case 'I': charArrayDecrypted[i] = 'Y'; break;
				case 'i': charArrayDecrypted[i] = 'y'; break;
				case 'K': charArrayDecrypted[i] = 'Z'; break;
				case 'k': charArrayDecrypted[i] = 'z'; break;
				case '3': charArrayDecrypted[i] = '1'; break;
				case '8': charArrayDecrypted[i] = '2'; break;
				case '1': charArrayDecrypted[i] = '3'; break;
				case '6': charArrayDecrypted[i] = '4'; break;
				case '5': charArrayDecrypted[i] = '5'; break;
				case '4': charArrayDecrypted[i] = '6'; break;
				case '7': charArrayDecrypted[i] = '7'; break;
				case '2': charArrayDecrypted[i] = '8'; break;
				case '9': charArrayDecrypted[i] = '9'; break;
				case '0': charArrayDecrypted[i] = '0'; break;
				case '+': charArrayDecrypted[i] = ','; break;
				case '-': charArrayDecrypted[i] = '.'; break;
				case '!': charArrayDecrypted[i] = '?'; break;
				case '\'': charArrayDecrypted[i] = ':'; break;
				case '\"': charArrayDecrypted[i] = ';'; break;
				case ';': charArrayDecrypted[i] = '\"'; break;
				case ':': charArrayDecrypted[i] = '\''; break;
				case '?': charArrayDecrypted[i] = '!'; break;
				case '.': charArrayDecrypted[i] = '-'; break;
				case ',': charArrayDecrypted[i] = '+'; break;
				case ' ': charArrayDecrypted[i] = ' '; break;
				default: charArrayDecrypted[i] = charArray[i];  break;
			}
		}
		String sDecrypted = new String(charArrayDecrypted);
		return sDecrypted;
	}
	public static void writeDecryption(String sDecrypted, PrintWriter pw)
	{
		pw.println(sDecrypted);
	}
}

/*
> java Decrypt
        Please correctly enter all arguments.

> java Decrypt thatFile.txt thisFile.txt test
        Incorrect password. Quitting...

> java Decrypt thatFile.txt thisFile.txt secret
        Decryption successful.
*/