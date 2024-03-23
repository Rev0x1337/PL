#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <locale.h>

void vigenere(char* string, char* key) {
    int stringLen = strlen(string);
    int keyLen = strlen(key);
    char encStr[stringLen];

    for (int i = 0, j = 0; i < stringLen; i++, j++) {
        if (j == keyLen) {
            j = 0;
        }

        char currentStrChar = string[i];
        char currentKeyChar = key[j];

        if (isalpha(currentStrChar)) {
            char mainChar = isupper(currentStrChar) ? 'A' : 'a';
            int strCharIndex = currentStrChar - mainChar;
            int keyCharIndex = toupper(currentKeyChar) - 'A';

            char encChar = (strCharIndex + keyCharIndex) % 26 + mainChar;
            encStr[i] = encChar;
        } else {
            encStr[i] = currentStrChar;
            j--;
        }
    }
    printf("Encrypted string: %s\n", encStr);
}

int main() {
    char str[100];
    char key[100];

    setlocale(LC_ALL, "Rus");
    printf("Enter string to encrypt: ");
    fgets(str, sizeof(str), stdin);

    printf("Enter key: ");
    fgets(key, sizeof(key), stdin);

    str[strcspn(str, "\n")] = '\0';
    key[strcspn(key, "\n")] = '\0';

    vigenere(str, key);

    return 0;
}
