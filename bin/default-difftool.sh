#! /bin/bash
 
if [[ -f /Applications/MacVim.app/Contents/MacOS/Vim ]]
then
    # bypass mvim for speed
    VIMPATH='/Applications/MacVim.app/Contents/MacOS/Vim -g -dO -f'
elif [[ -f /usr/local/bin/mvim ]]
then
    # fall back to mvim
    VIMPATH='mvim -d -f'
else
    # fall back to original vim
    VIMPATH='vimdiff'
fi
 
$VIMPATH $@

