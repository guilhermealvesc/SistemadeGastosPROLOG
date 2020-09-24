:- module(
    chave,
    [ pk/2,
      cria_pk/2 ]
).

:- use_module(library(persistency)).


:- persistent
    chave(nome:atom,
          valor:positive_integer).


:- initialization( db_attach('../tables/tbl_chave.pl', []) ).

pk(Nome, Valor):-
  chave(Nome, _V), !,
  with_mutex(chave,
      (chave(Nome, ValorAntigo),
      Valor is ValorAntigo + 1,
      retractall_chave(Nome, _),
      assert_chave(Nome, Valor))).


pk(Nome, 1):-
  with_mutex(chave,
      assert_chave(Nome, 1)). % Cria uma chave com valor inicial 1
          
% Talvez você queira um valor incial diferente de 1


cria_pk(Nome, _):-
chave(Nome, _), % Se já existir uma chave com o nome dado, não atualiza
!.
cria_pk(Nome, ValorInicial):-
with_mutex(chave,
           assert_chave(Nome, ValorInicial)).