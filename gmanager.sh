#!/bin/bash
#--------------------------------------------------------------------------- 
#             Copyright 2021 ZhishengZeng
#--------------------------------------------------------------------------- 
# Author      : ZhishengZeng
# Date        : 2021-04-25 
#--------------------------------------------------------------------------- 

EXE_PATH=$(pwd)
function CHECK_DIR()
{
    if [ -d $* ] && [ $( ls $* | wc -l ) -gt 0 ]; then
        echo "[gmanager Info] dir exist and not empty: '$*' skiping..." && return 0
    else
        rm -rf $*
        return 1
    fi
}

function RUN()
{
    echo "[gmanager Info] exec command: '$*' ..."
    while [ 0 -eq 0 ]
    do
        $* 
        if [ $? -eq 0 ]; then
            echo "[gmanager Info] exec command successful: '$*' "
            break;
        else
            echo "[gmanager Warning] exec command failed: '$*' retry..." && sleep 1
        fi
    done
}

REPO=$1
temp=${REPO##*/}
REPO_NAME=${temp%%\.*}   

CHECK_DIR $EXE_PATH/$REPO_NAME || RUN git clone --recursive $REPO $EXE_PATH/$REPO_NAME
RUN cd $EXE_PATH/$REPO_NAME
RUN git submodule update --init --recursive
