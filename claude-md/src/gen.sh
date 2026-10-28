#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
source helper.sh

fetch multica-ai/andrej-karpathy-skills main CLAUDE.md andrej-karpathy-skills.md
fetch dietrichgebert/ponytail main skills/ponytail/SKILL.md ponytail-skill.md
fetch juliusbrussee/caveman main skills/caveman/SKILL.md caveman-skill.md

{

    from andrej-karpathy-skills
    intro "# CLAUDE.md" |
        edit '/^\*\*Tradeoff:\*\*/d'
    copy "## 1. Think Before Coding" |
        edit 's/^## 1\. /## /' |
        edit 's/ If uncertain, ask\.$//' |
        edit '/If a simpler approach exists/d' |
        edit 's/If something is unclear, stop\./If something is unclear and has no sensible default, stop./'
    ignore "## 2. Simplicity First"
    copy "## 3. Surgical Changes" |
        edit 's/^## 3\. /## /'
    copy "## 4. Goal-Driven Execution" |
        edit 's/^## 4\. /## /' |
        edit '/^For multi-step tasks/,/^Strong success/{/^Strong success/!d}' |
        edit '/^---$/,$d'

    from ponytail-skill
    intro "# Ponytail" |
        edit 's#`/ponytail lite|full|ultra`#say "ponytail lite", "ponytail full" or "ponytail ultra"#' |
        edit 's/End your reply with/End a reply that changes code with/'
    copy "## Before you write"
    copy "## The smallest complete change" |
        edit 's/Deletion beats addition\./Deletion beats addition within your own change./' |
        edit 's/^Never cut:/Skip error handling for impossible scenarios. &/'
    copy "## Levels"

    from caveman-skill
    intro "# caveman" |
        edit '1s/caveman/Caveman/'
    copy "## Persistence" |
        edit '/^`\/caveman ultra`/d'
    ignore "## Why"
    copy "## Rules" |
        edit 's/^No greeting, hedging, pleasantries, recap, or closer\./& Exception: the ponytail closing line./'
    copy "## When to break the rules" |
        edit 's/ `\/caveman-compress` exempt\.//'
    copy "## Pre-send check" |
        edit 's/^2\. Last sentence recaps or offers help? Delete\./& Keep the ponytail closing line (skipped, risks)./'

    from ../../tldr/SKILL
    copy "# Too long; didn't read" |
        edit 's/not documents or files\./& When another section of this file tells you to add something to a reply, keep it./'

} | cat -s | sed '${/^$/d}' > ../CLAUDE.md

check
