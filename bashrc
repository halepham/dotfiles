if [ -n "$PS1" ]
then
    for file in ~/.dotfiles/shell/{bash_prompt,bash_aliases}
    do
	    [ -r "$file" ] && [ -f "$file" ] && source "$file"
    done
    unset file
fi
