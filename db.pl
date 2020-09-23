:- load_files([ routes,
                schemas(funcionario),
                schemas(funcao) 
              ],
	          [ if(not_loaded), 
                silent(true) 
	          ]).
        
:- initialization(inicializa_tabelas).

tabela(funcionario).
tabela(funcao).

inicializa_tabelas :-
    findall(Tabela, tabela(Tabela), Tabelas),
    liga_todos_arquivos(Tabelas).

liga_todos_arquivos([Tabela|Tabelas]) :-
    liga_arquivo(Tabela), !,
    liga_todos_arquivos(Tabelas).

liga_todos_arquivos([]).

liga_arquivo(Arquivo) :- !,
    atomic_list_concat(['tbl_', Arquivo, '.pl'], NomeArq),
    expand_file_search_path(tables(NomeArq), CaminhoArqTable),
    NomeArq:arquivo_da_tabela(CaminhoArqTable).


/* FUNCIONÁRIOS (CONSULTAS E CRUD) */
cadastra_funcionario(Nome, Usuario, Senha, Func, Rua, Nr_casa, 
    Complemento, Bairro, Cidade, CEP, Tel1, Tel2) :-
        funcao:funcao(CdFuncao, Func, _TpVis),
        endereco:insere(CdEnd, Rua, Nr_casa, 
            Complemento, Bairro, Cidade, CEP, Tel1, Tel2),
        funcionario:insere(_CdFun, CdFuncao, CdEnd, Nome, 
            Senha, Usuario, _TpVis).

remove_funcionario(CdFun) :-
    \+ ordem_servico:ordem_servico(_CdOrdemS, CdFun, _CdCliente, _DtOrdemS, _VlTot, _BoolF),
    funcionario:remove(CdFun).

%Estou atualizando o funcionario pelo código dele, mas nao sei se esse valor
%vem do front
atualiza_funcionario(CdFun, Nome, Usuario, Senha, Func, Rua, Nr_casa, 
    Complemento, Bairro, Cidade, CEP, Tel1, Tel2) :- 
        funcao:funcao(CdFuncao, Func, _TpVis),
        endereco:insere(CdEnd, Rua, Nr_casa, 
            Complemento, Bairro, Cidade, CEP, Tel1, Tel2),
        funcionario:atualiza(CdFun, CdFuncao, CdEnd, Nome, 
            Senha, Usuario, _TpVis).

lista_funcionarios(List) :-
    findall((Name, Nick, Funcao), 
        (funcionario:funcionario(_CdFunc, CdFuncao, _CdEnd, Name, _Senha, Nick, _TpVis),
        funcao:funcao(CdFuncao, Funcao, _TpVis)), List).
/* FUNCIONÁRIOS (CONSULTAS E CRUD) */

/* FUNÇÃO (CONSULTAS E CRUD) */
cadastra_funcao(Ds_funcao, TpVis) :-
    funcao:insere(_CdFuncao, Ds_funcao, TpVis).

remove_funcao(CdFuncao) :-
    funcao:remove(CdFuncao).

atualiza_funcao(CdFuncao, Ds_funcao, TpVis) :-
    funcao:atualiza(CdFuncao, Ds_funcao, TpVis).

lista_funcoes(List) :-
    funcao:listar(List).
/* FUNÇÃO (CONSULTAS E CRUD) */