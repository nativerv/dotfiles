# Append to the history file, don't overwrite it
shopt -s histappend

# Update LINES and COLUMNS after each command
shopt -s checkwinsize

# Enable "**" pattern
shopt -s globstar

# Enable vi mode
set -o vi;

# Enable additional patterns like !(file_*) to exclude file_*
shopt -s extglob