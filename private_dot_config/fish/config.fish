if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_key_bindings fish_vi_key_bindings
    bind --mode insert ctrl-j down-or-search
    bind --mode insert ctrl-k up-or-search
end

export JULIA_PKG_PRESERVE_TIERED_INSTALLED=1
export BAT_THEME=GitHub
export EDITOR=nvim
fish_add_path /home/frankier/.local/bin
fish_add_path /home/frankier/bin

# pnpm
set -gx PNPM_HOME "/home/frankier/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
