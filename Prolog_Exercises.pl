/*
 * flatten_list([A1, ..., An], []) =>
 * flatten_list([A1], [B1, ..., Bn]), flatten_list([A2, ..., An], [C1, ..., Cn]);  is_list(A1),
 * flatten_list([A2, ..., An], [C1, ..., Cn]); !is_list(A1),
 */
flatten_list([], []).
flatten_list([H | T], Flat) :- 
    is_list(H),
    flatten_list(H, FlatH),
    flatten_list(T, FlatT),
    append(FlatH, FlatT, Flat).
flatten_list([H | T], [H | FlatT]) :- 
    \+ is_list(H),
    flatten_list(T, FlatT).

/*
 * list_gcd([A1, ..., An], X) =>
 * A1; A = [A1]
 * list_gcd([A2, ..., An], TResult), gcd(A1, TResult, Result); |A| > 1
 * 
 * gdc(X, Y, Result) =
 * X; X = Y
 * gcd(X - Y, Y, Result); X > Y
 * gcd(Y - X, X, Result); X < Y
 */
gcd(X, Y, GCD) :- 
    X =:= Y, 
    GCD is X.
gcd(X, Y, GCD) :- 
    X > Y, 
    Z is X - Y, 
    gcd(Z, Y, GCD).
gcd(X, Y, GCD) :- 
    X < Y, 
    Z is Y - X, 
    gcd(Z, X, GCD).

list_gcd([], 0).
list_gcd([X], X).
list_gcd([H | T], Result) :- 
    list_gcd(T, TResult), 
    gcd(H, TResult, Result).

list_gcd_input(List, Result) :- 
    flatten_list(List, FlatList),
    list_gcd(FlatList, Result).

/*
 * add_after_pos_pow_2([A1, ..., An], [], X, Pos) => 
 * [], A = []
 * add_after_pos_pow_2([A2, ..., An], [A1, X, B1, ..., Bn], X, Pos + 1); is_power_of_2(Pos)
 * add_after_pos_pow_2([A2, ..., An], [A1, B1, ..., Bn], X, Pos + 1); !is_power_of_2(Pos)
 */
is_power_of_2(1).
is_power_of_2(N) :-
    N > 1,
    N mod 2 =:= 0,
    NewN is N // 2,
    is_power_of_2(NewN).

add_after_pos_pow_2_aux([], _, _, []).
add_after_pos_pow_2_aux([H | T], X, Pos, [H | Rest]) :-
    \+ is_power_of_2(Pos),
    NewPos is Pos + 1,
    add_after_pos_pow_2_aux(T, X, NewPos, Rest).
add_after_pos_pow_2_aux([H | T], X, Pos, [H, X | Rest]) :-
    is_power_of_2(Pos),
    NewPos is Pos + 1,
    add_after_pos_pow_2_aux(T, X, NewPos, Rest).

add_after_pos_pow_2([], _, []).
add_after_pos_pow_2([H | T], X, [H, X | Rest]) :-
    add_after_pos_pow_2_aux(T, X, 2, Rest).

add_after_pos_pow_2_input(List, X, Result) :-
    flatten_list(List, FlatList),
	add_after_pos_pow_2(FlatList, X, Result).

/*
 * number_atom([A1, ..., An], []) =>
 * []; A = []
 * count_occurrences(A1, [A2, ..., An], 0), number_atom([A2, ..., An], [B1, ..., Bn]);  A ≠ []
 * 
 * count_occurrences(Atom, [A1, ..., An], C) =
 * [Atom, C]; A = []
 * count_occurrences(Atom, [A2, ..., An], C + 1); X = A1
 * count_occurrences(Atom, [A2, ..., An], C); X ≠ A1
 */
count_occurrences(_, [], 0).
count_occurrences(Atom, [H | T], Count) :-
    H =:= Atom,
    count_occurrences(Atom, T, RestCount),
    Count is RestCount + 1.
count_occurrences(Atom, [H | T], Count) :-
    H =\= Atom,
    count_occurrences(Atom, T, Count).

delete([], _, []).
delete([X | T], X, Result) :- 
    delete(T, X, Result).
delete([H | T], X, [H | Result]) :- 
    H =\= X, 
    delete(T, X, Result).

number_atom([], []).
number_atom([H | T], [[H, Count] | Rest]) :-
    count_occurrences(H, [H | T], Count),
    delete(T, H, NewList), 
    number_atom(NewList, Rest).

number_atom_input(List, Result) :-
    flatten_list(List, FlatList),
    number_atom(FlatList, Result).

/*
 * delete_doubled_values([A1, ..., An], []) =>
 * []; A = []
 * number_atom([A2, ..., An], [B1, ..., Bn]);  is_duplicate(A1, [A2, ..., An])
 * number_atom([A2, ..., An], [A1, B1, ..., Bn]);  !is_duplicate(A1, [A2, ..., An])
 * 
 * is_duplicate(X, [A1, ..., An]) =>
 * is_duplicate(X, [A2, ..., An]); X ≠ A1
 * TRUE; X = A1
 * FALSE; A = []
 */
is_duplicate(X, [X | _]) :- 
    !.
is_duplicate(X, [_ | T]) :- 
    is_duplicate(X, T).

delete_doubled_values([], []).
delete_doubled_values([H | T], [H | Result]) :-
    \+ is_duplicate(H, T),  
    delete_doubled_values(T, Result).
delete_doubled_values([H | T], Result) :-
    is_duplicate(H, T),
    delete_doubled_values(T, Result).

delete_doubled_values_input(List, Result) :-
    flatten_list(List, FlatList),
    delete_doubled_values(FlatList, Result).

/*
 * max([A1, ..., An], Max) =>
 * [], A = []
 * max([A2, ..., An], Max); Max > A1
 * max([A2, ..., An], A1); Max < A1
 * 
 * delete(Max, [A1, ..., An], []) =>
 * []; A = []
 * delete(Max, [A2, ..., An], [B1, ..., Bn]); A1 = Max
 * delete(Max, [A2, ..., An], [A1, B1, ..., Bn]); A1 ≠ MAX
 */
max([], 0).
max([H | T], X) :-
    max(T, MaxT),
    (H > MaxT -> X = H ; X = MaxT).

:- discontiguous delete/3.
delete(_, [], []).
delete(X, [H | T], Result):-
    H =:= X,
    delete(X, T, ResultT),
    Result = ResultT.
delete(X, [H | T], Result):-
    H =\= X,
    delete(X, T, ResultT),
    Result = [H | ResultT].

delete_max(List, R) :-
    flatten_list(List, FlatList),
    max(FlatList, Val),
    delete(Val, FlatList, R).

/*
 * diff([A1, ..., An], [B1, ..., Bn], []) =>
 * []; A = []
 *  diff([A2, ..., An], [B1, ..., Bn], [A1, C1, ..., Cn]); A1 ∉ B
 * diff([A2, ..., An], [B1, ..., Bn], [C1, ..., Cn]); A1 ∈ B
 */
diff([], _, []).
diff([H | T], L, Difference) :-
    member(H, L),
    diff(T, L, Difference).
diff([H | T], L, [H | Difference]) :-
    \+ member(H, L),
    diff(T, L, Difference).

diff_input(L1, L2, Difference) :-
    flatten_list(L1, FlatL1),
    flatten_list(L2, FlatL2),
    diff(FlatL1, FlatL2, Difference).

/*
 * add_1_after_elements([A1, ..., An], []) =>
 * []; A = []
 * add_1_after_elements([A2, ..., An], [A1, 1, B1, ..., Bn]); A ≠ []
 */
add_1_after_elements([], []).
add_1_after_elements([H | T], [H, 1 | Rest]) :-
    add_1_after_elements(T, Rest).

add_1_after_elements_input(List, Result) :-
    flatten_list(List, FlatList),
    add_1_after_elements(FlatList, Result).

/*
 * reunion_of_multitudes([A1, ..., An], [B1, ..., Bn]) =>
 * []; A = []
 * reunion_of_multitudes([A2, ..., An], [A1, B1, ..., Bn]); A1 ∉ B
 * reunion_of_multitudes([A2, ..., An], [B1, ..., Bn]); A1 ∈ B
 */
reunion_of_multitudes([], L, L).
reunion_of_multitudes([H | T], L, Reunion) :-
    member(H, L),
    !,
    reunion_of_multitudes(T, L, Reunion).
reunion_of_multitudes([H | T], L, [H | Reunion]) :-
    \+ member(H, L),
    reunion_of_multitudes(T, L, Reunion).

reunion_of_multitudes_input(L1, L2, Result) :-
    flatten_list(L1, FlatL1),
    flatten_list(L2, FlatL2),
    reunion_of_multitudes(FlatL1, FlatL2, Result).

/*
 * pairs_of_list([A1, ..., An], []) =>
 * []; A = []
 * generate_pairs(A1, [A2, ..., An], [B1, ..., Bn]), pairs_of_list([A2, ..., An], [B1, ..., Bn]); A ≠ []
 * 
 * generate_pairs(X, [A1, ..., An], []) =>
 * []; A = []
 * generate_pairs(X, [A2, ..., An], [[X, A1], B1, ..., Bn]); A ≠ []
 */
generate_pairs(_, [], []).
generate_pairs(X, [Y | Rest], [[X, Y] | Pairs]) :-
    generate_pairs(X, Rest, Pairs).

pairs_of_list([], []).
pairs_of_list([X | Rest], Pairs) :-
    generate_pairs(X, Rest, PairsOfX),
    pairs_of_list(Rest, OtherPairs),
    append(PairsOfX, OtherPairs, Pairs).

pairs_of_list_input(List, Result) :-
    flatten_list(List, FlatList),
    pairs_of_list(FlatList, Result).

persons(0, []) :- !. % end when the index is 0 and the list is empty. 
persons(N, [(_Men,_Color,_Drink,_Smoke,_Animal)|T]) :- N1 is N-1, persons(N1,T). %  create a recursive list with N element

% get the Nth element if corresponding to some informations of the recursive list
person(1, [H|_], H) :- !.
person(N, [_|T], R) :- N1 is N-1, person(N1, T, R).

% The Brit lives in a red house
hint1([(brit,red,_, _, _)|_]).
hint1([_|T]) :- hint1(T).

% The Spanish keeps dogs as pets
hint2([(spanish,_,_,_,dog)|_]).
hint2([_|T]) :- hint2(T).

% The Ukrainian drinks tea
hint3([(ukrainian,_,tea,_,_)|_]).
hint3([_|T]) :- hint3(T).

% The White house is on the left of the Green house 
hint4([(_,white,_,_,_),(_,green,_,_,_)|_]).
hint4([_|T]) :- hint4(T).

% The owner of the Green house drinks coffee. 
hint5([(_,green,coffee,_,_)|_]).
hint5([_|T]) :- hint5(T).

% The person who smokes Old Gold rears snails
hint6([(_,_,_,oldgold,snails)|_]).
hint6([_|T]) :- hint6(T).

% The owner of the Yellow house smokes Kools
hint7([(_,yellow,_,kools,_)|_]).
hint7([_|T]) :- hint7(T).

% The man living in the centre house drinks milk
hint8(Persons) :- person(3, Persons, (_,_,milk,_,_)).

% The Norwegian lives in the first house
hint9(Persons) :- person(1, Persons, (norwegian,_,_,_,_)).

% The man who smokes Chesterfields lives next to the one who keeps fox
hint10([(_,_,_,chesterfields,_),(_,_,_,_,fox)|_]).
hint10([(_,_,_,_,fox),(_,_,_,chesterfields,_)|_]).
hint10([_|T]) :- hint10(T).

% The man who keeps horses lives next to the man who smokes Kools
hint11([(_,_,_,kools,_),(_,_,_,_,horse)|_]).
hint11([(_,_,_,_,horse),(_,_,_,kools,_)|_]).
hint11([_|T]) :- hint11(T).

% The man who smokes Lucky Strike drinks orange juice
hint12([(_,_,orangejuice,luckystrike,_)|_]).
hint12([_|T]) :- hint12(T).

% The Japanese smokes Parliaments
hint13([(japanese,_,_,parliaments,_)|_]).
hint13([_|T]) :- hint13(T).

% The Norwegian lives next to the blue house
hint14([(norwegian,_,_,_,_),(_,blue,_,_,_)|_]).
hint14([(_,blue,_,_,_),(norwegian,_,_,_,_)|_]).
hint14([_|T]) :- hint14(T).

% The question 1: Who owns the zebra ?
question1([(_,_,_,_,zebra)|_]).
question1([_|T]) :- question1(T).

% The question 2: Who drink water ?
question2([(_,_,water,_,_)|_]).
question2([_|T]) :- question2(T).

solution(Persons) :-
    persons(5, Persons),
    hint1(Persons),
    hint2(Persons),
    hint3(Persons),
    hint4(Persons),
    hint5(Persons),
    hint6(Persons),
    hint7(Persons),
    hint8(Persons),
    hint9(Persons),
    hint10(Persons),
    hint11(Persons),
    hint12(Persons),
    hint13(Persons),
    hint14(Persons),
    question1(Persons),
    question2(Persons).