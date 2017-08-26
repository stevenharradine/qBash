# qBash
QueueBash executes bash commands passing in a variable from a queue.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Usage
**Note:** the input file is distructive, it is the queue and as items are popped off they are lost
```
./qBash.sh {{ command }} {{ inputfile }}
```
### Where,
 * `command` is the bash command to be executed
 * `inputfile` is a line delimited file with the parameters to be appended to the end of the command

## Example (installed)
1. Install
```
sudo install.sh
```
2. Create input file
```
touch in
echo "Hello" > in
echo "World!" >> in
```
3. Execute your command across all lines in the input file
```
qBash echo in
```
```
~/qBash$ qBash echo in
Hello
World!
```

## Example (from script)
1. Create input file
```
touch in
echo "Hello" > in
echo "World!" >> in
```
2. Execute your command across all lines in the input file
```
./qBash.sh echo in
```
```
~/qBash$ ./qBash.sh echo in
Hello
World!
```
