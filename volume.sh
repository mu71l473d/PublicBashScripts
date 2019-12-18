#!/bin/bash

i=$((RANDOM%100+0))
amixer sset 'Master' "$i"%

