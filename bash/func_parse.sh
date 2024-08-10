#!/bin/bash

# Переменная для хранения результата поиска
found=false

# Проверка, был ли указан путь к файлу
if [ $# -ne 1 ]; then
    echo "Usage: $0 <path_to_file>"
    exit 1
fi

# Проверка существования файла
if [ ! -f "$1" ]; then
    echo "File '$1' does not exist or is not a regular file"
    exit 1
fi

# Поиск функции в файле
grep -q 'InternetReadFile' "$1"
grep -q 'HttpQueryInfoA' "$1"

# Если функция найдена, устанавливаем переменную в true
if [[ $? -eq 0 ]]; then
    echo "Found '2 func' in file $1"
    found=true
fi

# Вывод сообщения о результате поиска
if $found; then
    echo "Function found in file"
else
    echo "Function not found in file"
fi
