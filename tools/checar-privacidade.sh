#!/usr/bin/env bash
# Varre páginas e histórico do git atrás das strings proibidas.
# Lista real (valores da máquina onde as saídas foram colhidas) fica FORA do repo:
#   ../.proibido-go.txt   (ou PROIBIDO=caminho)
# Se o arquivo existir, as linhas dele entram na conferência, além
# dos padrões embutidos (genéricos: MAC, GUID, IPv4 fora dos ilustrativos,
# /home/<nome> que não seja ana, /Users/<nome>, C:\Users\<nome>, a pasta de trabalho da coleta).
# Os nomes reais (computador, usuário, IPs) NÃO ficam neste script:
# ficam só no arquivo de fora do repo.
# "re:" = expressão regular (grep -P), sem diferenciar maiúsculas.
set -u
cd "$(dirname "$0")/.."
LISTA="${PROIBIDO:-../.proibido-go.txt}"

padroes=()
# --- padrões embutidos genéricos (sempre; sem valores da máquina) ---
# MAC (seis pares hex separados por : ou -)
padroes+=("re:\\b([0-9a-f]{2}[:-]){5}[0-9a-f]{2}\\b")
# GUID/UUID
padroes+=("re:\\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\\b")
# IPv4: bloqueia endereços, mas libera 127.* (localhost), 0.0.0.0, 255.*,
# 192.168.0.* (ilustrativo do guia) e números de versão em contexto "go1.x" não casam (só 3 partes).
padroes+=("re:(?<![\\d.])(?!192\\.168\\.0\\.|127\\.|255\\.|0\\.0\\.0\\.0(?![\\d.]))(?:25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]\\d?)\\.(\\d{1,3}\\.){2}\\d{1,3}(?![\\d.])")
# Pastas pessoais que não sejam da usuária fictícia ana
padroes+=("re:/home/(?!ana\\b)[a-z_][a-z0-9_-]*")
padroes+=("re:/Users/(?!ana\\b)[A-Za-z][^/\\s\"<>]*")
padroes+=("re:C:\\\\Users\\\\(?!ana\\b|Public\\b|Default\\b)[^\\\\s\\\\/<>\"]+")
# Pasta de trabalho da máquina de coleta
padroes+=("re:/work[s]pace\\b")

if [ -f "$LISTA" ]; then
  echo "Usando lista $LISTA (além dos padrões embutidos)."
  while IFS= read -r linha || [ -n "$linha" ]; do
    [[ -z "$linha" || "$linha" == \#* ]] && continue
    padroes+=("$linha")
  done < "$LISTA"
else
  echo "Lista $LISTA não encontrada; usando só os padrões embutidos."
fi

falhou=0
for pad0 in "${padroes[@]}"; do
  if [[ "$pad0" == re:* ]]; then pad="${pad0#re:}"; opt=(-P -i); else pad="$pad0"; opt=(-F -i); fi
  achou=$(grep -rn "${opt[@]}" --include='*.html' --include='*.js' --include='*.md' --include='*.css' --include='*.txt' --include='*.go' --include='*.json' --include='*.mod' --exclude-dir=.git --exclude-dir=_saidas --exclude-dir=node_modules -e "$pad" . | head -5)
  hist=$(git log --all -p 2>/dev/null | grep -c "${opt[@]}" -e "$pad")
  if [ -n "$achou" ] || [ "$hist" != "0" ]; then
    falhou=1; echo "FALHA: $pad (histórico: $hist)"; [ -n "$achou" ] && echo "$achou"
  fi
done
[ $falhou = 0 ] && echo "OK: nenhuma string proibida nas páginas nem no histórico."
exit $falhou
