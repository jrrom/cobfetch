       REPLACE ==:BUFFER-SIZE:== BY ==32768==.

       identification division.
       program-id. cobfetch.

       environment division.
           configuration section.
           repository.
               function pipe-run.

       data division.
           file section.
           working-storage section.
               01 logo.
                   02 line-1 pic x(21) value "               __   ".
                   02 line-2 pic x(21) value "              / _)  ".
                   02 line-3 pic x(21) value "     _.----._/ /    ".
                   02 line-4 pic x(21) value "    /         /     ".
                   02 line-5 pic x(21) value " __/ (  | (  |      ".
                   02 line-6 pic x(21) value "/__.-'| |--| |      ".
                   02 line-7 pic x(21) value "      |_|  |_|      ".

               01 pipe-details-user.
                   02 pipe-line-user     pic x(:BUFFER-SIZE:).
                   02 pipe-length-user   pic 9(5).

               01 pipe-details-os.
                   02 pipe-line-os       pic x(:BUFFER-SIZE:).
                   02 pipe-length-os     pic 9(5).

               01 pipe-details-kernel.
                   02 pipe-line-kernel   pic x(:BUFFER-SIZE:).
                   02 pipe-length-kernel pic 9(5).
           
               01 pipe-details-uptime.
                   02 pipe-line-uptime   pic x(:BUFFER-SIZE:).
                   02 pipe-length-uptime pic 9(5).

               01 pipe-details-shell.
                   02 pipe-line-shell    pic x(:BUFFER-SIZE:).
                   02 pipe-length-shell  pic 9(5).
               
               01 green pic x(21) value "echo -ne '\033[32;1m'".
               01 clear pic x(18) value "echo -ne '\033[0m'".
           
      *> ***************************************************************
      
       procedure division.
           move pipe-run("echo $USER")  to pipe-details-user
           move pipe-run(". /etc/os-release && echo $PRETTY_NAME")
               to pipe-details-os
           move pipe-run("uname -r")    to pipe-details-kernel
           move pipe-run("uptime -p")   to pipe-details-uptime
           move pipe-run("echo $SHELL") to pipe-details-shell

           call "SYSTEM" using green

           display line-1

           display line-2 with no advancing
               display "  USER  " with no advancing
               display pipe-line-user(1 : pipe-length-user)
           
           display line-3 with no advancing
               display "    OS  " with no advancing
               display pipe-line-os(1 : pipe-length-os)

           display line-4 with no advancing
               display "KERNEL  " with no advancing
               display pipe-line-kernel(1 : pipe-length-kernel)

           display line-5 with no advancing
               display "UPTIME  " with no advancing
               display pipe-line-uptime(4 : pipe-length-uptime)

           display line-6 with no advancing
               display " SHELL  " with no advancing
               display pipe-line-shell(1 : pipe-length-shell)

           display line-7
           
           display space

           call "SYSTEM" using clear

           stop run.
