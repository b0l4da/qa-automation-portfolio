*** Settings ***
Documentation     Fluxo E2E de compra escrito em Gherkin (Dado / Quando / Então).
Resource          ../../resources/common.resource
Resource          ../../resources/pages/login_page.resource
Resource          ../../resources/pages/products_page.resource
Resource          ../../resources/pages/checkout_page.resource
Test Setup        Abrir Navegador
Test Teardown     Fechar Navegador

*** Test Cases ***
Cliente compra dois produtos com sucesso
    [Tags]    e2e    regressao
    Dado que o cliente está logado na loja
    Quando adiciona a mochila e a lanterna ao carrinho
    E finaliza a compra com seus dados
    Então a compra é concluída com sucesso

*** Keywords ***
Dado que o cliente está logado na loja
    Fazer Login    standard_user    secret_sauce
    Validar Que Esta Na Vitrine

Quando adiciona a mochila e a lanterna ao carrinho
    Adicionar Produto Ao Carrinho    sauce-labs-backpack
    Adicionar Produto Ao Carrinho    sauce-labs-bike-light
    Validar Quantidade No Carrinho    2

E finaliza a compra com seus dados
    Ir Para O Carrinho
    Iniciar Checkout
    Preencher Dados Do Comprador    Flavia    Fernandes    09500-000
    Finalizar Compra

Então a compra é concluída com sucesso
    Validar Compra Concluida
