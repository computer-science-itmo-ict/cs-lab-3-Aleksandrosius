#!/bin/bash

export LANG=en_US.UTF-8
h=0
l=0

output () {
      result=""
      if [ "$(ls $1/$2)" ]; then
        local y=($1/$2/*)
	for i in ${!y[@]}; do
          result=$(basename — "${y[i]}")
          if [ $i -lt $(( ${#y[@]} - 1 )) ]; then
            printf "$3├──$result\n" #"├──\u251c\u2500\u2500\u0020"
            if [ -d $1/$2/$result ]; then
              output $1/$2 $result "$3| " #"| \u2502\u00A0\u00A0\u0020"
                h=$(( $h + 1 ))
            else
              l=$(( $l + 1 ))
            fi
          else
            printf "$3└──$result\n" #"└──\u2514\u2500\u2500\u0020"
            if [ -d $1/$2/$result ]; then
              output $1/$2 $result "$3 " #" "
              h=$(( $h + 1 ))
            else
              l=$(( $l + 1 ))
            fi
          fi
        done;
      fi
}

if [ "$1" ]; then
    echo "$1"
    output . $1
else
    echo "."
    output . .
fi

echo
if [ $h -eq 1 ]
then
    echo -n $h "directory, "
else
    echo -n $h "directories, "
fi
if [ $l -eq 1 ]
then
    echo $l "file"
else
    echo $l "files"
fi
