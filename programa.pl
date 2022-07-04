hace(losPiojos, masivo(cosquinRock, 15, argentina)).
hace(losPiojos, propio(70074)).
hace(damasGratis, propio(9290)).
hace(oneDirection, vivoIG(oneDirection, 150, 22300000)).

costo(masivo(_,CantBandas,_), Costo):-
    Costo is CantBandas * 500.
costo(propio(Capacidad), Capacidad).
costo(vivoIG(_,Horas,Seguidores), Costo):-
    Costo is Horas * Seguidores / 200.

% Saber si una persona puede ver una banda. 
% Esto sucede cuando el dinero que tiene la persona le alcanza para ver algún evento de la banda.
