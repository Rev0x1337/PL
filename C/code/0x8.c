#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void encryptFile(FILE* inputFile, FILE* outputFile, int key) {
    char ch;
    while ((ch = fgetc(inputFile)) != EOF) {
        ch = ch ^ key; // XOR операция для шифрования
        fputc(ch, outputFile);
    }
}

int main() {
    FILE *inputFile, *outputFile;
    char inputFileName[100], outputFileName[100];
    int key;

    // Генерация случайного ключа
    srand(time(NULL));
    key = rand() % 256; // Генерация случайного числа от 0 до 255

    printf("Сгенерированный ключ: %d\n", key);

    printf("Введите имя файла для шифрования: ");
    scanf("%s", inputFileName);

    printf("Введите имя файла для сохранения зашифрованного содержимого: ");
    scanf("%s", outputFileName);

    inputFile = fopen(inputFileName, "rb");
    if (inputFile == NULL) {
        printf("Ошибка открытия файла для чтения.\n");
        return 1;
    }

    outputFile = fopen(outputFileName, "wb");
    if (outputFile == NULL) {
        printf("Ошибка открытия файла для записи.\n");
        return 1;
    }

    encryptFile(inputFile, outputFile, key);

    printf("Файл успешно зашифрован с использованием случайного ключа.\n");

    fclose(inputFile);
    fclose(outputFile);

    return 0;
}

