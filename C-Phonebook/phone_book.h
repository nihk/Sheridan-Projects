#define INSERT 0
#define FIND 1
#define LAST_NAME 1
#define FIRST_NAME 2
#define PHONE_NUMBER 3

// Struct definitions
typedef struct {
	char *lastName;
	char *firstName;
	long long phoneNumber;
} PhoneRecordType, *PhoneRecord;

typedef struct {
	int maxSize;
	int length;
	PhoneRecord *records;
} PhoneBookType, *PhoneBook;

// Function prototypes
PhoneRecord makePhoneRecord(char *lastName, char *firstName, long long phoneNumber);
PhoneBook initPhoneBook(int initialSize);
void tryResize(PhoneBook phoneBook);
void resize(PhoneBook phoneBook);
int add(PhoneBook phoneBook, PhoneRecord record);
void insert(PhoneBook phoneBook, PhoneRecord record, int index);
void append(PhoneBook phoneBook, PhoneRecord record);
int remove_(PhoneBook phoneBook, PhoneRecord record);
int removeAt(PhoneBook phoneBook, int index);
int removeLast(PhoneBook phoneBook);
void clear(PhoneBook phoneBook);
void destroy(PhoneBook phoneBook);
int isEmpty(PhoneBook phoneBook);
int binarySearch(PhoneBook phoneBook, PhoneRecord record, int searchType);
int sequentialSearch(PhoneBook phoneBook, void *item, int fieldType);
int lldcmp(long long a, long long b);
int compare(PhoneRecord a, PhoneRecord b);
int customCompare(PhoneRecord a, PhoneRecord b, int field);
int isIndexWithinBounds(PhoneBook phoneBook, int index);
void quicksort(PhoneBook A, int lo, int hi);
int partition(PhoneBook A, int lo, int hi);
void swap(PhoneBook list, int i, int j);
int random(int m, int n);
void copyToLower(char *a, char *b);
void setSortOrder(int a, int b, int c);
void getSortOrder(int *a, int *b, int *c);
int getPrimarySort(void);
