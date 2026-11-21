# Guia Go

Curso de **Go (Golang)** em português do Brasil, do zero ao avançado, em páginas estáticas (HTML + CSS + JS, sem build). Cada aula explica um assunto, mostra o código inteiro e a **saída real** do terminal, colhida rodando o programa com Go 1.27.3 (`linux/amd64`).

- **Nível 1 · Iniciante:** instalação, olá mundo, `go run` e `go build`, módulos, erros de compilação, variáveis, constantes, tipos, conversão, `fmt.Printf`, `if`, `for`, `switch`, `defer`, arrays, slices, maps, strings e runes, funções, múltiplos retornos, `error`, structs e métodos.
- **Nível 2 · Intermediário:** ponteiros, interfaces, generics, pacotes e módulos, `embed`, `go test`, tabela de testes, `errors.Is`/`errors.As`, `panic`/`recover`, arquivos com `os` e `bufio`, JSON.
- **Nível 3 · Avançado:** goroutines, channels, `select`, `sync`, `context`, servidor HTTP, `go vet` e `gofmt`, benchmarks, build cruzado.

## Como usar

Abra o `index.html` no navegador ou publique a pasta no GitHub Pages. Nas caixas **Missão**, copie o código, salve como `main.go`, rode com `go run main.go` no seu computador e cole a saída: a página confere metas de código e de saída. Nada do que você cola sai da página (sem rede, sem armazenamento).

## Regras do guia

- Saídas sempre reais, nunca inventadas; mensagens de erro do Go nunca traduzidas.
- Saídas anonimizadas: usuária `ana`, computador `notebook`, projetos em `~/projetos`, Go em `~/go`.
- Veja [CONTRIBUINDO.md](CONTRIBUINDO.md) para escrever ou testar uma aula.
