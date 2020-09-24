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
/* ENDEREÇO (CONSULTAS E CRUD) A tabela de endereçoes está subordinada a de funcionários */

cadastra_funcionario(Nome, Usuario, Senha, Func, Rua, Nr_casa, 
    Complemento, Bairro, Cidade, CEP, Tel1, Tel2) :-
        funcao:funcao(CdFuncao, Func, TpVis),
        endereco:insere(CdEnd, Rua, Nr_casa, 
            Complemento, Bairro, Cidade, CEP, Tel1, Tel2),
        funcionario:insere(_CdFun, CdFuncao, CdEnd, Nome, 
            Senha, Usuario, TpVis).

remove_funcionario(CdFun) :-
    \+ ordem_servico:ordem_servico(_CdOrdemS, CdFun, _CdCliente, _DtOrdemS, _VlTot, _BoolF),
    funcionario:funcionario(CdFun, _CdFuncao, CdEnd, _Nome, _Senha, _Nick, _TpVis),
    endereco:endereco(CdEnd, _Nm_rua, _Nr_casa, _Complemento, _Nm_bairro, 
    _Nm_cidade, _Cep, _Tel1, _Tel2),
    funcionario:remove(CdFun),
    endereco:remove(CdEnd).

atualiza_funcionario(CdFun, Nome, Usuario, Senha, Func, Rua, Nr_casa, 
    Complemento, Bairro, Cidade, CEP, Tel1, Tel2) :- 
        funcao:funcao(CdFuncao, Func, TpVis),
        endereco:atualiza(CdEnd, Rua, Nr_casa, 
            Complemento, Bairro, Cidade, CEP, Tel1, Tel2),
        funcionario:atualiza(CdFun, CdFuncao, CdEnd, Nome, 
            Senha, Usuario, TpVis).

lista_funcionarios(List) :-
    findall((Name, Nick, Funcao), 
        (funcionario:funcionario(_CdFunc, CdFuncao, _CdEnd, Name, _Senha, Nick, _TpVis),
        funcao:funcao(CdFuncao, Funcao, _TpVis)), List).

/* ENDEREÇO (CONSULTAS E CRUD) A tabela de endereçoes está subordinada a de funcionários */
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
