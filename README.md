# FilePile

I got tired of always digging through directories to and then through files
to find the file I was searching for.  FilePile attempts to solve this problem
by storing files in a MongoDB backend, and allowing you to add an arbitrary
number of tags to each file. Then fhen when you go to find a file, you can
filter the files list selecting tags to narrow your search.


## Bugs:
There are still several known bugs or missing features as this is not ready
for release yet.

  1. Default Tags - Adding a file when tags are selected, should add those tags
                    to the file
  2. Server Filtering - Need to figure out how to filter the results in spinejs
                    by passing the tags[] to the files list request
  3. Remove Tag - There is currently no way to remove a tag from a file once
                    added


## License
Copyright (c) 2012 Richard Kent Jordan

MIT License (see the LICENSE file)

