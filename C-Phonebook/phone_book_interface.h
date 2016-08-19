#include "phone_book.h"

// Function prototypes
void startInterface(void);
PhoneBook load(int loadDefault);
FILE *getDefaultFileReader(void);
FILE *getUserInputFileReader(void);
PhoneBook parseFile(FILE *input);
void mainMenu(PhoneBook phoneBook);
void initiateMenuOption(PhoneBook phoneBook, int option);
PhoneRecord makeRecordFromUserInput(void);
void promptFirstName(char *firstName);
void promptLastName(char *lastName);
void promptPhoneNumber(long long *phoneNumber);
void promptFieldCode(char input[]);
void promptNewPhoneBookFilename(void);
void interfaceAdd(PhoneBook phoneBook);
void interfaceRetrieve(PhoneBook phoneBook);
void interfaceDelete(PhoneBook phoneBook);
void interfaceLoadNew(PhoneBook phoneBook);
void interfaceSave(PhoneBook phoneBook);
void interfaceSort(PhoneBook phoneBook);
void interfaceDisplayRecords(PhoneBook phoneBook);
void interfaceCreateNewPhonebook(PhoneBook phoneBook);
void copyPhoneBook(PhoneBook pb1, PhoneBook pb2);
int hasTxtFileExtension(char fileName[]);
