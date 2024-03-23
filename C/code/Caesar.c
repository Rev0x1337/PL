#include <stdio.h>
#include <string.h>
#include <ctype.h> /* isalpha()*/
#include <locale.h>

void caesar(char* str, int key) { /*Функция принимает на вход строку и ключ.*/
    int len = strlen(str); /*Длина строки.*/

    for (int i = 0; i < len; i++) { /*перебирает символы через цикл. Шифруется с учетом положения и регистра ASCII.*/
        if (isalpha(str[i])) { /*если введенный символ - буква, то выполняет действие*/
            int startChar;

            if (isupper(str[i])) /*isupper() - определяет регистр букв.*/
                startChar = 'A';
            else
                startChar = 'a';

            str[i] = ((str[i] - startChar + key) % 26) + startChar; /*взятие остатка от деления на кол-во букв в алфавите(26)
                                                                и вычитание начального кода последовательности - 'A' */
        }
    }
}

int main() {
    char str[100];
    int key;


    setlocale(LC_ALL, "Rus");
    printf("Enter the string: "); 
    fgets(str, sizeof(str), stdin); /*ввод строки*/

    str[strcspn(str, "\n")] = '\0'; /*удаление символа новой строки*/

    printf("Enter offset: "); /*ввод желаемого смещения*/
    scanf("%d", &key);

    caesar(str, key);

    printf("Encrypted string: %s\n", str); /*вывод шифрованной строки*/

    return 0;
}
