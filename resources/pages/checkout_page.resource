*** Settings ***
Documentation     Page Object das etapas de checkout.
Library           SeleniumLibrary

*** Variables ***
${CAMPO_NOME}         id:first-name
${CAMPO_SOBRENOME}    id:last-name
${CAMPO_CEP}          id:postal-code
${BOTAO_CONTINUAR}    id:continue
${BOTAO_FINALIZAR}    id:finish
${MENSAGEM_FINAL}     css:[data-test="complete-header"]

*** Keywords ***
Preencher Dados Do Comprador
    [Arguments]    ${nome}    ${sobrenome}    ${cep}
    Input Text    ${CAMPO_NOME}         ${nome}
    Input Text    ${CAMPO_SOBRENOME}    ${sobrenome}
    Input Text    ${CAMPO_CEP}          ${cep}
    Click Button    ${BOTAO_CONTINUAR}

Finalizar Compra
    Click Button    ${BOTAO_FINALIZAR}

Validar Compra Concluida
    Wait Until Element Is Visible    ${MENSAGEM_FINAL}
    Element Text Should Be    ${MENSAGEM_FINAL}    Thank you for your order!
