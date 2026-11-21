# Contribuindo com o Guia Go

## Estrutura

- `assets/site.js` — `NIVEIS` é a única fonte do menu, do selo de nível, do Anterior/Próximo e do mapa da capa. Página sem arquivo leva `{ pronta: false }` (o menu mostra "em breve"); no guia publicado nenhuma página fica assim.
- `assets/rode-local.js` — caixas `.trycmd` (Missão): editor com o código inicial, "Copiar código", campo para colar a saída, "Conferir" e "Ver solução".
- `assets/style.css`, `assets/rode-local.css` — visual.
- `tools/` — testadores e checador de privacidade.

## Padrão de aula

`h1` → `p.intro` → `div.note` "Você vai aprender" → nota "Sobre as saídas" → seções (`hr` + `h2`) com `pre.file` (código, `data-file="main.go"`) e `pre.term` (sessão: linhas `$ comando` seguidas da saída real; `data-cwd="~/projetos/<pasta>"`) → `dl.anatomy` quando ajudar → "Quando dá errado" (`div.cenario` com o erro real) → "Referência rápida" (`table.ref`) → "Exercícios" (`div.exercise` com `input[data-answer]`, `div.mc`) → missões → "Resumo".

## Missões (`div.trycmd`)

```html
<div class="trycmd" data-goal="src:fmt\.Println;;out:Olá, Go!;;semerro">
<p class="try-task"><strong>Missão:</strong> …</p>
<pre class="script" data-file="main.go">código inicial (NÃO pode cumprir as metas src)</pre>
<pre class="solucao" data-file="main.go">uma solução</pre>
<pre class="saida-ok" data-file="main.go" hidden>saída REAL da solução</pre>
</div>
```

Metas separadas por `;;`:

| Meta | Confere |
|---|---|
| `src:REGEX` | o código (editor) casa com a regex (diferencia maiúsculas) |
| `out:TEXTO` | a saída colada contém o texto |
| `outre:REGEX` | a saída casa com a regex (modo multilinha) |
| `erro:TEXTO` | a saída contém a mensagem de erro |
| `semerro` | a saída não tem cara de erro do Go (`arquivo.go:L:C:`, `panic:`, `exit status`, `go: …`) |

Use `data-cmd="go run ."` (ou outro) no `pre.script` quando o comando não for `go run main.go`. As metas de saída precisam valer no computador de quem estuda (não dependa de caminho, hora ou versão exata).

## Antes de cada commit

```bash
node tools/testar-missoes.js
timeout 3600 node tools/testar-navegador.js --todas -q   # puppeteer-core: tools/node_modules ou PUPPETEER_DIR; CHROMIUM=/usr/bin/google-chrome
PROIBIDO=../.proibido-go.txt bash tools/checar-privacidade.sh
```

Commits só com `git add` explícito, autor `Wallysondevs <wallysondevs@users.noreply.github.com>`. `_saidas/` e `_saidas-anon/` não são versionadas.
