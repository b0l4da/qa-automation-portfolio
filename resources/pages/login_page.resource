*** Settings ***
Documentation     Page Object da tela de login.
Library           SeleniumLibrary

*** Variables ***
${CAMPO_USUARIO}      id:user-name
${CAMPO_SENHA}        id:password
${BOTAO_LOGIN}        id:login-button
${MENSAGEM_ERRO}      css:[data-test="error"]

*** Keywords ***
Fazer Login
    [Arguments]    ${usuario}    ${senha}
    Input Text        ${CAMPO_USUARIO}    ${usuario}
    Input Password    ${CAMPO_SENHA}      ${senha}
    Click Button      ${BOTAO_LOGIN}

Validar Mensagem De Erro
    [Arguments]    ${texto_esperado}
    Wait Until Element Is Visible    ${MENSAGEM_ERRO}
    Element Should Contain    ${MENSAGEM_ERRO}    ${texto_esperado}
