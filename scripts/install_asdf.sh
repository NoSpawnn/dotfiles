git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
source "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
