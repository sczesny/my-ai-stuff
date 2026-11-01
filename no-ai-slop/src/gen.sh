#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
source ../../claude-md/src/helper.sh

fetch petergyang/no-ai-slop main skills/no-ai-slop/SKILL.md no-ai-slop-skill.md
fetch petergyang/no-ai-slop main skills/no-ai-slop/eval.md no-ai-slop-eval.md

{

    from no-ai-slop-skill
    # frontmatter, which copy can't reach because it starts at a heading
    sed '/^# /,$d' "$src.md" |
        edit 's/^description: .*/description: Rules for prose people will read. Load before writing any doc, README, email, post, report or artifact text, even unasked. Also to edit a draft or flag AI slop. Skip for chat replies and code./'
    copy "# No AI slop" |
        edit 's/against `eval\.md` yourself/against the Final check section yourself/' |
        edit 's/^Banned outright: .*/& Keep them in technical terms, names, code and quotes./' |
        edit '/^## Two jobs$/i ## Writing new text\n\nWhen you load this skill to write text yourself, not to edit a draft from the user, apply Editing principles, Words to cut and Patterns to cut as you write. Before delivering, run the Final check, skip checks that only apply to an existing draft, and fix any failure. Skip What to ask for and the What changed section. The example rewrites show form only: use only facts you have, and if one is missing, ask the user or cut the claim. Do not mention this skill in the output.\n'

    from no-ai-slop-eval
    copy "# No AI slop eval" |
        edit 's/^## /### /' |
        edit 's/removed unless quoted as examples?/removed unless part of a technical term, name, code or quote?/' |
        edit 's/^# No AI slop eval$/## Final check/'

} | cat -s | sed '${/^$/d}' > ../SKILL.md

check
