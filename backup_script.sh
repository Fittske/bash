#!/bin/bash

day=$(date -d "$D" '+%d')
month=$(date -d "$D" '+%m')
year=$(date -d "$D" '+%Y')
day_of_week=$(date -d "$D" '+%a')


echo "Введите АБСОЛЮТНЫЙ путь до места хранения."

read directory

echo "Директория - $directory"

if !command -v zip &> /dev/null
then
    echo "Для запуска данного скрипта необходим архиватор 'zip'. Установите данную утилиту и повторите попытку."
    exit 1
fi

echo "zip установлен"


backup () {
        if [[ ! -e $directory"/"$1 ]]
        then
            echo "Создаем директорию $directory/$1"
            mkdir $directory/$1
        fi
        zip $directory/$1/$(date +"%d-%m-%Y-%H-%M-%S")-$1.zip *.txt
}

clean () {
        echo "Чистка не реализована"

}

#Годовой бэкап
if [[ $day == 31 && $month == "Dec" ]]
then
        clean  "yearly"
        backup "yearly"
#Ежемесячный бэкап
elif [[ $day == 1 ]]
then
        clean  "monthly"
        backup "monthly"
#Еженедельный бэкап
elif [[ $day_of_week == "Sat" ]]
then
        clean  "weekly"
        backup "weekly"
#Eжедневный бэкап
else
        clean  "daily"
        backup "daily"
fi
