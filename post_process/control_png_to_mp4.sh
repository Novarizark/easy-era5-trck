#!/bin/bash

PREFIX_ARR=( "test." )
SUFFIX="png"
STRT_F=0
END_F=24
FRAME_DT=10 # n/100 second

N_FRM=$(( $END_F - $STRT_F ))

SCRIPT_DIR=`pwd`


WRK_DIR=../fig/
cd $WRK_DIR
echo $WRK_DIR

rm -f *noborder*

L_PREFIX=${#PREFIX_ARR[@]}
for((IPRE=0;IPRE<L_PREFIX;IPRE++))
do
    PREFIX=${PREFIX_ARR[$IPRE]}
    b=''
    for((I=$STRT_F;I<=${END_F};I++))
    do
        printf "[%-50s] %d/%d \r" "$b" "$(( $I - $STRT_F ))" "$N_FRM";
        b+='#'
        TFSTMP=`printf "%.4d" $I`
        convert -trim +repage -bordercolor white -background white -flatten ${PREFIX}${TFSTMP}.${SUFFIX} ${PREFIX}noborder.${TFSTMP}.${SUFFIX}
    done
    echo ""
    echo "Convert to mp4..."
    ffmpeg -i SP_Jan16.r.%04d.png -r 15 -vf format=yuv420p out_test.mp4
    #ffmpeg -i SP_Jan16.r.%04d.png -r 15 -b 1M -vf format=yuv420p out_test.mp4
done
