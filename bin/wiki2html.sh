# ~/.dotfiles/wiki2html.sh

set -x

env HUGO_baseURL="file:///Users/${USER}/vimwiki/_site/" \
    hugo --themesDir ~/ -t vimwiki \
    --config ~/vimwiki/config.toml \
    --contentDir ~/vimwiki/content \
    -d ~/vimwiki/_site --quiet > /dev/null

set +x
