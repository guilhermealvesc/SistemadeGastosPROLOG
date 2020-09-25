:- module(
        estoque, 
        [ estoque/7 ]).

:- use_module(library(persistency)).
:- use_module(chave, []).

:- persistent 
    estoque(
        cd_estoque:positive_integer,
        ordem_servico_funcionario_cd_funcionario:positive_integer,
        ordem_servico_cd_ordem_servico:positive_integer,
        material_cd_material:positive_integer,
        qtd_material_soma:positive_integer,
        qtd_material_subtrai:positive_integer,
      ).

arquivo_da_tabela(Arquivo):-
    db_attach(Arquivo, []).

insere(CdEstoque, OsFuncionarioCdFuncionario, CdOs, CdMaterial, QtdMaterialSoma, QtdMaterialSubtrai) :-
    chave:pk(estoque, CdFun),
    with_mutex(estoque, 
        assert_estoque(CdEstoque, OsFuncionarioCdFuncionario, CdOs, CdMaterial, QtdMaterialSoma, QtdMaterialSubtrai)).

remove(CdFun) :- 
    with_mutex(estoque, 
        retract_estoque(CdEstoque, _OsFuncionarioCdFuncionario, _CdOs, _CdMaterial, _QtdMaterialSoma, _QtdMaterialSubtrai)).

atualiza(CdEstoque, _OsFuncionarioCdFuncionario, _CdOs, _CdMaterial, _QtdMaterialSoma, _QtdMaterialSubtrai) :-
    with_mutex(estoque,
        retractall_estoque(CdEstoque, _OsFuncionarioCdFuncionario, _CdOs, _CdMaterial, _QtdMaterialSoma, _QtdMaterialSubtrai),
        assert_estoque(CdEstoque, OsFuncionarioCdFuncionario, CdOs, CdMaterial, QtdMaterialSoma, QtdMaterialSubtrai)).

sincroniza :-
    db_sync(gc(always)).