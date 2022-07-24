#!/bin/bash
# Проверка email в сервисе https://haveibeenpwned.com/
# Т.к. API платный, то мы имитируем запрос из браузера
#
# Запуск ./check_email.sh example@example.com

if (("$#" == 0))
then
    printf 'Enter your email: '
    read emailin
    echo
else
    emailin="$1"
fi

URL="https://haveibeenpwned.com/unifiedsearch/$emailin"
REFER_URL='https://haveibeenpwned.com'
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
COOKIE="ai_user=bba8p|2022-07-24T18:54:08.366Z; _ga=GA1.2.2061934376.1658688849; _gid=GA1.2.1091934999.1658688849; __stripe_mid=cd5ed416-ebe1-43b7-9bf0-02854ac8eccb6a89eb; __cf_bm=McmTs3QuzjF4zqVtwktyDWuFwVa_KzJ1Ir1LK_AHtf0-1658691593-0-AT5HLzp7pk5Od/EVDvA24krcFfB8G+lT6MJPnkTgdz69HBAL9+d1bAmeVMwO02N4ODRSAD/shXmDd+0W6rXsNkb8eR6eCdlPqMLUwzEl6QSsqiAQPowWwnlP6jtdGWxrGSxKicA+XnmO0rSqiOjblVQJZK1iMXAHEv7EUfGhFlTN; __stripe_sid=af532a96-e302-4b17-b983-28a9ad587679ab7eda; ai_session=2uNSH|1658691593208|1658691846971.72; Searches=3; BreachedSites=666; Pastes=429"
pwned=$(curl -b "$COOKIE" -A "$USER_AGENT" -e "$REFER_URL" -s "$URL" | grep -Po '"Name":".*?"')

if [ "$pwned" == "" ]
then
    exit 1
else
    echo "$pwned"
    exit 0
fi