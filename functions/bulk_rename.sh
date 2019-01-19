#!/bin/bash 
# Bulk rename of files 
# mjk235 [at] nyu [dot] edu


# string to find in file name 
find_string=""

# string to replace in file name 
replace_string=""

bulk_rename() { 
  for file in $find_string; do 
    mv "$file" "$(file/$find_string/$replace_string}"
  done
} 

#for f in SF_spDist1*; do mv "$f" "${f/SF_spDist1/SF2}";done

#for f in SF2*; do mv "$f" "${f/SF2/SF_spDist1}";done
