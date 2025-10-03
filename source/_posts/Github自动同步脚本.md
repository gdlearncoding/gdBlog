---
title: Github自动同步脚本
date: 2025-10-01
tags:
  - tools
categories: 果冻的奇妙小工具
cover: ./img/bearbug1.jpg
---
# 实施步骤
进入要同步的库中，切换至 Actions，点击后面的 New workflow 项

打开新页面后，点击篮字的 set up a workflow yourself

设置文件名 `sync.yml`「可自定义，不与其它脚本同名即可」

将下面的脚本填到输入框中，点击右上方 Commit changes 即可：

```
name: Upstream Sync

permissions:
  contents: write

on:
  schedule:
    - cron: "0 0 * * *" # every day
  workflow_dispatch:

jobs:
  sync_latest_from_upstream:
    name: Sync latest commits from upstream repo
    runs-on: ubuntu-latest
    if: ${{ github.event.repository.fork }}

    steps:
      # Step 1: run a standard checkout action
      - name: Checkout target repo
        uses: actions/checkout@v4

      # Step 2: run the sync action
      - name: Sync upstream changes
        id: sync
        uses: aormsby/Fork-Sync-With-Upstream-action@v3.4
        with:
          upstream_sync_repo: arnidan/nsfw-api
          upstream_sync_branch: main
          target_sync_branch: main
          target_repo_token: ${{ secrets.GITHUB_TOKEN }} # automatically generated, no need to set

          # Set test_mode true to run tests instead of the true action!!
          test_mode: false

      - name: Sync check
        if: failure()
        run: |
          echo "[Error] 由于上游仓库的 workflow 文件变更，导致 GitHub 自动暂停了本次自动更新，您需要手动 Sync Fork 一次。"
          echo "[Error] Due to a change in the workflow file of the upstream repository, GitHub has automatically suspended the scheduled automatic update. You need to manually sync your fork."
          exit 1

```