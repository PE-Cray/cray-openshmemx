#!/bin/bash

# replace all == into - for header
find . -type f -name "shmem*.rst" -print0 | xargs -0 sed -i '' -e 's/=/-/g'

# add proper title to the sections
for file in shmem_*; do sed -i "" "s/Summary/${file%%.*}/g" ${file}; done

# replace second line in all files to create header
for file in shmem_*; do echo $file; sed -i "" "2s/-/=/g" $file; done
