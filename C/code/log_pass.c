#include <stdio.h>
#include <string.h>

int main() {
    unsigned char login[11];
    unsigned char password[11];
    unsigned char correct_password[11];

    printf("Enter your login: ");
    scanf("%s", login);

    login[0] = toupper(login[0]);

    sprintf(correct_password, "%cpassw_%d", login[0], strlen(login));


    printf("Enter your password: ");
    fflush(stdin);
    gets(password);


    if (strcmp(password, correct_password) == 0) {
        printf("Password correct!\n");
    } else {
        printf("Incorrect password!\n");
    }

    return 0;
}
