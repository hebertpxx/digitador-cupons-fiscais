*** Settings ***
Documentation       Robô que preenche formulário com base em um arquivo excel

Library             RPA.Browser.Selenium    auto_close=${FALSE}
Library             RPA.HTTP
Library             RPA.Excel.Files
Library             RPA.Windows
Library             RPA.PDF


*** Tasks ***
Abrir navegador e fazer logon
    Abrir Site Notabe
    Logon
    Preencher e Enviar Formulário Tendo Arquivo Excel como Fonte de Dados


*** Keywords ***
Abrir Site Notabe
    Open Available Browser    http://paoevida.notabe.com/    maximized=${TRUE}

Logon
    Click Link    alias:Entrar
    Input Text    user_email    email@email.com
    Input Password    user_password    senha
    Submit Form

Preencher e Enviar Formulário
    [Arguments]    ${bar_code}
    Go To    http://paoevida.notabe.com/
    Click Element    alias:DigitarNotas
    Click Element    alias:Rkindbtnnthchild1
    Wait Until Element Is Visible    barcode
    Input Text    barcode    ${bar_code}[CODE]
    Click Element    alias:Buttonidsubmit

Preencher e Enviar Formulário Tendo Arquivo Excel como Fonte de Dados
    Open Workbook    CFe.xlsx
    ${bar_codes}=    Read Worksheet As Table    header=${TRUE}
    Close Workbook
    FOR    ${bar_code}    IN    @{bar_codes}
        Preencher e Enviar Formulário    ${bar_code}
    END

Logout e Fechar Navegador
    Close Browser
