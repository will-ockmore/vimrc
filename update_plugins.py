try:
    import concurrent.futures as futures
except ImportError:
    try:
        import futures
    except ImportError:
        futures = None

import zipfile
import shutil
import tempfile
import requests

from os import path


# --- Globals ----------------------------------------------
PLUGINS = """
coc.nvim https://github.com/neoclide/coc.nvim release
auto-pairs https://github.com/jiangmiao/auto-pairs master
ale https://github.com/w0rp/ale master
vim-yankstack https://github.com/maxbrunsfeld/vim-yankstack master
nerdtree https://github.com/scrooloose/nerdtree master
fzf.vim https://github.com/junegunn/fzf.vim master
vim-colors-solarized https://github.com/altercation/vim-colors-solarized master
vim-indent-object https://github.com/michaeljsmith/vim-indent-object master
vim-surround https://github.com/tpope/vim-surround master
vim-expand-region https://github.com/terryma/vim-expand-region master
goyo.vim https://github.com/junegunn/goyo.vim master
vim-repeat https://github.com/tpope/vim-repeat master
vim-commentary https://github.com/tpope/vim-commentary master
vim-go https://github.com/fatih/vim-go master
vim-gitgutter https://github.com/airblade/vim-gitgutter master
gruvbox https://github.com/morhetz/gruvbox master
lightline.vim https://github.com/itchyny/lightline.vim master
lightline-ale https://github.com/maximbaz/lightline-ale master
vim-markdown https://github.com/plasticboy/vim-markdown master
comfortable-motion.vim https://github.com/yuttie/comfortable-motion.vim master
""".strip()


SOURCE_DIR = path.join(path.dirname(__file__), "sources_non_forked")


def download_extract_replace(plugin_name, zip_path, branch, temp_dir, source_dir):
    temp_zip_path = path.join(temp_dir, plugin_name)

    # Download and extract file in temp dir
    req = requests.get(zip_path)
    open(temp_zip_path, "wb").write(req.content)

    zip_f = zipfile.ZipFile(temp_zip_path)
    zip_f.extractall(temp_dir)

    plugin_temp_path = path.join(
        temp_dir, path.join(temp_dir, f"{plugin_name}-{branch}")
    )

    # Remove the current plugin and replace it with the extracted
    plugin_dest_path = path.join(source_dir, plugin_name)

    try:
        shutil.rmtree(plugin_dest_path)
    except OSError:
        pass

    shutil.move(plugin_temp_path, plugin_dest_path)
    print("Updated {0}".format(plugin_name))


def update(plugin):
    name, github_url, branch = plugin.split(" ")
    zip_path = f"{github_url}/archive/{branch}.zip"
    download_extract_replace(name, zip_path, branch, temp_directory, SOURCE_DIR)


if __name__ == "__main__":
    temp_directory = tempfile.mkdtemp()

    try:
        if futures:
            with futures.ThreadPoolExecutor(16) as executor:
                executor.map(update, PLUGINS.splitlines())
        else:
            [update(x) for x in PLUGINS.splitlines()]
    finally:
        shutil.rmtree(temp_directory)
