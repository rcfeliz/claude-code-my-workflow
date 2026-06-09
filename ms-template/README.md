# ms-template

Template para novos artigos (`msNome`) de Ricardo Feliz Okamoto.

## Como usar

```r
# 1. Criar o pacote R
usethis::create_package("~/documents/github/msNome")
```

```bash
# 2. Copiar infraestrutura Claude Code
cp -r ~/documents/github/my-claude/ms-template/.claude msNome/
cp ~/documents/github/my-claude/ms-template/CLAUDE.md msNome/
```

```
# 3. Personalizar CLAUDE.md
# Substituir: [MS_NOME], [TÍTULO DO ARTIGO], [PERGUNTA DE PESQUISA PRINCIPAL]
```

```r
# 4. Estrutura recomendada de pastas
usethis::use_data_raw("nome_da_base")   # cria data-raw/
# ... processar dados ...
usethis::use_data(nome_da_base)         # salva em data/
```

## Estrutura do .claude/

- `skills/` — skills relevantes para artigos (análise R, escrita, revisão)
- `rules/` — convenções de R, replicação, pacotes, qualidade
- `agents/` — agentes para revisão de manuscrito e código R
- `settings.json` — permissões básicas
