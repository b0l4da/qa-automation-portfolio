# QA Automation Portfolio

Projeto de automação de testes web e de API com **Python, Robot Framework, Selenium, Gherkin e Postman**, rodando em **CI com GitHub Actions**.

Autora: Flavia Ferreira Fernandes · [LinkedIn](https://linkedin.com/in/fl4viaffernandes)

## O que tem aqui

| Tipo | Ferramentas | Onde |
|---|---|---|
| Testes web (login, cenários negativos) | Robot Framework + SeleniumLibrary, padrão **Page Object** | `tests/web/login.robot` |
| Teste E2E de compra em **Gherkin** (Dado/Quando/Então) | Robot Framework | `tests/web/checkout.robot` |
| Testes de API (CRUD, autenticação, cenário negativo) | Robot Framework + RequestsLibrary | `tests/api/booking.robot` |
| Coleção de API com asserções | Postman / Newman | `postman/` |
| Pipeline de CI | GitHub Actions | `.github/workflows/tests.yml` |

Sistemas testados (públicos, feitos para treino de QA):
- Web: [saucedemo.com](https://www.saucedemo.com)
- API: [Restful Booker](https://restful-booker.herokuapp.com/apidoc/index.html)

## Estrutura

```
resources/
  common.resource            # abrir/fechar navegador
  pages/                     # Page Objects (um arquivo por tela)
    login_page.resource
    products_page.resource
    checkout_page.resource
tests/
  web/                       # testes de interface
  api/                       # testes de API
postman/                     # coleção Postman
.github/workflows/tests.yml  # CI
```

**Por que Page Object?** Os localizadores e ações de cada tela ficam num só lugar. Se a tela muda, ajusta-se um arquivo, não todos os testes.

## Como rodar localmente

```bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt

robot --outputdir results tests/          # tudo
robot --outputdir results --include smoke tests/   # só smoke
robot --variable BROWSER:chrome tests/web          # ver o navegador abrindo
```

Abra `results/report.html` para ver o relatório.

Postman: importe `postman/restful-booker.postman_collection.json` e rode a coleção em ordem, ou:

```bash
npx newman run postman/restful-booker.postman_collection.json
```

## Tipos de teste cobertos

- Funcional e regressão (login, compra)
- Negativos (usuário bloqueado, senha errada, campo vazio, exclusão sem token)
- E2E (fluxo completo de compra)
- API: status code, contrato da resposta, autenticação por token, tempo de resposta
