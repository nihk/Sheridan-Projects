// phone_book_interface.c provides an interface for the user to
// interact with phone_book.c

#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "phone_book_interface.h"

#define MAX 50
#define CUSTOM 0
#define DEFAULT 1
#define TXT_LEN 4
#define EXIT 9
#define LN "LN"
#define FN "FN"
#define PN "PN"

// Globals
// fileName represents the current phone book file in use
char fileName[MAX];
// used for comparing filenames and appending to filenames. 
// only .txt files are valid for this application
const char txtExtension[MAX] = ".txt";

// Function definitions
void startInterface(void) {
	printf("\n                               Phonebook\n\n");
	printf("                  .-~~~~~~~~~-._       _.-~~~~~~~~~-.\n");
	printf("              __.'              ~.   .~              `.__\n");
	printf("            .'//                  \\./                  \\\\`.\n");
	printf("          .'//                     |                     \\\\`.\n");
	printf("        .'// .-~\"\"\"\"\"\"\"~~~~-._     |     _,-~~~~\"\"\"\"\"\"\"~-. \\\\`. \n");    
	printf("      .'//.-\"                 `-.  |  .-'                 \"-.\\\\`.\n");
	printf("    .'//______.============-..   \\ | /   ..-============.______\\\\`.\n");
	printf("  .'______________________________\\|/______________________________`.\n\n");


	PhoneBook phoneBook = load(DEFAULT);
	mainMenu(phoneBook);
}

// Loads either the default file or a custom user inputted file
PhoneBook load(int loadDefault) {
	FILE *input = loadDefault ? getDefaultFileReader()
							  : getUserInputFileReader();

	PhoneBook phoneBook = parseFile(input);
	fclose(input);	
	printf(">> %s loaded and parsed successfully\n", fileName);

	return phoneBook;
}

FILE *getDefaultFileReader(void) {
	// Set default file path
	strcpy(fileName, "phonebook.txt");
	FILE *input = fopen(fileName, "r");

	// File validation
	if (input == NULL) {
		printf(">> Default file \"%s\" not found\n", fileName);
		// Couldn't find the default file, so prompt the user
		// to provide one
		input = getUserInputFileReader();
	}

	return input;
}

FILE *getUserInputFileReader(void) {
	FILE *input = NULL;
	printf(">> Enter the name of a file to load from\n> ");
	
	// File validation. Only .txt files are accepted
	while (scanf("%s", fileName) != 1
			|| !hasTxtFileExtension(fileName)
			|| (input = fopen(fileName, "r")) == NULL) {
		printf(">> File not found, try again (use .txt files only)\n> ");
	}
	return input;
}

PhoneBook parseFile(FILE *input) {
	// Arbitrary initial size
	PhoneBook phoneBook = initPhoneBook(2);
	char lastName[MAX];
	char firstName[MAX];
	long long phoneNumber;

	// The first line of a phone book file represents the sorting logic
	int a, b, c;
	if (fscanf(input, "%d %d %d", &a, &b, &c) != EOF) {
		setSortOrder(a, b, c);
	} else {
		printf(">> Error reading data from file: no sort order provided\n");
		exit(0);
	}

	while (fscanf(input, "%s %s %lld", lastName, firstName, &phoneNumber) != EOF) {
		PhoneRecord record = makePhoneRecord(lastName, firstName, phoneNumber);
		append(phoneBook, record);
	}

	// The phone book *.txt file(s) contents should always be in sorted order. If they 
	// are ever not expected to be, the phone book structure must be sorted before being
	// used. Uncommenting the line below does that.
	//quicksort(phoneBook, 0, phoneBook->length - 1);

	return phoneBook;
}

void mainMenu(PhoneBook phoneBook) {
	int input;
	do {
		printf("\n    Main menu options\n");
		printf("    1. Add\t\t 4. Display all records\t 7. Sort\n");
		printf("    2. Retrieve\t\t 5. Load new phonebook\t 8. Create new phonebook\n");
		printf("    3. Delete\t\t 6. Save\t\t 9. Exit\n\n");
		printf("> ");
		while (scanf("%d", (&input)) == 0 
				|| input <= 0 || input > EXIT) {
		    while (getchar() != '\n');  // Catch carriage return 
		    printf(">> Invalid input, try again\n") ;
			printf("> ");
		}
		while (getchar() != '\n'); // Catch carriage return
		initiateMenuOption(phoneBook, input);
	} while (input != EXIT);
	printf(">> Goodbye\n");
	destroy(phoneBook);
}

void initiateMenuOption(PhoneBook phoneBook, int option) {
	switch (option) {
		case 1: interfaceAdd(phoneBook); break;
		case 2: interfaceRetrieve(phoneBook); break;
		case 3: interfaceDelete(phoneBook); break;
		case 4: interfaceDisplayRecords(phoneBook); break;
		case 5: interfaceLoadNew(phoneBook); break;
		case 6: interfaceSave(phoneBook); break;
		case 7: interfaceSort(phoneBook); break;
		case 8: interfaceCreateNewPhonebook(phoneBook); break;
		// input == EXIT, or anything else, goes to default
		default: break;
	}
}

PhoneRecord makeRecordFromUserInput(void) {
	char firstName[MAX], lastName[MAX];
	long long phoneNumber;
	promptFirstName(firstName);
	promptLastName(lastName);
	promptPhoneNumber(&phoneNumber);

	return makePhoneRecord(lastName, firstName, phoneNumber);
}

void promptFirstName(char *firstName) {
	printf(">> Enter a first name\n> ");
	scanf("%s", firstName);	
}

void promptLastName(char *lastName) {
	printf(">> Enter a last name\n> ");
	scanf("%s", lastName);
}

void promptPhoneNumber(long long *phoneNumber) {
	printf(">> Enter a phone number\n> ");
	while (scanf("%lld", phoneNumber) == 0) {
	    while (getchar() != '\n');  // Catch carriage return
	    printf(">> Invalid phone number, try a numeric value\n") ;
		printf("> ");
	}
}

void promptFieldCode(char input[]) {
	printf(">> Last name = LN     First name = FN     Phone number = PN\n> ");
	while ((scanf("%s", input) != 1)
			|| (strcmp(input, LN) != 0 
				&& strcmp(input, FN) != 0 
				&& strcmp(input, PN) != 0)) {
		printf(">> Invalid field code, try again\n> ");
	}
}

void promptNewPhoneBookFilename(void) {
	printf(">> Enter a name for the new phonebook\n> ");
	FILE *fp;
	while (1) {
		scanf("%s", fileName);
		if (strlen(fileName) == 0) {
			printf(">> Enter a non-empty filename\n> ");
			continue;
		}

		// If the inputted filename doesn't have .txt at the end, append that to it
		if (!hasTxtFileExtension(fileName)) {
			strcat(fileName, txtExtension);
		} 

		if ((fp = fopen(fileName, "r")) != NULL) {
			printf(">> \"%s\" already exists, enter a different filename\n> ", 
				fileName);
			continue;
		} else {
			fclose(fp);
			return;
		}
	}
}

void interfaceAdd(PhoneBook phoneBook) {
	PhoneRecord record = makeRecordFromUserInput();
	if (add(phoneBook, record)) {
		printf(">> Record added successfully\n");
	} else {
		printf(">> Record already exists\n");
	}
}

void interfaceRetrieve(PhoneBook phoneBook) {
	int foundResults = 0;
	char input[MAX];
	printf(">> Enter a field to search for\n");
	promptFieldCode(input);
	if (strcmp(input, LN) == 0) {
		char lastName[MAX];
		promptLastName(lastName);
		foundResults = sequentialSearch(phoneBook, lastName, LAST_NAME);
	} else if (strcmp(input, FN) == 0) {
		char firstName[MAX];
		promptFirstName(firstName);
		foundResults = sequentialSearch(phoneBook, firstName, FIRST_NAME);
	} else {
		long long phoneNumber;
		promptPhoneNumber(&phoneNumber);
		foundResults = sequentialSearch(phoneBook, &phoneNumber, PHONE_NUMBER);
	}
	if (!foundResults) {
		printf(">> No results matching the given search criterion\n");
	}
}

void interfaceDelete(PhoneBook phoneBook) {
	PhoneRecord record = makeRecordFromUserInput();
	if (remove_(phoneBook, record)) {
		printf(">> Record deleted successfully\n");
	} else {
		printf(">> Record was not found\n");
	}
}

// Purges the current phone book contents and reassigns them
void interfaceLoadNew(PhoneBook phoneBook) {
	clear(phoneBook);
	copyPhoneBook(phoneBook, load(CUSTOM));
}

void interfaceSave(PhoneBook phoneBook) {
	int a = -1, b = -1, c = -1;
	FILE *output = fopen(fileName, "w");
	getSortOrder(&a, &b, &c);
	fprintf(output, "%d %d %d\n", a, b, c);
	
	for (int i = 0; i < phoneBook->length; i++) {
		PhoneRecord record = phoneBook->records[i];
		fprintf(output, "%s %s %lld\n", 
			record->lastName, record->firstName, record->phoneNumber);
	}

	fclose(output);
	printf(">> %s has been saved to successfully\n", fileName);
}

void interfaceSort(PhoneBook phoneBook) {
	char input[MAX], formatter[] = ">> Sorted records by %s\n";
	int currSort = getPrimarySort();
	printf(">> Currently sorting by %s\n", 
		currSort == 1 ? LN : currSort == 2 ? FN : PN);
	printf(">> Enter a column code to sort ascending by\n");
	promptFieldCode(input);

	if (strcmp(input, LN) == 0) {
		setSortOrder(1, 2, 3);
		printf(formatter, LN);
	} else if (strcmp(input, FN) == 0) {
		setSortOrder(2, 1, 3);
		printf(formatter, FN);
	} else {
		setSortOrder(3, 1, 2);
		printf(formatter, PN);
	}

	quicksort(phoneBook, 0, phoneBook->length - 1);
}

void interfaceCreateNewPhonebook(PhoneBook phoneBook) {
	FILE *output;
	char defaultSort[] = "1 2 3";
	
	promptNewPhoneBookFilename();

	// Write the default sort order to a newly created file
	output = fopen(fileName, "w");
	fprintf(output, "%s\n", defaultSort);
	fclose(output);

	// Now read the file for use within the application itself
	clear(phoneBook);
	output = fopen(fileName, "r");
	copyPhoneBook(phoneBook, parseFile(output));

	printf(">> Phonebook \"%s\" created and loaded successfully\n", fileName);
	fclose(output);
}

void interfaceDisplayRecords(PhoneBook phoneBook) {
	printf("\n %-20s %-15s %-15s\n", "Last name", "First name", "Phone number");
	printf(" -------------------------------------------------\n");
	for (int i = 0; i < phoneBook->length; i++) {
		PhoneRecord record = phoneBook->records[i];
		printf(" %-20s %-15s %-15lld\n", 
			record->lastName, record->firstName, record->phoneNumber);
	}
}

void copyPhoneBook(PhoneBook pb1, PhoneBook pb2) {
	pb1->maxSize = pb2->maxSize;
	pb1->records = pb2->records;
	pb1->length = pb2->length;
}

int hasTxtFileExtension(char fileName[]) {
	return strlen(fileName) > TXT_LEN 
		&& strcmp((fileName + strlen(fileName) - TXT_LEN), txtExtension) == 0;
}
