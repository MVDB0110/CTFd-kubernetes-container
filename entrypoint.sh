#!/bin/bash

## Variables
[ -z "$FILE" ] && echo $timestamp "$FILE is not defined." || echo $timestamp "$FILE is defined as file."
[ -z "$URI" ] && echo $timestamp "$URI is not defined." || echo $timestamp "$URI is defined as URI."
timestamp=$(date +%s)

## Get file
#Checks
if ! command -v curl &> /dev/null
then
    echo "The curl binary could not be found"
    exit
fi
#Commands
curl -L $URI -o $FILE

## Generate HELM Chart
# Checks
[ -f $FILE ] && echo $timestamp "$FILE exists." || echo $timestamp "$FILE is non existant."
if ! command -v kompose &> /dev/null
then
    echo "The kompose binary could not be found"
    exit
fi

# Commands
kompose convert -f $FILE -c

## Deploy generated HELM Chart
# Checks
if ! command -v helm &> /dev/null
then
    echo "The Helm.sh binary could not be found"
    exit
fi

# Commands
NAME=`echo "$FILE" | cut -d'.' -f1`
helm upgrade --install $NAME $NAME --wait
helm status $NAME -o json > deploy.json