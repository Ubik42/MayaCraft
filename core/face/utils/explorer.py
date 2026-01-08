import subprocess
from functools import partial


def run(url):
    command = r'"C:/Program Files/Internet Explorer/iexplore.exe" {url}'.format(url=url)
    subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)


help = partial(run, "https://www.bilibili.com/video/av74697724/")
study = partial(run, "https://afdian.net/p/07f16a0a1a9b11eaa0a952540025c377")
