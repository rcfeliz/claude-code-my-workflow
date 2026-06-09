# CLAUDE.MD -- Infraestrutura Acadêmica com Claude Code

**Usuário:** Ricardo Feliz Okamoto — Doutorando em Direito do Estado
**Instituição:** FD USP — Faculdade de Direito da USP
**Branch:** main

---

## O que é este repositório

Este repositório é a **infraestrutura do Claude Code** — skills, agentes, regras, hooks e templates. Não é onde se escreve artigos; é onde se configura como o Claude ajuda a escrevê-los.

### Fluxo de trabalho

```
my-claude (este repo)     →   infraestrutura, mantida e evoluída
      ↓ ms-template/
msImprobidade/            →   pacote R + .claude/ enxuto + CLAUDE.md do artigo
msListagem/               →   pacote R + .claude/ enxuto + CLAUDE.md do artigo
```

### Convenção de nomenclatura

Artigos seguem o padrão `msNome` — prefixo `ms` (manuscript) + nome do projeto. Tudo que não seguir esse padrão não é artigo.

### Criar um novo artigo

```bash
~/documents/github/my-claude/scripts/new-manuscript.sh
```

O script pergunta nome, título e RQ — depois cria o pacote R, copia o `.claude/`, preenche os placeholders, inicializa git e cria o repositório privado no GitHub.

---

## Core Principles

- **Plan first** -- enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** -- render and confirm output at the end of every task
- **Quality gates** -- nothing ships below 80/100
- **[LEARN] tags** -- when corrected, save `[LEARN:category] wrong → right` to [MEMORY.md](MEMORY.md)

Cross-session context lives in [MEMORY.md](MEMORY.md); past plans, specs, and session logs are in [quality_reports/](quality_reports/).

---

## Folder Structure

```
my-claude/
├── CLAUDE.md                    # Este arquivo
├── .claude/                     # Rules, skills, agents, hooks
├── ms-template/                 # Template para novos artigos (msNome)
├── Quarto/                      # Slides ocasionais em RevealJS
├── docs/                        # GitHub Pages (auto-generated)
├── scripts/                     # Scripts utilitários
├── quality_reports/             # Plans, session logs, merge reports
├── explorations/                # Research sandbox
├── templates/                   # Templates de sessão, spec, decisions
└── master_supporting_docs/      # Papers e slides de apoio
```

---

## Commands

```bash
# Deploy Quarto para GitHub Pages
./scripts/sync_to_docs.sh arquivo

# Quality score
python scripts/quality_score.py Quarto/file.qmd

# Surface-count sync (README ↔ CLAUDE.md ↔ guide)
./scripts/check-surface-sync.sh
```

---

## Quality Thresholds (advisory)

| Score | Checkpoint | Meaning |
|-------|------|---------|
| 80 | Commit | Good enough to save |
| 90 | PR | Ready for deployment |
| 95 | Excellence | Aspirational |

Enforced by `/commit` (halts + asks for override); not enforced by a git pre-commit hook.

---

## Skills Quick Reference

### Análise de dados e R

| Command | What It Does |
|---------|-------------|
| `/data-analysis [dataset]` | End-to-end R analysis pipeline |
| `/review-r [file]` | R code quality review |
| `/r-package-check [pkg path]` | R package release gate: document + tests + R CMD check |
| `/simulation-study [estimator+DGP]` | Reproducible Monte Carlo study |
| `/audit-reproducibility [paper]` | Enforce replication tolerance thresholds on paper ↔ code |

### Escrita acadêmica

| Command | What It Does |
|---------|-------------|
| `/review-paper [file]` | Manuscript review (single-pass / `--adversarial` / `--peer <journal>`) |
| `/respond-to-referees [report] [manuscript]` | R&R cross-reference + response draft |
| `/seven-pass-review` | Seven-pass adversarial manuscript review (parallel forked subagents) |
| `/verify-claims [file]` | Chain-of-Verification fact-check (forked verifier, fresh context) |
| `/proofread [file]` | Grammar/typo review |
| `/humanize [file]` | Detect AI-voice tells in academic prose |
| `/lit-review [topic]` | Literature search + synthesis |
| `/research-ideation [topic]` | Research questions + strategies |
| `/interview-me [topic]` | Interactive research interview |
| `/preregister [--style osf|aspredicted|aea-rct]` | Draft a preregistration document |

### Slides (uso ocasional)

| Command | What It Does |
|---------|-------------|
| `/deploy [arquivo]` | Render Quarto + sync to docs/ |
| `/qa-quarto [arquivo]` | Adversarial Quarto QA |
| `/visual-audit [file]` | Slide layout audit |
| `/pedagogy-review [file]` | Narrative, notation, pacing review |

### Workflow e infraestrutura

| Command | What It Does |
|---------|-------------|
| `/commit [msg]` | Stage, commit, PR, merge |
| `/context-status` | Show session health + context usage |
| `/checkpoint [topic]` | Save structured state snapshot before stopping or handing off |
| `/compress-session [slug]` | Distil current session into structured notes before auto-compaction |
| `/promote-memory [filter]` | Five-critic council that votes on which `[LEARN]` entries graduate to MEMORY.md |
| `/permission-check` | Diagnose permission layers when prompts fire unexpectedly |
| `/deep-audit` | Repository-wide consistency audit |
| `/learn [skill-name]` | Extract discovery into persistent skill |
| `/prompt [text] [depth:light|standard|deep]` | Reformat informal input into a structured prompt, then execute |
| `/prompt-only [text] [depth] [--save path]` | Same as `/prompt`, but emits the prompt as a reusable artifact (no execution) |

---

## Quarto CSS Classes

| Class | Effect | Use Case |
| --- | --- | --- |
| `.smaller` | 85% font | Dense content |
| `.positive` | Green bold | Good annotations |
