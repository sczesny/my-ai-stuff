#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
source helper.sh

fetch multica-ai/andrej-karpathy-skills 2c606141936f1eeef17fa3043a72095b4765b9c2 CLAUDE.md andrej-karpathy-skills.md
fetch dietrichgebert/ponytail 09c434ab73ca43761c5d8b0c5d341926c2fba710 skills/ponytail/SKILL.md ponytail-skill.md
fetch juliusbrussee/caveman bad48a0e1df55e05e3f52249afa35ecc1909ee76 skills/caveman/SKILL.md caveman-skill.md

{

    from andrej-karpathy-skills
    intro "# CLAUDE.md" |
        sed '/^\*\*Tradeoff:\*\*/d'
    copy "## 1. Think Before Coding" |
        sed \
            -e 's/^## 1\. /## /' \
            -e 's/ If uncertain, ask\.$//' \
            -e '/If a simpler approach exists/d' \
            -e 's/If something is unclear, stop\./If something is unclear and has no sensible default, stop./'
    ignore "## 2. Simplicity First"
    copy "## 3. Surgical Changes" |
        sed 's/^## 3\. /## /'
    copy "## 4. Goal-Driven Execution" |
        sed \
            -e 's/^## 4\. /## /' \
            -e '/^For multi-step tasks/,/^Strong success/{/^Strong success/!d}' \
            -e '/^---$/,$d'

    from ponytail-skill
    intro "# Ponytail" |
        sed \
            -e 's#`/ponytail lite|full|ultra`#say "ponytail lite", "ponytail full" or "ponytail ultra"#' \
            -e 's/End your reply with/End a reply that changes code with/'
    copy "## Before you write"
    copy "## The smallest complete change" |
        sed \
            -e 's/Deletion beats addition\./Deletion beats addition within your own change./' \
            -e 's/^Never cut:/Skip error handling for impossible scenarios. &/'
    copy "## Levels"

    from caveman-skill
    intro "# caveman" |
        sed '1s/caveman/Caveman/'
    copy "## Persistence" |
        sed '/^`\/caveman ultra`/d'
    ignore "## Why"
    copy "## Rules" |
        sed 's/^No greeting, hedging, pleasantries, recap, or closer\./& Exception: the ponytail closing line./'
    copy "## When to break the rules" |
        sed 's/ `\/caveman-compress` exempt\.//'
    copy "## Pre-send check" |
        sed 's/^2\. Last sentence recaps or offers help? Delete\./& Keep the ponytail closing line (skipped, risks)./'

} | cat -s | sed '${/^$/d}' > CLAUDE.md

check
