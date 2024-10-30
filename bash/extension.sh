#!/bin/bash


if [ "$#" -ne 2 ]; then
    echo "Использование: \$0 <папка> <новое_расширение>"
    exit 1
fi


DIRECTORY=$1
NEW_EXTENSION=$2


if [ ! -d "$DIRECTORY" ]; then
    echo "Ошибка: Папка '$DIRECTORY' не существует."
    exit 1
fi

cd "$DIRECTORY"


for file in *; do
    
    if [ -f "$file" ]; then
        
        BASENAME="${file%.*}"
        
        mv "$file" "$BASENAME.$NEW_EXTENSION"
        echo "Изменено: $file -> $BASENAME.$NEW_EXTENSION"
    fi
done

echo "Готово!"
