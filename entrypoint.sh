#!/bin/bash

## Variables
[ -z "$FILE" ] && echo $timestamp "$FILE is not defined." || echo $timestamp "$FILE is defined as file."
[ -z "$ENCODED" ] && echo $timestamp "$ENCODED is not defined." || echo $timestamp "$ENCODED is defined."
timestamp=$(date +%s)

## Convert base64 encoded compose to file
#Commands
echo $ENCODED | base64 --decode > $FILE

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
