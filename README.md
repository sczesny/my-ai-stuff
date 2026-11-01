# My AI Stuff

Personal Claude Code skills and configuration

- [`claude-md/CLAUDE.md`](claude-md/CLAUDE.md): generated global instructions
- [`tldr/SKILL.md`](tldr/SKILL.md): rules for short, scannable chat replies
- [`no-ai-slop/SKILL.md`](no-ai-slop/SKILL.md): generated rules for prose people will read

## CLAUDE.md

[`claude-md/CLAUDE.md`](claude-md/CLAUDE.md) merges trimmed sections of:

- [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) as a base
- [dietrichgebert/ponytail](https://github.com/dietrichgebert/ponytail)
- [juliusbrussee/caveman](https://github.com/juliusbrussee/caveman)
- [tldr/SKILL.md](tldr/SKILL.md) from this repo

## TL;DR

[`tldr/SKILL.md`](tldr/SKILL.md) is a skill that keeps Claude's chat replies short. The reply starts with the answer and stops there, with no preamble, extras or closing line. Structure follows the content: lists, tables and code blocks only where they fit. It covers chat replies only, not documents or files.

## No AI slop

[`no-ai-slop/SKILL.md`](no-ai-slop/SKILL.md) merges the skill and eval from [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop). The changes: a broader trigger description, a section for writing new text, and the eval inlined as a Final check.

## Licenses

The generated files contain modified text from these sources. [`THIRD_PARTY_LICENSES`](THIRD_PARTY_LICENSES) has the full license texts.

| Source | License | Copyright |
|--------|---------|-----------|
| [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | MIT, stated in its README and plugin manifest; the repo has no LICENSE file | Not stated |
| [dietrichgebert/ponytail](https://github.com/DietrichGebert/ponytail/blob/main/LICENSE) | MIT | Copyright (c) 2026 DietrichGebert |
| [juliusbrussee/caveman](https://github.com/JuliusBrussee/caveman/blob/main/LICENSE) | Apache-2.0 | Copyright 2026 Julius Brussee |
| [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop/blob/main/LICENSE) | MIT | Copyright (c) 2026 Peter Yang |
