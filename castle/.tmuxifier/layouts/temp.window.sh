window_root "$(mktemp -d)"
new_window "temp sandbox"
run_cmd "cd $window_root && clear"
select_pane 0
