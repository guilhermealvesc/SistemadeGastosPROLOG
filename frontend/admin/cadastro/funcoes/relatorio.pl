:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).

:- ensure_loaded(temp(bootstrap)).
:- use_module('./backend/db/schemas/funcao.pl').

funcoes(_):-
    reply_html_page(
        bootstrap,
        [ \metasRelFuncao, \linksRelFuncao, title('Controle de Gastos de Clientes | Funcao')],
        [ \navbarRelFuncao, \pageRelFuncao ]).

metasRelFuncao -->
    html(meta([name(viewport), content('width=device-width, initial-scale=1.0, shrink-to-fit=no')], [])).
    
linksRelFuncao -->
    html([link([rel(stylesheet), href('https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css')], []),
    link([rel(stylesheet), href('https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'), 
    integrity('sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z'), crossorigin('anonymous')], []),
    link([rel(stylesheet), href('/css/admin/cadastros/funcoes/relatorio.css')], [])]).

navbarRelFuncao --> 
    html(nav([class('navbar navbar-expand-lg navbar-light bg-light')], 
    [button([class('navbar-toggler'), type(button), 'data-toogle'(collapse), 'data-target'('#header'), 'aria-controls'(header),
    'aria-expanded'(false), 'aria-label'('Toggle navigation')], [span([class('navbar-toggler-icon')], [])]), 
    div([class('collapse navbar-collapse'), id(header)],
    [div([class('navbar-nav')], [
        a([class('nav-link active'), href('/admin/cadastros/funcionarios')], ['Cadastros']), 
        a([class('nav-link'), href('/admin/material')], ['Material']), 
        a([class('nav-link'), href('/admin/serviceorder')], ['Ordem de Servico']), 
        a([class('nav-link'), href('/admin/consultas')], ['Consultas']), 
        a([class('nav-link'), href('/admin/about')], ['Sobre']), 
        a([class('nav-link'), href('/admin/help')], ['Ajuda'])
    ])])])).

pageRelFuncao -->
    html(div([class('main-content')],
            [h5('Funcoes'), 
            \navpageRelFuncao,
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
                    table([class(table)], [
                        thead([style('text-align: center;')], [
                            th('Funcao'),  
                            th('Acesso Restrito')
                        ]),
                        tbody(\rendertableFuncao)
                    ])
                ]),
                \buttonsRelFuncao
            ])])).

navpageRelFuncao --> 
    html(nav([class('navbar navbar-expand-lg navbar-light bg-light')], 
    [button([class('navbar-toggler'), type(button), 'data-toogle'(collapse), 'data-target'('#page'), 'aria-controls'(page),
    'aria-expanded'(false), 'aria-label'('Toggle navigation')], [span([class('navbar-toggler-icon')], [])]), 
    div([class('collapse navbar-collapse'), id(page)],
    [div([class('navbar-nav')], 
    [a([class('nav-link active'), href('/admin/cadastros/clientes')], ['Relatorio']), 
    a([class('nav-link'), href('/admin/cadastros/clientes/cadastro')], ['Cadastro']) 
    ])])])).

buttonsRelFuncao --> 
    html(div([class('buttons col-lg-2 col-md-2 lado')], [
        button([class('btn btn-light'), disabled(disabled)], 'Confirmar'),
        button([class('btn btn-light'), disabled(disabled)], 'Cancelar'),
        button([class('btn btn-light')], '+ Incluir'),
        button([class('btn btn-light')], 'Alterar'),
        button([class('btn btn-light')], '- Excluir'),
        button([class('btn btn-light')], '? Ajudar')
    ])).

rendertableFuncao -->
    {
        findall(tr([td(Func), td([style('text-align: center;')], [input([type(checkbox), onclick('return false;'), Checked], [])])]), 
            (funcao:funcao(_, Func, Bool), (Bool -> Checked = 'checked'; Checked = 'readonly') ), HTML)
    },
    html(HTML).
