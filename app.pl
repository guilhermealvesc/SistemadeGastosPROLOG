:- use_module(library(http/http_dispatch)).

:- use_module(library(http/http_path)).

:- use_module(library(http/http_server_files)).

:- use_module(library(http/http_log)).


:- use_module(library(http/http_json)).

/* Aumenta a lista de tipos aceitos pelo servidor */
:- multifile http_json/1.

http_json:json_type('application/x-javascript').
http_json:json_type('text/javascript').
http_json:json_type('text/x-javascript').
http_json:json_type('text/x-json').

:- initialization( servidor(8000) ).


:- multifile user:file_search_path/2.

% file_search_path(Apelido, Caminho)
%     Apelido é como será chamado um Caminho absoluto ou
%     relativo no sistema de arquivos

user:file_search_path(dir_css, './css').
user:file_search_path(dir_js,  './js').
user:file_search_path(dir_img, './img').

user:file_search_path(temp, './template').


user:file_search_path(frontend,  './frontend').
user:file_search_path(service,  frontend('service-order')).
user:file_search_path(admin,  frontend(admin)).


user:file_search_path(cadastro,  admin(cadastro)).
user:file_search_path(clientes,  cadastro(clientes)).
user:file_search_path(funcionarios,  cadastro(funcionarios)).
user:file_search_path(funcoes,  cadastro(funcoes)).

user:file_search_path(consultas,  admin(consultas)).

user:file_search_path(material,  admin(material)).
user:file_search_path(estoque,  material(estoque)).
user:file_search_path(material,  material(material)).
user:file_search_path(servico,  material(servico)).

user:file_search_path(backend,  './backend').

user:file_search_path(api,   backend(api)).
user:file_search_path(api1, api(v1)).

user:file_search_path(bd,  backend(bd)).
user:file_search_path(schemas,  db(schemas)).
user:file_search_path(tables,  db(tables)).

:- load_files([ server,
                routes,
                temp(bootstrap),
                %carregando pages padrões 
                frontend(login),
                frontend(home),
                frontend(about),
                frontend(help),
                /* service(cadastro),
                service(relatorio),*/
                %carregando admin
                admin(home),
                admin(about),
                admin(help),
                /* clientes(cadastro),
                clientes(relatorio), */
                funcionarios(cadastro)
                /* funcionarios(relatorio),
                funcoes(cadastro),
                funcoes(relatorio),
                consultas(mensal),
                consultas(servicos),
                estoque(cadastro),
                estoque(relatorio),
                material(cadastro),
                material(relatorio),
                servico(cadastro),
                servico(relatorio) */
              ],
	          [ silent(true)
	          ]).
