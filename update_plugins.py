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
auto-pairs https://github.com/jiangmiao/auto-pairs master
coc.nvim https://github.com/neoclide/coc.nvim release
lightline.vim https://github.com/itchyny/lightline.vim master
nightfox.nvim https://github.com/EdenEast/nightfox.nvim main
tokyonight.nvim https://github.com/folke/tokyonight.nvim main
vim-commentary https://github.com/tpope/vim-commentary master
vim-indent-object https://github.com/michaeljsmith/vim-indent-object master
vim-notes https://github.com/will-ockmore/vim-notes master
vim-repeat https://github.com/tpope/vim-repeat master
vim-surround https://github.com/tpope/vim-surround master
vim-tmux-navigator https://github.com/christoomey/vim-tmux-navigator master
vim-yankstack https://github.com/maxbrunsfeld/vim-yankstack master
fennel.vim https://github.com/bakpakin/fennel.vim master
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

    try:
        download_extract_replace(name, zip_path, branch, temp_directory, SOURCE_DIR)
    except Exception as e:
        print(e)


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
