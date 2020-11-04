#!/bin/bash

filePath=${CHANGELOG_DIR}/changelog.txt

touch "$filePath"

removeLastLine() {
    mv $filePath ${filePath}.tmp #the brackets are there to differentiate the variable from the ".tmp"
    cat ${filePath}.tmp | head -n -1 > $filePath
    rm ${filePath}.tmp
}

#handle undo
oops=false
for i in "$@"
do
case $i in
    --oops|--undo)
    oops=true

    ;;
    --show|--list)
    cat $filePath
    exit 0
    ;;
    --open)
    kate $filePath &
    exit 0
    ;;
    *)
            # unknown option
    ;;
esac
done

if $oops
then

    if [[ $(wc -l < $filePath) -ge 1 ]]
    then

        while [[ $(tail -n1 $filePath) == "" ]]
        do 
            removeLastLine
        
        done
        
        
        lastEntry=
        read -p "Your last line was \"$(tail -n1 $filePath)\". Really delete it? [yN]" delete
        
        case $delete in
            [Yy]* ) removeLastLine;;
            *) echo "Undo Averted." ;;
        esac
        
    else
        echo "$filePath is empty. Nothing to Undo"
    fi

    exit 0
fi


read -p "Is this a [s]ystem change or a [U]ser change?: " changeLevel

case $changeLevel in
    [Ss]* ) changeLevel="System";;
    [Uu]* ) changeLevel="User";;
    *)  changeLevel="User";;
esac


if [[ $changeLevel != "System" ]];
then
    read -p "What piece of software does this change affect? (i.e. Firefox): " affectedSoftware    
fi

read -p "What/Where/Why? " changeMade

read -p "Is there a link to go with this change? " link


DATE=`date '+%Y-%m-%d %H:%M'`

#build entry
entry="[$DATE $changeLevel] "

if [[ $changeLevel != "System" ]];
then
    entry+="{ $affectedSoftware }: "
fi

entry+="$changeMade  <$link>"



if [ -f $filePath ];
then
    echo $entry >> $filePath
else
    echo "changelog file not found. Is the correct environment variable set for this shell? (Check ~/.bash_aliases)"
    echo "Failed to add the following log entry:"
    echo "\"" + $entry + "\""
fi

