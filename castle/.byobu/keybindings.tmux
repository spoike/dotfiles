# Requires tmux >=2.1

set -g mouse-utf8 on
set -g mouse on

bind -n WheelUpPane   select-pane -t= \; copy-mode -e \; send-keys -M
bind -n WheelDownPane select-pane -t= \;                 send-keys -M
bind -n C-WheelUpPane select-pane -t= \; copy-mode -e \; send-keys -M
bind -t vi-copy C-WheelUpPane   halfpage-up
bind -t vi-copy C-WheelDownPane halfpage-down

