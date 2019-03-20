# j

![j in motion](https://raw.githubusercontent.com/raylas/j/master/j.gif)

j is a simple expect script to securely automate the network login of IOS-like networking equipment by leveraging the open-source password manager [pass](https://passwordstore.org).

Dependencies:

* [expect](https://core.tcl.tk/expect/index)
* [pass](https://passwordstore.org)

Functionality:

* Automatically insert username, password, and enable password during device login
* Password and enable password are stored securely in the pass `.password-store`
* Add agrument `--telnet` to specify a telnet destination

Todo:

* Improve error handling
* Add linux sshd destination support
* Add alternative password manager support

## Use

### Install expect and pass

Arch:

``` shell
sudo pacman -S expect
sudo pacman -S pass
```

Debian and Ubuntu:

``` shell
sudo apt install expect
sudo apt install pass
```

CentOS:

``` shell
sudo yum install expect
sudo yum install pass
```

### Adjust variables

Open `j` in a text editor and add your username and pass descriptors:

``` shell
set username <your_username>
set password [exec pass show <your_pass_descriptor>]
set enable [exec pass show <your_pass_descriptor>]
```

### Make j executable

``` shell
chmod +x j
```
Also, it's best if you moved `j` to a directory part of PATH.

### Connect to host

SSH:
``` shell
j 192.168.100.52
```
Telnet:
``` shell
j --telnet 192.168.100.42
```
