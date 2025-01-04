if test -z $DISPLAY; and test (tty) = /dev/tty1
    # /home/izzqz/.config/river/run-river
end

set -g fish_greeting

# Ensure that GPG Agent is used as the SSH agent
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x GPG_TTY (tty)
gpgconf --launch gpg-agent

if status is-interactive
    zoxide init fish | source
    thefuck --alias | source
    source ~/.asdf/asdf.fish
end

function foot_cmd_start --on-event fish_preexec
    echo -en "\e]133;C\e\\"
end

function foot_cmd_end --on-event fish_postexec
    echo -en "\e]133;D\e\\"
end

function mark_prompt_start --on-event fish_prompt
    echo -en "\e]133;A\e\\"
end

function update_cwd_osc --on-variable PWD --description 'Notify terminals when $PWD changes'
    if status --is-command-substitution || set -q INSIDE_EMACS
        return
    end
    printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
end

set -gx EDITOR /sbin/hx
set -gx PAGER "moar --statusbar=bold"

update_cwd_osc # Run once since we might have inherited PWD from a parent shell

alias untar='tar -xvzf'
alias ex='aunpack'
alias fetch='aria2c -Z -s16 -x16'
alias ls="eza --icons -TL 1 --git"
alias cat="bat"
alias lg="lazygit"
alias rm="echo 'use rip instead plz'"
