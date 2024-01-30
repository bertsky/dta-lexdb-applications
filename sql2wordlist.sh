#!/bin/sh
sqlite3 -column -readonly -noheader ${1:-lexdb.sqlite} <<EOF | grep -v -e '^[[:punct:]]' -e '^[[:digit:][:punct:]]*$' > ${2:-lexdb_${3:-100}.words}
select u from csv where f > ${3:-100} and p != "\$(" and p != "\$," and p != "\$." and p != "FM.xy" and p != "CARD" and p != "XY";
EOF
