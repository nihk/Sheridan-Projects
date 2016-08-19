// phone_book.c provides all the main functionality for the 
// PhoneBook structure and its PhoneRecord structures therein

#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "phone_book.h"

// Globals representing the three fields of struct PhoneRecord
// Used for custom sorting/searching: see customCompare()
int sortFieldA = 1, sortFieldB = 2, sortFieldC = 3;

// Function definitions
PhoneRecord makePhoneRecord(char *lastName, char *firstName, long long phoneNumber) {
	PhoneRecord record = (PhoneRecord)malloc(sizeof(PhoneRecordType));

	// Adding 1 to strlen to accomodate null terminators
	record->lastName = (char *)malloc((strlen(lastName) + 1) * sizeof(char));
	copyToLower(record->lastName, lastName);
	record->firstName = (char *)malloc((strlen(firstName) + 1) * sizeof(char));
	copyToLower(record->firstName, firstName);
	record->phoneNumber = phoneNumber;

	return record;
}

PhoneBook initPhoneBook(int initialSize) {
	if (initialSize <= 0) {
		printf(">> Initial size must be at least 1\n");
		exit(0);
	}
	PhoneBook phoneBook = (PhoneBook)malloc(sizeof(PhoneBookType));
	PhoneRecord *records = (PhoneRecord *)malloc(initialSize * sizeof(PhoneRecordType));
	phoneBook->records = records;
	phoneBook->maxSize = initialSize;
	phoneBook->length = 0;

	return phoneBook;
}

void tryResize(PhoneBook phoneBook) {
	if (phoneBook->length >= phoneBook->maxSize) {
		resize(phoneBook);
	}
}

// Doubles the memory block size of a phone book's records pointer
void resize(PhoneBook phoneBook) {
	phoneBook->maxSize *= 2;
	phoneBook->records = (PhoneRecord *)realloc(phoneBook->records, 
		phoneBook->maxSize * sizeof(PhoneRecordType));
}

// Adds in sorted order
int add(PhoneBook phoneBook, PhoneRecord record) {
	int index = binarySearch(phoneBook, record, INSERT);

	// When comparing whether the record to be inserted already exists 
	// in the phone book, need to check that the index is within the array's
	// boundaries first, since looking up indices at 0 (when phoneBook->records 
	// is empty) or phoneBook->length will yield unpredictable values
	if (isIndexWithinBounds(phoneBook, index) 
			&& compare(phoneBook->records[index], record) == 0) {
		return 0;
	} else {
		insert(phoneBook, record, index);
		return 1;
	}
}

void insert(PhoneBook phoneBook, PhoneRecord record, int index) {
	if (index > phoneBook->length) {
		printf(">> Index out of bounds\n");
		exit(0);
	}
	tryResize(phoneBook);
	phoneBook->length++;

	for (int i = phoneBook->length - 1; i > index; i--) {
		phoneBook->records[i] = phoneBook->records[i - 1];
	}
	phoneBook->records[index] = record;
}

void append(PhoneBook phoneBook, PhoneRecord record) {
	insert(phoneBook, record, phoneBook->length);
}

int remove_(PhoneBook phoneBook, PhoneRecord record) {
	int index = binarySearch(phoneBook, record, FIND);
	return removeAt(phoneBook, index);
}

int removeAt(PhoneBook phoneBook, int index) {
	if (index == -1) {
		return 0;
	} else {
		PhoneRecord hold = phoneBook->records[index];

		for (int i = index; i < phoneBook->length - 1; i++) {
			phoneBook->records[i] = phoneBook->records[i + 1];
		}
		free(hold->firstName);
		free(hold->lastName);
		free(hold);
		phoneBook->length--;
		return 1;
	}
}

int removeLast(PhoneBook phoneBook) {
	return removeAt(phoneBook, phoneBook->length - 1);
}

void clear(PhoneBook phoneBook) {
	while (!isEmpty(phoneBook)) {
		if (removeLast(phoneBook) == -1) {
			printf(">> Error clearing phone book\n"); 
			exit(0);
		}
	}
}

void destroy(PhoneBook phoneBook) {
	clear(phoneBook);
	free(phoneBook);
}

int isEmpty(PhoneBook phoneBook) {
	return phoneBook->length == 0;
}

int binarySearch(PhoneBook phoneBook, PhoneRecord record, int searchType) {
	int low = 0;
	int high = phoneBook->length - 1;

	while (low <= high) {
		int middle = (low + high) / 2;
		PhoneRecord currRecord = phoneBook->records[middle];
		if (compare(record, currRecord) < 0) {
			high = middle - 1;
		} else if (compare(record, currRecord) > 0) {
			low = middle + 1;
		} else {  // 'record' was found
			return middle;
		}
	}

	// 'record' was not found
	// Return 'low' for inserting, otherwise return -1
	return searchType == INSERT ? low : -1;
}

// Linear search because > 1 matches could be found to a search pattern
int sequentialSearch(PhoneBook phoneBook, void *field, int fieldType) {
	int noResults = 1;
	for (int i = 0; i < phoneBook->length; i++) {
		PhoneRecord record = phoneBook->records[i];
		if ((fieldType == LAST_NAME 
					&& strcmp((char *)field, record->lastName) == 0)
				|| (fieldType == FIRST_NAME
					&& strcmp((char *)field, record->firstName) == 0)
				|| (fieldType == PHONE_NUMBER
					&& *(long long *)field == record->phoneNumber)) {
			if (noResults) {
				printf("\n %-20s %-15s %-15s\n", "Last name", "First name", "Phone number");
				printf(" -------------------------------------------------\n");
				noResults = 0;
			}
			printf(" %-20s %-15s %-15lld\n", 
				record->lastName, record->firstName, record->phoneNumber);
		}
	}
	if (noResults) {
		return 0;
	}
	return 1;
}

int lldcmp(long long a, long long b) {
	return a < b ? -1 : a > b;
}

// By default compares lastName > firstName > phoneNumber
int compare(PhoneRecord a, PhoneRecord b) {
	int cmp = customCompare(a, b, sortFieldA);
	if (cmp != 0) {
		return cmp;
	}

	cmp = customCompare(a, b, sortFieldB);
	if (cmp != 0) {
		return cmp;
	}

	return customCompare(a, b, sortFieldC);
}

int customCompare(PhoneRecord a, PhoneRecord b, int field) {
	switch (field) {
		case 1: return strcmp(a->lastName, b->lastName);
		case 2: return strcmp(a->firstName, b->firstName);
		case 3: return lldcmp(a->phoneNumber, b->phoneNumber);
		default: {
			printf(">> Comparison failed\n");
			exit(0);
		}
	}
}

int isIndexWithinBounds(PhoneBook phoneBook, int index) {
	return index < phoneBook->length && index >= 0;
}

// Sorts phoneBook in ascending order depending on the order provided 
// to the globals sortFieldA, sortFieldB, and sortFieldC
void quicksort(PhoneBook phoneBook, int low, int high) {
	if (low < high) {
		int divisionPoint = partition(phoneBook, low, high);
		quicksort(phoneBook, low, divisionPoint);
		quicksort(phoneBook, divisionPoint + 1, high);
	}
}

int partition(PhoneBook phoneBook, int low, int high) {
	// random pivot to try and avoid worst case O(n^2)
	swap(phoneBook, low, random(low, high));
	PhoneRecord pivot = phoneBook->records[low];
	low--; 
	high++;
	while (low < high) {
		do {
			high--; 
		} while (compare(phoneBook->records[high], pivot) > 0);

		do {
			low++; 
		} while (compare(phoneBook->records[low], pivot) < 0);

		if (low < high) {
			swap(phoneBook, low, high);
		}
	}
	return high;
}

void swap(PhoneBook phoneBook, int i, int j) {
	PhoneRecord temp = phoneBook->records[i];
	phoneBook->records[i] = phoneBook->records[j];
	phoneBook->records[j] = temp;
}

// returns a random i where m <= i <= n
int random(int m, int n) {
	int offset = rand() / (RAND_MAX + 1.0) * (n - m + 1);
	return m + offset;
}

// Ensures that all entries are lower case, preventing duplicate
// entries with different letter cases
void copyToLower(char *a, char *b) {
	while (*b) {
		*(a++) = tolower(*(b++));
	}
	*a = 0;
}

// Called when loading a sort from a file
void setSortOrder(int a, int b, int c) {
	sortFieldA = a;
	sortFieldB = b;
	sortFieldC = c;
}

// Called when saving the current sort to a file
void getSortOrder(int *a, int *b, int *c) {
	*a = sortFieldA;
	*b = sortFieldB;
	*c = sortFieldC;
}

// Called when displaying the current sort
int getPrimarySort(void) {
	return sortFieldA;
}
