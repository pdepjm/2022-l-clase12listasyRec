% Cosas para el menti:

hace(losPiojos, masivo(cosquinRock, 15, argentina)).
hace(losPiojos, propio(70074)).
hace(damasGratis, propio(9290)).
hace(oneDirection, vivoIG(oneDirection, 150, 22300000)).

costo(masivo(_,CantBandas,_), Costo):-
    Costo is CantBandas * 500.
costo(propio(Capacidad), Capacidad).
costo(vivoIG(_,Horas,Seguidores), Costo):-
    Costo is Horas * Seguidores / 200.

esCaroV1(Evento):-
    costo(Evento,Costo),
    Costo >= 100000.

esCaroV2(Evento):-
    Costo >= 100000,
    costo(Evento,Costo).

esCaroV3(Evento):-
    hace(Banda,Evento),
    costo(Evento) >= 100000.

esCaroV4(Evento):-
    hace(Banda,Evento),
    costo(Evento,Costo),
    Costo >= 100000.
