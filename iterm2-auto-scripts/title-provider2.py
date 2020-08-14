#!/usr/bin/env python3

import asyncio
import iterm2
import os

def make_pwd(user_home, localhome, pwd):
    if pwd:
        if user_home:
            home = user_home
        else:
            home = localhome
        if pwd == home:
            return "🏡"
        else:
            return os.path.basename(os.path.normpath(pwd))
    return ""

async def main(connection):
    localhome = os.environ.get("HOME")

    @iterm2.TitleProviderRPC
    async def make_title(
        pwd=iterm2.Reference("path?"),
        tmux_title=iterm2.Reference("tmuxWindowTitle?"),
        user_home=iterm2.Reference("user.home?")):
        if tmux_title:
            return tmux_title

        return make_pwd(user_home, localhome, pwd)
    await make_title.async_register(connection,
        display_name="Title Algorithm",
        unique_identifier="com.iterm2.example.georges-title-algorithm")

iterm2.run_forever(main)
