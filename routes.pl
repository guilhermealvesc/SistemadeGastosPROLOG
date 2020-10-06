:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_path)).

:- multifile http:location/3.
:- dynamic   http:location/3.

%% http:location(Apelido, Rota, Opções)
%      Apelido é como será chamada uma Rota do servidor.
%      Os apelidos css, icons e js já estão definidos na
%      biblioteca http/http_server_files, os demais precisam
%      ser definidos.

http:location(img, root(img), []).
http:location(home, root(home), []).
/* http:location(api, root(api), []).
http:location(api1, api(v1), []). */
http:location(funcionarios, funcionarios, []).


:- http_handler(css(.),
                serve_files_in_directory(dir_css), [prefix]).
:- http_handler(img(.),
                serve_files_in_directory(dir_img), [prefix]).
:- http_handler(js(.),
                serve_files_in_directory(dir_js),  [prefix]).
:- http_handler('/favicon.ico',
                http_reply_file(dir_img('favicon.ico'), []), []).

% Frontend
:- http_handler(root(.),
                login(Metodo), [method(Metodo), methods([get, post])]).

:- http_handler(home(.), home, []).

:- http_handler(funcionarios(cadastro),
                    cadastro, []).
% Backend
/* :- http_handler( api1(bookmarks/Id),
                 bookmarks(Metodo, Id) ,
                 [ method(Metodo),
                   methods([ get, post, put, delete ]) ]). */
