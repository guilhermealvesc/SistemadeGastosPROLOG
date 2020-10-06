:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).

:- ensure_loaded(temp(bootstrap)).
:- use_module('./backend/db/schemas/funcionario.pl').

cadastro(_):-
    reply_html_page(
        bootstrap,
        [ title('Controle de Gastos de Clientes | Funcionario'), \html_requires(css('admin/cadastros/funcionarios/cadastro.css'))],
        [ \navbarCadFun, \pageCadFun ]).

navbarCadFun --> 
    html(nav([class('navbar navbar-expand-lg navbar-light bg-light')], 
    [button([class('navbar-toggler'), type(button), 'data-toogle'(collapse), 'data-target'('#header'), 'aria-controls'(header),
    'aria-expanded'(false), 'aria-label'('Toggle navigation')], [span([class('navbar-toggler-icon')], [])]), 
    div([class('collapse navbar-collapse'), id(header)],
    [div([class('navbar-nav')], 
    [a([class('nav-link'), href('./cadastros')], ['Cadastros']), 
        a([class('nav-link'), href('./material')], ['Material']), 
        a([class('nav-link'), href('./ordemservico')], ['Ordem de Servico']), 
        a([class('nav-link'), href('./consultas')], ['Consultas']), 
        a([class('nav-link'), href('./sobre')], ['Sobre']), 
        a([class('nav-link'), href('./ajuda')], ['Ajuda'])
    ])])])).

pageCadFun -->
    html(div([class('main-content')],
            [h5('Funcionario'), 
            \navpageCadFun,
            div([class('row info')], [
                div([class('col-lg-10 col-md-10')], [
                    div([class(search)], [
                        form([method(get)], [
                            label([for(type)], 'Pesquisar: '),
                            select([name(type), id(type)], [
                                option([value(material)], 'Funcionario'),
                                option([value(estoque)], 'Usuario'),
                                option([value(servico)], 'Funcao')
                            ]),
                            input([type(text)], []),
                            input([type(button), value('Buscar')], [])
                        ])
                    ]),
                    form([method('post'), action('/cadfun')], [
                        div([class('form-group')], [
                            label([for(nome)], 'Nome'),
                            input([name(nome), type(text), class('form-control'), id(nome), placeholder('')], [])
                        ]),
                        div([class('form-group')], [
                            label([for(usuario)], 'Usuario'),
                            input([name(user) ,type(text), class('form-control'), id(usuario), placeholder('')], [])
                        ]),
                        div([class('form-group')], [
                            label([for(senha)], 'Senha'),
                            input([name(password), type(password), class('form-control'), id(senha), placeholder('')], [])
                        ]),
                        div([class('form-group')], [
                            label([for(inputState)], 'Funcao'),
                            select([name(func), id('inputState'), class('form-control')], [
                                option([value(1), selected], 'Administrador'),
                                option([value(2)], 'Balconista'),
                                option([value(3)], 'Bolsista'),
                                option([value(4)], 'Gerente'),
                                option([value(5)], 'Motoboy')
                            ]),
                            hr([]),
                            div([class(row)], [
                                div([class(col)], [
                                    label([for(rua)], 'Rua'),
                                    input([name(address), type(text), class('form-control'), id(rua), placeholder('')], [])
                                ]),
                                div([class(col)], [
                                    label([for(numero)], 'Numero'),
                                    input([name(addressnum) ,type(number), class('form-control'), id(numero), placeholder('')], [])
                                ])
                            ]),
                            label([for(complemento)], 'Complemento'),
                            input([name(comp), type(text), class('form-control'), id(complemento), placeholder('')], []),
                            div([class(row)], [
                                div([class(col)], [
                                    label([for(bairro)], 'Bairro'),
                                    input([name(bairro), type(text), class('form-control'), id(bairro), placeholder('')], [])
                                ]),
                                div([class(col)], [
                                    label([for(cidade)], 'Cidade'),
                                    input([name(city), type(text), class('form-control'), id(cidade), placeholder('')], [])
                                ])
                            ]),
                            div([class(row)], [
                                div([class(col)], [
                                    label([for(cep)], 'CEP'),
                                    input([name(cep), type(text), class('form-control'), id(cep), placeholder('')], [])
                                ])
                            ]),
                            div([class(row)], [
                                div([class(col)], [
                                    label([for(telefone1)], 'Telefone 1'),
                                    input([name(tel1), type(text), class('form-control'), id(telefone1), placeholder('')], [])
                                ]),
                                div([class(col)], [
                                    label([for(telefone2)], 'Telefone 2'),
                                    input([name(tel2), type(text), class('form-control'), id(telefone2), placeholder('')], [])
                                ])
                            ])
                        ]),
                        button([type(submit), class('btn btn-light')], 'Submit')
                    ])
                ]),
                \buttonsCadFun
            ])])).

navpageCadFun --> 
    html(nav([class('navbar navbar-expand-lg navbar-light bg-light')], 
    [button([class('navbar-toggler'), type(button), 'data-toogle'(collapse), 'data-target'('#page'), 'aria-controls'(page),
    'aria-expanded'(false), 'aria-label'('Toggle navigation')], [span([class('navbar-toggler-icon')], [])]), 
    div([class('collapse navbar-collapse'), id(page)],
    [div([class('navbar-nav')], 
    [a([class('nav-link'), href('./relatorio')], ['Relatorio']), 
    a([class('nav-link'), href('./cadastro')], ['Cadastro']) 
    ])])])).

buttonsCadFun --> 
    html(div([class('buttons col-lg-2 col-md-2 lado')], [
        button([class('btn btn-light'), disabled(disabled)], 'Confirmar'),
        button([class('btn btn-light'), disabled(disabled)], 'Cancelar'),
        button([class('btn btn-light')], '+ Incluir'),
        button([class('btn btn-light')], 'Alterar'),
        button([class('btn btn-light')], '- Excluir'),
        button([class('btn btn-light')], '? Ajudar')
    ])).