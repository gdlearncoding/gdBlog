# 自动Git推送脚本配置指南

本文档将帮助你配置`auto_git_push.sh`脚本，使其每天自动运行。

## 脚本概述

`auto_git_push.sh`脚本用于自动检查博客仓库中的更改，并在有未提交更改时自动执行git add、commit和push操作。脚本会记录执行日志到`auto_git_push.log`文件中。

## 设置自动运行（macOS）

在macOS系统上，我们可以使用`cron`或`launchd`来设置任务定时运行。这里我们使用cron，因为它设置简单直观。

### 方法一：直接运行命令设置cron任务

运行以下命令可以直接设置每天23:30（晚上11点半）自动运行脚本：

```bash
(crontab -l 2>/dev/null; echo "30 23 * * * /bin/bash /Users/ggd/Blog/gdBlog/auto_git_push.sh") | crontab -
```

### 方法二：手动编辑crontab

1. 打开终端，运行以下命令编辑crontab文件：
   ```bash
   crontab -e
   ```

2. 如果这是你第一次使用cron，系统会提示你选择编辑器，选择你熟悉的编辑器（如nano）。

3. 在打开的文件末尾添加以下行（表示每天23:30运行脚本）：
   ```
   30 23 * * * /bin/bash /Users/ggd/Blog/gdBlog/auto_git_push.sh
   ```

4. 保存并退出编辑器：
   - 如果你使用的是nano编辑器，按`Ctrl+O`保存，按`Ctrl+X`退出
   - 如果你使用的是vim编辑器，按`Esc`后输入`:wq`并按回车键

## 自定义运行时间

cron表达式的格式为：`分 时 日 月 周 命令`

如果你想修改脚本的运行时间，可以调整cron表达式：

- 每天23:30运行（已设置）：`30 23 * * * /bin/bash /Users/ggd/Blog/gdBlog/auto_git_push.sh`
- 每周一20:00运行：`0 20 * * 1 /bin/bash /Users/ggd/Blog/gdBlog/auto_git_push.sh`
- 每月1日凌晨1:00运行：`0 1 1 * * /bin/bash /Users/ggd/Blog/gdBlog/auto_git_push.sh`

## 查看已设置的cron任务

运行以下命令可以查看当前用户的所有cron任务：

```bash
crontab -l
```

## 查看脚本运行日志

脚本执行过程中会记录日志到`auto_git_push.log`文件中。你可以通过以下命令查看日志：

```bash
cat /Users/ggd/Blog/gdBlog/auto_git_push.log
```

或者查看最近的日志：

```bash
tail -n 50 /Users/ggd/Blog/gdBlog/auto_git_push.log
```

## 注意事项

1. **确保Git凭证已保存**：为了让脚本能够自动推送到远程仓库，你需要确保Git凭证已经保存在系统中。可以使用以下命令设置凭证缓存：
   ```bash
git config --global credential.helper osxkeychain
   ```

2. **保持电脑处于开机状态**：cron任务只有在电脑开机且未休眠的状态下才会执行。如果你的电脑在预定时间处于关机或休眠状态，任务将不会执行。

3. **权限问题**：确保`auto_git_push.sh`脚本具有执行权限（已通过`chmod +x`命令设置）。

4. **测试脚本**：在设置cron任务前，可以手动运行脚本测试是否正常工作：
   ```bash
   /bin/bash /Users/ggd/Blog/gdBlog/auto_git_push.sh
   ```

如果你遇到任何问题，可以查看日志文件了解详细信息。