#!/usr/bin/expect -f
#
# j
#
# A simple expect script to securely automate the network login
# of IOS-like networking equipment by leveraging the open-source
# password manager `pass` (https://passwordstore.org).
#
# Dependencies:
# - expect
# - pass
#
# Written by Raymond Douglas // 2019
#
# https://github.com/raylas
#
#

if {[llength $argv ] == 0} {
    puts "usage: j \[--t] destination"
    puts "       j --help for help"
    exit 1
}

if {[lindex $argv 0] == "--help"} {
    puts "usage: j \[--t] destination"
    puts "       --t: specifies telnet host"
    exit 1
}

proc tlogin {user pass enable} {
    send "$user\r"
    expect "*assword:"
    send "$pass\r"
    expect "*>"
    send "en\r"
    expect "*assword: "
    send "$enable\r"
}

proc slogin {pass enable} {
    send "$pass\r"
    expect "*>"
    send "en\r"
    expect "*assword: "
    send "$enable\r"
}

set timeout 20
set username <your_username>
set password [exec pass show <your_pass_descriptor>]
set enable [exec pass show <your_pass_descriptor>]

if {[lindex $argv 0] == "--t"} {
    set address [lindex $argv 1]

    spawn telnet $address
    expect {
        "Server lookup failure: *" {
            exit 1
        }
        "*sername:" {
            tlogin $username $password $enable
            interact
            exit 1
        }
    }
} else {
    set address [lindex $argv 0]

    spawn ssh -o "StrictHostKeyChecking no" $username@$address
    expect {
        "ssh: Could not resolve hostname *" {
            exit 1
        }
        "*assword:" {
            slogin $password $enable
            interact
            exit 1
        }
    }
}