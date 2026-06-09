# CLAUDE.MD -- [MS_NOME]

**Artigo:** [TÍTULO DO ARTIGO]
**Autor:** Ricardo Feliz Okamoto — FD USP
**RQ principal:** [PERGUNTA DE PESQUISA PRINCIPAL]
**Branch:** main

---

## Estrutura do projeto

Este artigo segue a estrutura de **pacote R**:

```
msNome/
├── CLAUDE.md                  # Este arquivo
├── DESCRIPTION                # Metadados do pacote R
├── NAMESPACE                  # Gerado por devtools::document()
├── .claude/                   # Infraestrutura Claude Code
├── R/                         # Funções do pacote
├── data/                      # Dados processados (usethis::use_data())
├── data-raw/                  # Scripts de processamento dos dados brutos
├── man/                       # Documentação (gerada por roxygen2)
├── paper/                     # Manuscrito em Quarto (.qmd)
├── quality_reports/           # Plans, session logs
└── tests/                     # Testes do pacote
```

---

## Core Principles

- **Plan first** -- enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** -- render e confirmar output ao final de cada tarefa
- **Quality gates** -- nothing ships below 80/100
- **[LEARN] tags** -- when corrected, save `[LEARN:category] wrong → right` to MEMORY.md

---

## Convenções de dados

- Dados brutos ficam em `data-raw/` com script de processamento
- Dados processados e finais ficam em `data/` via `usethis::use_data(nome_do_objeto)`
- A base principal do artigo fica em `data/` como objeto R documentado
- Documentar todas as bases em `R/data.R`

---

## Manuscrito

- Arquivo principal: `paper/msNome.qmd`
- Referências: `paper/references.bib`
- Tabelas e figuras geradas pelos scripts R são salvas em `paper/outputs/`

---

## Skills disponíveis

### Análise de dados e R

| Command | What It Does |
|---------|-------------|
| `/data-analysis [dataset]` | End-to-end R analysis pipeline |
| `/review-r [file]` | R code quality review |
| `/r-package-check` | R package release gate: document + tests + R CMD check |
| `/simulation-study [estimator+DGP]` | Reproducible Monte Carlo study |
| `/audit-reproducibility [paper]` | Enforce replication tolerance thresholds on paper ↔ code |

### Escrita acadêmica

| Command | What It Does |
|---------|-------------|
| `/review-paper [file]` | Manuscript review (single-pass / `--adversarial` / `--peer <journal>`) |
| `/respond-to-referees [report] [manuscript]` | R&R cross-reference + response draft |
| `/seven-pass-review` | Seven-pass adversarial manuscript review |
| `/verify-claims [file]` | Chain-of-Verification fact-check |
| `/proofread [file]` | Grammar/typo review |
| `/humanize [file]` | Detect AI-voice tells in academic prose |
| `/lit-review [topic]` | Literature search + synthesis |
| `/research-ideation [topic]` | Research questions + strategies |
| `/interview-me [topic]` | Interactive research interview |
| `/preregister [--style osf|aspredicted|aea-rct]` | Draft a preregistration document |

### Workflow

| Command | What It Does |
|---------|-------------|
| `/commit [msg]` | Stage, commit, PR, merge |
| `/checkpoint [topic]` | Save structured state snapshot |
| `/context-status` | Show session health + context usage |
