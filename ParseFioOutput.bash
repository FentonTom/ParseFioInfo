#!/bin/bash
## used to parse out the IOPS and bandwidth of the file.
if [ $# -ne 1 ]; then
                    echo $0: "Filename needed"
                                exit 1
fi
File2Check=$1
echo ""
echo $File2Check
## Extract the Random Writes
##
RandRead () {
        grep 'MSG\|IOPS\|read\|write' ${File2Check} | grep -A 3 "write test"$ | grep 'MSG\|IOPS' > TMPFile.del
        awk '{
        if ( $1 == "MSG" )
                        print $5, $6, $7, $8, $9
                else
                                print "-->" $1, $2, $3;
                        }' TMPFile.del
        }


8020Read () {
        grep 'MSG\|IOPS\|read\|write' $File2Check | grep -A 3 "80/20"   | grep 'MSG\|IOPS' > TMPFile.del
        awk '{
        if ( $1 == "MSG" )
                        print $5, $6, $7, $8;
                else if ( $1 == "read:" )
                                print "-->" $1, $2, $3;
                        else if ( $1 == "write:" )
                                        print "-->" $1, $2, $3;
                                }' TMPFile.del
                }

echo ""
echo ""
8020Read
rm TMPFile.del
echo ""
RandRead
rm TMPFile.del
echo ""
