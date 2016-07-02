# Uses session_root instead. Make sure it is set in the session layout
#window_root "~/Projects/"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "editor"

# Split window into panes.
split_v 25

# Run commands.
run_cmd "vim ." 1

# Set active pane.
select_pane 1
