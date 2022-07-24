#!/bin/bash
# Проверка пароля в сервисе https://haveibeenpwned.com/
# API @see https://haveibeenpwned.com/API/v3#PwnedPasswords
#
# Запуск ./check_password.sh password

if (("$#" == 0))
then
    printf 'Enter your password: '
    read -s passin
    echo
else
    passin="$1"
fi

passin=$(echo -n "$passin" | sha1sum)
passin=${passin:0:40}

firstFive=${passin:0:5}
ending=${passin:5}

pwned=$(curl -s "https://api.pwnedpasswords.com/range/$firstFive" | tr -d '\r' | grep -i "$ending")
passwordFound=${pwned##*:}

if [ "$passwordFound" == "" ]
then
    exit 1
else
    printf 'Password is Pwned %d \n' "$passwordFound"
    exit 0
fi