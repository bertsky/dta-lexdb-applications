#!/bin/sh
sqlite3 -list -readonly -noheader ${1:-lexdb.sqlite} <<EOF | uconv -f utf-8 -t utf-8 -x "::nfc;" | grep -v -e '^[[:punct:]]' -e '^[[:digit:][:punct:]]*$' > ${2:-lexdb_${3:-100}.words}
select trim(u) from csv where f > ${3:-100} and p != "\$(" and p != "\$," and p != "\$." and p != "FM.xy" and p != "CARD" and p != "XY";
EOF
