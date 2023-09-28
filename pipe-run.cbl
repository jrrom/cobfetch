       REPLACE ==:BUFFER-SIZE:== BY ==32768==.

       identification division.
       function-id. pipe-run.

       environment division.
           configuration section.
           repository.
               function pipe-open
               function pipe-read
               function pipe-write
               function pipe-close.

       data division.
           working-storage section.
      * File pointer
      
               01 pipe-record.
                  02 pipe-pointer      usage pointer.
                  02 pipe-return       usage binary-long.

      * Return of fgets and fputs
      
               01 pipe-record-out.
                  02 pipe-read-status  usage pointer.
                     03 pipe-gone      value null.
                  02 pipe-write-status usage binary-long.
               01 pipe-status          usage binary-long.

           linkage section.
               01 pipe-command         pic x(:BUFFER-SIZE:).
               01 pipe-details.
                   02 pipe-line            pic x(:BUFFER-SIZE:).
                   02 pipe-length          pic 9(5).

      *> ***************************************************************
      
       procedure division using
           pipe-command
         returning pipe-details.

           move pipe-open(pipe-command, "r") to pipe-record
           if pipe-return not equal 255 then 
               move pipe-read(pipe-record, pipe-line) to pipe-record-out
               move pipe-close(pipe-record) to pipe-status
               if pipe-status equal zero then
                   unstring pipe-line delimited by x"0a" into pipe-line
                       count in pipe-length
                   end-unstring
               else
                   display "ERROR!"
               end-if
           else
               display "ERROR!"
           end-if.

       end function pipe-run.
