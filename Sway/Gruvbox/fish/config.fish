set -g fish_greeting

if status is-login
    if test (tty) = /dev/tty1
       sway
    end
end

set -gx PATH $HOME/.local/bin $PATH

