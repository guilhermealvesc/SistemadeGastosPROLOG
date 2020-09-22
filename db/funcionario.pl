:- module(funcionario, []).

:- use_module(library(persistency)).
/* 
:- use_module(function, []).
:- use_module(address, []). 
:- use_module(order, []).
*/

:- persistent 
    funcionario(cd_funcionario:positive_integer,
        funcao_cd_funcao:positive_integer,
        endereco_cd_endereco:positive_integer,
        nm_funcionario:atom,
        ds_senha:atom,
        nick:atom,
        tp_visivel:nonneg).

:- initialization(db_attach('tbl_funcionario.pl', [])).

insert(CdFun, CdFuncao, CdEnd, Nome, Senha, Nick, TpVis) :-
    /* function:funcao(CdFuncao, _DsFuncao, _),
    address:endereco(CdEnd, _NmRua, _NrCasa, _DsComplemento, _NmBairro, _NmCidade, _DsCep, _Tel1, Tel2), */
    with_mutex(funcionarios, 
        assert_funcionario(CdFun, CdFuncao, CdEnd, Nome, Senha, Nick, TpVis)).

remove(CdFun) :- 
    /* \+ order:ordem_servico(_CdOrdemS, CdFun, _CdCliente, _DtOrdemS, _VlTot, _BoolF), */
    with_mutex(funcionarios, 
        retract_funcionario(CdFun, _CdFuncao, _CdEnd, _Nome, _Senha, _Nick, _TpVis)).

update(CdFun, CdFuncao, CdEnd, Nome, Senha, Nick, TpVis) :-
    remove(CdFun),
    insert(CdFun, CdFuncao, CdEnd, Nome, Senha, Nick, TpVis).

list(List) :-
    findall((Name, Nick, Funcao), 
        (funcionario:funcionario(_CdFunc, CdFuncao, _CdEnd, Name, _Senha, Nick, _TpVis)/* ,
        function:funcao(CdFun, Funcao, _TpVis) */), List).

sincroniza :-
    db_sync(gc(always)).