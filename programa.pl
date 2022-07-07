% Cosas para el menti:

costo(propio(Capacidad), Capacidad).
costo(masivo(_,CantBandas,_), Costo):-
    Costo is CantBandas * 500.
costo(vivoIG(_,Horas,Seguidores), Costo):-
    Costo is Horas * Seguidores / 200.


hace(losPiojos, masivo(cosquinRock, 15, argentina)).
hace(losPiojos, propio(70074)).
hace(damasGratis, propio(9290)).
hace(oneDirection, vivoIG(oneDirection, 150, 22300000)).

esCaroV1(Evento):- % deja entrar cualquier evento, siempre que sea correcto aunque no se haya hecho.
    costo(Evento,Costo), % pero como esto no es inversible, esCaroV1 tampoco lo es.
    Costo >= 100000.

esCaroV2(Evento):-
    Costo >= 100000, % nunca funciona porque el >= no es inversible, y Costo no está ligado
    costo(Evento,Costo).

esCaroV3(Evento):-
    hace(Banda,Evento),
    costo(Evento) >= 100000. % costo es un predicado, no es una función. Relaciona cosas, NO DEVUELVE

esCaroV4(Evento):- % es inversible por el evento porque:
    hace(Banda,Evento), % es inversible por el evento
    costo(Evento,Costo),
    Costo >= 100000.



%..............................................................................
%Ancestro/2 relaciona dos mascotas cuando una es el ancestro de la otra 

%Caso Recursivo
ancestro(Ancestro, Descendiente):-  %Busca un perro mas cerca del ancestro
	padreDe(Ancestro, HijoAncestro),
	ancestro(HijoAncestro, Descendiente).

%Caso Base
ancestro(Ancestro, Descendiente):-
	padreDe(Ancestro, Descendiente). %Es inversible porque usa padreDe



%Caso Recursivo
ancestro2(Ancestro, Perrito):- %Busca un perro mas cerca del Descendiente
	padreDe(PerritoPadre, Perrito),
	ancestro2(Ancestro, PerritoPadre).

%Caso Base
ancestro2(Ancestro, Perrito):-
	padreDe(Ancestro, Perrito).


%..............................................................................
%Casos no realizados:
	%Mismo perro 
	%Sin relacion

%generacionesEntre(Ancestro, Descendiente, CantGeneraciones)
generacionesEntre(Ancestro, Descendiente, 1):-
	padreDe(Ancestro, Descendiente).
	% CantGeneraciones == 1. 
	%is es solo cuentas y usando == no estamos pensando con pattern matching

generacionesEntre(Ancestro, Descendiente, CantGeneraciones):-
%generacionesEntre(bisperrito, nala, ??)
	padreDe(Ancestro, HijoAncestro),
	%padreDe(bisperrito, reina)
	%bisPerrito -> reina -> ... -> nala
	generacionesEntre(HijoAncestro, Descendiente, CantGeneracionesAnterior),
	%generacionesEntre(reina, nala, ??)
	%reina -> ... -> nala
	CantGeneraciones is CantGeneracionesAnterior + 1.
	%(bisPerrito -> reina -> ... -> nala) = (reina -> ... -> nala) + (bisPerrito -> reina)

%..............................................................................

%- Rick tiene un grupo de paseo que incluye a las mascotas bruno, mora y rocco, 
% y tiene otro grupo que incluye a lola y a percy.

% - John tiene un grupo de paseo que incluye a sofi, scott alekai y mambo.

/*
paseador(rick).
mascota(bruno).
mascota(mora).
mascota(rocco).
*/
% ...
%Los agrupamos
/*
No queremos functores: no queremos estructuras "fijas".
Queremos una estructura que pueda "juntar" cosas, de cualquier cantidad. 
Queremos una lista.
paseo(rick, mascotas(bruno, mora, rocco)). %<- functor
paseo(rick, mascotas(lola,percy)).
paseo(john, mascotas(sofi,scott,alekai,mambo)).

esExpertoFunctores(Paseador):-
	paseo(Paseador, Mascotas),
	longitud(Mascotas, Cant), 
	Cant > 3.

longitud(mascotas(_,_),2).
longitud(mascotas(_,_,_),3).
longitud(mascotas(_,_,_,_),4).
longitud(mascotas(_,_,_,_,_),5).
% ¿y cuántos más...?

*/



% Queremos saber si un paseador esExperto/1. Esto cumple cuando tiene algún  grupo 
% con más de 3 mascotas.
esExperto(Paseador):-
	grupoDePaseo(Paseador, Mascotas),
	length(Mascotas, Cant), 
	Cant > 3.
	
% paseaA/2 relaciona un paseador y una mascota si es cierto que la pasea en algún grupo.
paseaA(Paseador, Mascota):-
	grupoDePaseo(Paseador, Mascotas),
	%member/2  lo que buscamos y La lista
	member(Mascota, Mascotas).

%member y length es inversible solo para la estructura, no para los elementos dentro

%cantidadDeHijos/2 me relaciona una mascota con su cantidad de hijos.

% padreDe(Padre,Hijo). 
padreDe(bisPerrito, reina).
padreDe(reina, simba).
padreDe(reina, nala).
padreDe(reina, buga).
padreDe(teo, simba).
padreDe(teo, nala).
padreDe(simba, sin).
padreDe(simba, buga).
padreDe(mia, sin).
% padreDe(Padre,Hijos). -> todos los hijos segun un padre

cantidadDeHijos(Perro, CantHijos):-
	%Conseguir todos los hijos
	%   Hijo    padreDe(Padre,Hijo)    Hijos
	%...........
	esPerro(Perro),
	findall(Hijo, padreDe(Perro,Hijo), Hijos),
	length(Hijos, CantHijos).

esPerro(Perro):-
	padreDe(Perro,_).

esPerro(Perro):-
	padreDe(_,Perro).

	/*
	findall(
		Elemento que quiero agregar,
		La consulta que me va a decir la cantidad de elementos que agregare,
		La lista donde voy a agregarlo
	).
	*/


% grupoDePaseo(Paseador, ListaDeMascotas)
grupoDePaseo(rick, [bruno, mora, rocco]). %<- lista
grupoDePaseo(rick, [lola, percy]).
grupoDePaseo(john, [sofi, scott, alekai, mambo]).

% Queremos modelar esPaseador/1, que me dice si un paseador 
% tiene al menos 1 grupo de paseo.

% Esto está MAAAAL MAAAAALL ARGGGHHHHHHH
% Está mal, porque es imperativo, nos estamos olvidando de lógico, 
% Se puede decir más declarativamente
esPaseadorMal(Paseador):-
	grupoDePaseo(Paseador, _),
	findall(Mascotas, grupoDePaseo(Paseador,Mascotas), GrupoDeGruposDeMascotas),
	length(GrupoDeGruposDeMascotas, Cant),
	Cant > 1.

% Buena persona programadora:
% (mucho más declarativa, muestra QUE quiero, y no COMO lo consigo)
esPaseador(Paseador):-
	grupoDePaseo(Paseador, _).




% Cosas que no llegamos a ver en clase:

/*
segundo([_|[Segundo|_]], Segundo).
% o bien:
segundo([_,Segundo|_], Segundo). % otra forma
*/


/*
%miembro(Mascota, ListaMascota)
miembro(Mascota, [Mascota|_]).
miembro(Mascota, [_|RestanteLista]):-
	miembro(Mascota, RestanteLista).

*/


/*
%length(ListaMascota, CantMascotas)
largo([_|RestanteLista], Cantidad):-
    largo(RestanteLista, CantidadRestante),
	Cantidad is CantidadRestante + 1.

largo([], 0).
*/


/*
concatenar([], Segunda, Segunda).
concatenar([X|Xs], Segunda, [X|ColaConcatenada]):-
  concatenar(Xs, Segunda, ColaConcatenada).
*/