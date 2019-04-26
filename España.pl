% ordena_burbuja(+Lista, -ListaR). 
% es cierto cuando ListaR unifica con una lista que 
% contiene los mismos elementos que Lista ordenados 
% de menor a mayor. 

invertir([], []). 
invertir([Cab|Resto], RT) :-    
invertir(Resto, R),    
append(R, [Cab], RT).


% concatena(+List1, +List2, -ListR). 
% es cierto cuando ListaR unifica con una lista 
% que contiene los elementos de la lista List1 
% en el mismo orden y seguidos de los elementos 
% de la lista List2 en el mismo orden.

concatena([], L, L). 
concatena([Cab|Resto], List2, [Cab|R]):   
	concatena(Resto,List2,R)
	
	
% ordena_burbuja(+Lista, -ListaR). 
% es cierto cuando ListaR unifica con una lista que 
% contiene los mismos elementos que Lista ordenados 
% de menor a mayor

ordena_burbuja(Lista, Lista):- ordenada(Lista). 
ordena_burbuja(Lista, RT):  
	append(Ini,[E1,E2|Fin], Lista),  
	E1>E2,  
	append(Ini, [E2,E1|Fin], R),  
	ordena_burbuja(R, RT).
	
% ordenada(+Lista) 
% es cierto cuando Lista unifica con una lista 
% que contiene sus elementos ordenados de menor a 
% mayor.

ordenada([]). 
ordenada([_]). 
ordenada([Cab1, Cab2|Resto]):   
	Cab1 =< Cab2,   
	ordenada([Cab2|Resto]).
	
	
% inserta_en_list_ord(+Elem, +Lista, -ListaR). 
% es cierto cuando ListaR unifica con una lista 
% que contiene los elementos de la lista ordenada 
% Lista, con el elemento Elem insertado de forma 
% ordenada.

inserta_en_list_ord(Elem, [], [Elem]). 
inserta_en_list_ord(Elem, [Cab|Resto], [Elem, Cab|Resto]):  
	Elem =< Cab. 
inserta_en_list_ord(Elem, [Cab|Resto], [Cab|R]):   
	Elem > Cab, 
inserta_en_list_ord(Elem, Resto, R). 

% ordena_insercion(+Lista, -ListaR). 
% es cierto cuando ListaR unifica con una lista que 
% contiene los mismos elementos que Lista ordenados 
% de menor a mayor. 

ordena_insercion([],[]). 
ordena_insercion([Cab|Resto], RT):   
	ordena_insercion(Resto, R),   
		inserta_en_list_ord(Cab,R, RT).
		
