# logchange
a simple interactive bash script to assist with recording information about major changes made to your system for easier reinstalls and searching of repeat issues and their solutions.

## Usage
### Logging a change
To use this script to log a new change, type `logchange` into your terminal to activate the script.

Once activated, the script will interactively ask you a series of simple questions:

| Question      | Expected Input | Purpose |
| ----------- | ----------- | ----------- |
| Is this a [s]ystem change or a [U]ser change? | `[sS|Uu]` or `enter` to accept the default of `U` | This records whether this change is user-level (i.e. home-folder configs) or system level (i.1. /etc/ configs, sudo apt install, etc.) |
| What piece of software does this change affect? (i.e. Firefox) | Free Response, defaults to the empty string | Provides a place to record whether this affects a particular piece of software |
| What/Where/Why? | Free Response, defaults to the empty string | provides a place to explain the problem being solved and include potential keywords for later searching |
| Is there a link to go with this change? | Free Response, defaults to the empty string | Provides a place to include a link to stackoverflow or any site to record where you found the solution to the problem in case its needed later |

### Log file format
Your answers to the above questions will be appended to the changelog file in one of the following formats:


System: `[D System] M <L>`

User: `[D User] { A }: M <L>`

where the capital letters serve as placeholders for:
- D - the datetime at which this entry was made
- A - the name of the affected application as entered
- M - the message explaining the issue as entered
- L - the link provided (if any)

### Help Text
```
logchange.sh [[-h|--help]|[--oops|--undo]|[ --show|--list]|--open] -- a simple interactive bash script to assist with recording information about major changes made to your system.

where:
    -h|--help  show this help text
    --oops|--undo  removes the last line added to the changelog after a confirmation prompt
    --show|--list  output the contents of the changelog file using the cat utility
    --open  open the changelog file in the kate text editor
```


## Setup

To set up this script, place the `logchange.sh` script somewhere on your system where the path is not likely to change. Then, in your favorite startup location of choice (maybe `.profile` is a safe default? not sure which one is best for what), paste the following lines and edit as appropriate (none have trailing slashes):

```
export CHANGELOG_DIR="path/to/where/you/want/the/changelog/file"
alias logchange=/path/to/logchange.sh
alias changelog='logchange --show'
```

