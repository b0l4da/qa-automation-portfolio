*** Settings ***
Documentation     Testes de API (CRUD de reservas) na Restful Booker.
Library           RequestsLibrary
Library           Collections
Suite Setup       Criar Sessao E Gerar Token

*** Variables ***
${API_URL}        https://restful-booker.herokuapp.com
${TOKEN}          ${EMPTY}
${BOOKING_ID}     ${EMPTY}

*** Test Cases ***
Health check da API
    [Tags]    api    smoke
    ${resp}=    GET On Session    booker    /ping    expected_status=201

Criar reserva
    [Tags]    api
    ${datas}=    Create Dictionary    checkin=2026-12-27    checkout=2027-01-03
    ${corpo}=    Create Dictionary    firstname=Flavia    lastname=Fernandes
    ...    totalprice=${1500}    depositpaid=${True}    bookingdates=${datas}    additionalneeds=Breakfast
    ${resp}=    POST On Session    booker    /booking    json=${corpo}    expected_status=200
    Dictionary Should Contain Key    ${resp.json()}    bookingid
    Should Be Equal    ${resp.json()}[booking][firstname]    Flavia
    Set Suite Variable    ${BOOKING_ID}    ${resp.json()}[bookingid]

Consultar reserva criada
    [Tags]    api
    ${resp}=    GET On Session    booker    /booking/${BOOKING_ID}    expected_status=200
    Should Be Equal    ${resp.json()}[lastname]    Fernandes
    Should Be Equal As Numbers    ${resp.json()}[totalprice]    1500

Atualizar preço da reserva
    [Tags]    api
    ${headers}=    Create Dictionary    Cookie=token=${TOKEN}
    ${corpo}=    Create Dictionary    totalprice=${1800}
    ${resp}=    PATCH On Session    booker    /booking/${BOOKING_ID}    json=${corpo}    headers=${headers}    expected_status=200
    Should Be Equal As Numbers    ${resp.json()}[totalprice]    1800

Excluir reserva sem token deve ser negado
    [Tags]    api    negativo
    DELETE On Session    booker    /booking/${BOOKING_ID}    expected_status=403

Excluir reserva com token
    [Tags]    api
    ${headers}=    Create Dictionary    Cookie=token=${TOKEN}
    DELETE On Session    booker    /booking/${BOOKING_ID}    headers=${headers}    expected_status=201
    GET On Session    booker    /booking/${BOOKING_ID}    expected_status=404

*** Keywords ***
Criar Sessao E Gerar Token
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    booker    ${API_URL}    headers=${headers}
    ${credenciais}=    Create Dictionary    username=admin    password=password123
    ${resp}=    POST On Session    booker    /auth    json=${credenciais}    expected_status=200
    Set Suite Variable    ${TOKEN}    ${resp.json()}[token]
