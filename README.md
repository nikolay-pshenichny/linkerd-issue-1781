## Scripts to reproduce the inotify issue (1781)

More about the issue - https://github.com/linkerd/linkerd/issues/1781

### Requirements

- Vagrant - https://www.vagrantup.com/
- Virtualbox - `brew install caskroom/cask/virtualbox`

### Howto

Start the `./repro.sh` script and it will:
 - provision a new linux box;
 - download a Linkerd bin and add a simple config file for it;
 - set the inotify watches limit to 0 inside of the provisioned box (to emulate the scenario when system is running out of inotify watches);
 - start the linkerd inside of the box
 - generate 129 requests through the running linkerd


 ### What will happen?

There are 128 inotify instances available in the box (`sysctl fs.inotify`), Linkerd will aquire one of them and will try to add a watch for the `discovery` folder.
The latter will fail and Linkerd will aquire a new inotify instance and will try to add a watch to it. That loop will continue on each new request.
The error messages will change from "User limit of inotify watches reached" to "User limit of inotify instances reached or too many open files" when the system will be out of inotify instances.



### Helpful commands

How to check how many inotify instances linkerd uses:

`find /proc/$(ps a |grep -e [l]inkerd |awk '{print $1}')/fd/* -type l -lname 'anon_inode:inotify' -print |wc -l`

How the verify the limits:

`sysctl fs.inotify`