if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx PYTHONBREAKPOINT ipdb.set_trace
    alias jupyter-notebook="jupyter-notebook --no-browser"
    alias jupyter-lab="jupyter-lab --no-browser"
    alias config="/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME"
end
