#!/bin/bash

export LANG=en_US.UTF-8

files=0
directories=0

tree()
{
	if [ ! -z $1 ]
	then
		cd $1
	fi

	local array=(`ls`)
	local value=${#array[@]}
	local last=0

	for i in "${array[@]}"
	do
	if [ -z $2 ]
	then
		let dept_meter=0
	else
		let dept_meter=$2
	fi

	if [ -z $3 ]
	then
		let last_counter=0
	else
		let last_counter=$3
	fi

	let dm_=$dept_meter-$last_counter

	until [ $dm_ == 0 ]
	do
		printf "\u2502\u00A0\u00A0\u0020"
		let dm_=$dm_-1
	done

	let lc_=$last_counter

	until [ $lc_ == 0 ]
	do
		printf "\u0020\u0020\u0020\u0020"
		let lc_=$lc_-1
	done

	if [ $i == ${array[ $value - 1 ]} ]
	then
		let last=1
		printf "\u2514\u2500\u2500\u0020$i\n"
	else
		printf "\u251c\u2500\u2500\u0020$i\n"
	fi

	if [ ! -f $i ]
	then
		let directories=$directories+1
		if [ $last == 1 ]
		then
			tree $i $(( $dept_meter+1 )) $(( $last_counter+1 ))
		else
			tree $i $(( $dept_meter+1 ))
		fi
	else
		let files=$files+1
	fi
	done
	cd ..
}

if [ -z $1 ]
then
	echo "."
else
	echo "$1"
fi

tree $1

echo
if [ $directories == 1 ]
	then
	last_="$directories directory,"
else
	last_="$directories directories,"
fi

if [ $files == 1 ]
	then
	echo "$last_ $files file"
else
	echo "$last_ $files files"
fi
