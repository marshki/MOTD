#!/bin/bash 
# mjk235 [at] nyu [dot] edu

# Bulk rename of files beginning with x 

# string to find in file name 
find_string="SF2"

# string to replace in file name 
replace_string="SF_spDist1"


string_to_find() {
  read -p "Enter the string you want to find: " 

} 

#string_to_replace() {} 

confirm_change() { 

  read -p "Confirm rename of files from '$find_string' to '$replace_string'(y/n)? " answer 
   
  if [ "$answer" != "${answer#[Yy]}" ] ;then
      printf "%s\n" "Continuing..."
  else
      printf "%s\n" "Exiting." 
      exit 1
  fi
} 

bulk_rename() {
 
  for file in $find_string; do 
    mv "$file" "${file/$find_string/$replace_string}"
  done
} 

# Main 

main() { 
  confirm_change 
  #bulk_rename
} 

main "$@" 

#### One-liners from a terminal: 
#for f in SF_spDist1*; do mv "$f" "${f/SF_spDist1/SF2}";done
#for f in SF2*; do mv "$f" "${f/SF2/SF_spDist1}";done
