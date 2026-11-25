*** Settings ***
Documentation     Page Object da vitrine de produtos e do carrinho.
Library           SeleniumLibrary

*** Variables ***
${TITULO_PAGINA}      css:[data-test="title"]
${ICONE_CARRINHO}     css:[data-test="shopping-cart-link"]
${CONTADOR}           css:[data-test="shopping-cart-badge"]
${BOTAO_CHECKOUT}     id:checkout

*** Keywords ***
Validar Que Esta Na Vitrine
    Wait Until Element Is Visible    ${TITULO_PAGINA}
    Element Text Should Be    ${TITULO_PAGINA}    Products

Adicionar Produto Ao Carrinho
    [Arguments]    ${id_produto}
    Click Button    id:add-to-cart-${id_produto}

Validar Quantidade No Carrinho
    [Arguments]    ${quantidade}
    Element Text Should Be    ${CONTADOR}    ${quantidade}

Ir Para O Carrinho
    Click Element    ${ICONE_CARRINHO}

Iniciar Checkout
    Click Button    ${BOTAO_CHECKOUT}
