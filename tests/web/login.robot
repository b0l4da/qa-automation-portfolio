*** Settings ***
Documentation     Testes de login: cenário feliz e cenários negativos (data-driven).
Resource          ../../resources/common.resource
Resource          ../../resources/pages/login_page.resource
Resource          ../../resources/pages/products_page.resource
Test Setup        Abrir Navegador
Test Teardown     Fechar Navegador

*** Test Cases ***
Login com usuário válido
    [Tags]    smoke    login
    Fazer Login    standard_user    secret_sauce
    Validar Que Esta Na Vitrine

Login com usuário bloqueado
    [Tags]    login    negativo
    Fazer Login    locked_out_user    secret_sauce
    Validar Mensagem De Erro    Sorry, this user has been locked out.

Login com senha incorreta
    [Tags]    login    negativo
    Fazer Login    standard_user    senha_errada
    Validar Mensagem De Erro    Username and password do not match

Login sem preencher usuário
    [Tags]    login    negativo
    Fazer Login    ${EMPTY}    secret_sauce
    Validar Mensagem De Erro    Username is required
