from shutil import *
from os import *

pj = path.join
rel = lambda *x: pj(path.abspath(path.dirname(__file__)), *x)

def gohome(fn, extra=""):
    fdest = extra + fn
    symlink(rel(fn), pj("~", fdest))


for f in [
    "vimrc.before.local",
    "vimrc.bundles.local",
    "vimrc.local",
]:
    gohome(f)

for f in [
    "xinitrc",
    "Xresources",
    "zshrc",
    "gitignore",
    "gitconfig"
]:
    gohome(f, ".")

fontsd = "~/.fonts/"
mkdir(fontsd)
gohome(listdir(fontsd)[0], fontsd)


def setup_neovim():
    pass
