if status is-interactive
    # Commands to run in interactive sessions can go here
end

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# mcfly
mcfly init fish | source
set -gx MCFLY_DISABLE_MENU TRUE

# aliases
alias code=codium
alias ls=eza
alias dig=dog
alias cat=bat

# functions
function mkenv -d "Create a Python virtualenv"
    set venvs_dir "$HOME/.venvs"
    set python_version $argv[1]
    set venv_name $argv[2]

    if test -z "$python_version"
        echo "Error: missing Python version." >&2
        return 1
    end

    if test -z "$venv_name"
        echo "Error: missing venv name." >&2
        return 1
    end

    if test -d "$venvs_dir/$venv_name"
        echo "Error: virtualenv '$venv_name' already exists (run 'workon $venv_name' to activate it)." >&2
        return 1
    end

    set python_bin "$HOME/.asdf/installs/python/$python_version/bin/python"

    if test ! -f "$python_bin"
        echo "Error: Python version '$python_version' not installed (run 'asdf install python $python_version' to install it)." >&2
        return 1
    end

    eval "$python_bin -m venv --upgrade-deps $venvs_dir/$venv_name"
end

function workon -d "Activate a Python virtualenv"
    set venvs_dir "$HOME/.venvs"
    set venv_name $argv[1]

    if test -z "$venv_name"
        echo "Error: missing venv name." >&2
        return 1
    end

    if test ! -d "$venvs_dir/$venv_name"
        echo "Error: virtualenv '$venv_name' doesn't exist (run 'mkenv <PYTHON_VERSION> $venv_name' to create it)." >&2
        return 1
    end

    eval "source $venvs_dir/$venv_name/bin/activate.fish"
end

# completions
function asdf_python_versions
    asdf list python 2>/dev/null | string trim | string trim --left --chars '*'
end
set python_versions (asdf_python_versions)
complete -f -c mkenv
complete -f -c mkenv -n "not __fish_seen_subcommand_from $python_versions" -a "$python_versions"

function all_venvs
    find "$HOME/.venvs" -type d -mindepth 1 -maxdepth 1 -exec basename {} \;
end
set venvs (all_venvs)
complete -f -c workon -n "not __fish_seen_subcommand_from $venvs" -a "$venvs"
