# Laptop Scripts
For when my laptop falls into a lake -> 💻⛵  
Run the following as root:  
`apt-get install git`  
`git clone https://github.com/librick/laptop && cd laptop`  
Copy an age `key.txt` file to the root of this project, then install:  
`./install.sh`  

## After Install
Certain things can only be done after a reboot (`shutdown -r now`)  
Reboot the machine, then
`./post-install`  

## Maintenance
Pull down the repo and decrypt everything with `./decrypt-files.sh`  
Modify any files, including in `age-plaintext`  
Reencrypt with `./encrypt-files.sh`  
Scripts can be run individually with `./scripts/<some-script>.sh`  

## Debian ISOs
https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-cd/debian-testing-amd64-netinst.iso
