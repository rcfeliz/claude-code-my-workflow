#!/usr/bin/env bash
set -euo pipefail

INFRA_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASE_DIR="$HOME/documents/github"

# ── cores ──────────────────────────────────────────────────────────────────
BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BOLD}=== Novo artigo (msNome) ===${NC}\n"

# ── 1. coletar informações ──────────────────────────────────────────────────
while true; do
  read -rp "Nome do manuscript (deve começar com 'ms', ex: msImprobidade): " MS_NOME
  if [[ "$MS_NOME" =~ ^ms[A-Za-z] ]]; then
    break
  fi
  echo -e "${RED}Nome inválido. Deve começar com 'ms' seguido de letra (ex: msImprobidade).${NC}"
done

REPO_DIR="$BASE_DIR/$MS_NOME"

if [[ -d "$REPO_DIR" ]]; then
  echo -e "${RED}Pasta $REPO_DIR já existe. Abortando.${NC}"
  exit 1
fi

read -rp "Título do artigo: " TITULO
while [[ -z "$TITULO" ]]; do
  echo -e "${RED}Título não pode ser vazio.${NC}"
  read -rp "Título do artigo: " TITULO
done

echo ""
echo -e "${BOLD}Resumo:${NC}"
echo -e "  Repositório : ${GREEN}$MS_NOME${NC}"
echo -e "  Título      : $TITULO"
echo -e "  Pasta       : $REPO_DIR"
echo ""
read -rp "Confirmar? [s/N] " CONFIRM
if [[ ! "$CONFIRM" =~ ^[sS]$ ]]; then
  echo "Abortado."
  exit 0
fi

# ── 2. criar pacote R ───────────────────────────────────────────────────────
echo -e "\n${YELLOW}Criando pacote R...${NC}"
Rscript -e "usethis::create_package('$REPO_DIR', open = FALSE)"

# ── 3. copiar infraestrutura Claude ────────────────────────────────────────
echo -e "${YELLOW}Copiando infraestrutura Claude...${NC}"
cp -r "$INFRA_DIR/ms-template/.claude" "$REPO_DIR/"
cp "$INFRA_DIR/ms-template/CLAUDE.md" "$REPO_DIR/"

# ── 4. substituir placeholders ─────────────────────────────────────────────
echo -e "${YELLOW}Preenchendo CLAUDE.md...${NC}"
TITULO_ESC=$(printf '%s\n' "$TITULO" | sed 's/[[\.*^$()+?{|]/\\&/g')
MS_ESC=$(printf '%s\n' "$MS_NOME" | sed 's/[[\.*^$()+?{|]/\\&/g')

sed -i \
  -e "s/\[MS_NOME\]/$MS_ESC/g" \
  -e "s/\[TÍTULO DO ARTIGO\]/$TITULO_ESC/g" \
  -e "s/msNome/$MS_ESC/g" \
  "$REPO_DIR/CLAUDE.md"

# ── 5. git init + commit inicial ───────────────────────────────────────────
echo -e "${YELLOW}Inicializando git...${NC}"
git -C "$REPO_DIR" init -b main
git -C "$REPO_DIR" add .
git -C "$REPO_DIR" commit -m "chore: estrutura inicial $MS_NOME"

# ── 6. criar repo no GitHub e push ─────────────────────────────────────────
if command -v gh &>/dev/null; then
  echo -e "${YELLOW}Criando repositório no GitHub (privado)...${NC}"
  gh repo create "$MS_NOME" --private --source "$REPO_DIR" --remote origin --push
  echo -e "${GREEN}Repositório disponível em: $(gh repo view "$MS_NOME" --json url -q .url)${NC}"
else
  echo -e "${YELLOW}gh não encontrado — pulando criação no GitHub.${NC}"
  echo -e "Para criar manualmente: gh repo create $MS_NOME --private --source $REPO_DIR --remote origin --push"
fi

# ── 7. criar pastas padrão do artigo ───────────────────────────────────────
mkdir -p "$REPO_DIR/data-raw" "$REPO_DIR/inst/artigo" "$REPO_DIR/inst/quality_reports/plans"
echo "# dados brutos — processar aqui e salvar em data/ via usethis::use_data()" \
  > "$REPO_DIR/data-raw/README.md"
git -C "$REPO_DIR" add .
git -C "$REPO_DIR" commit -m "chore: pastas padrão do artigo"
git -C "$REPO_DIR" push 2>/dev/null || true

echo -e "\n${GREEN}${BOLD}Pronto! $MS_NOME criado em $REPO_DIR${NC}"
echo -e "Iniciando entrevista de pesquisa...\n"
cd "$REPO_DIR" && claude "/interview-me $TITULO"
