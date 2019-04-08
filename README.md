# winapshot

# What does Winapshot do?
Run only one script to install all tools and config all environments when you have a new Windows

希望仅运行一个脚本，便能在一台新的 Windows 上快速安装必要的工具以及配置环境。

# Quick Start

> winapshot help

```
Usage: winapshot <command> [<args>]

Some useful commands are:

gen   Generate scripts
help  Show help for a command
```

> winapshot gen -a

It will create a folder named winapshot.

> cd winapshot
> 
> ls
```
    config        Set-All.ps1
```

**config** contains the configs of your computer

**Set-All.ps1** is the script setting everything

Copy the winapshot folder to your new computer and run the **Set-All.ps1**.

> cd winapshot
>
> .\Set-All.ps1