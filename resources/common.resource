*** Settings ***
Documentation     Configuração comum dos testes web (abrir/fechar navegador).
Library           SeleniumLibrary    timeout=10s    implicit_wait=0s

*** Variables ***
${BASE_URL}       https://www.saucedemo.com
${BROWSER}        headlesschrome

*** Keywords ***
Abrir Navegador
    Open Browser    ${BASE_URL}    ${BROWSER}
    Set Window Size    1366    768

Fechar Navegador
    Capture Page Screenshot
    Close All Browsers
