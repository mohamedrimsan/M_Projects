% Project Course:- COU4303 Artificial Intelligence

% Developed By:- Group 25, BSc IT Students 23/24 Batch.

% Bus Data Collected From :- routemaster.lk






% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Colombo Bus Route Guider
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:- use_module(library(lists)). 					 % it's used to imports the SWI-Prolog’s built-in list utilities like List manipulation, path building, stop collection
:- use_module(library(readutil)).				 % Reading the menu input as a plain strings
:- use_module(library(pairs)). 					 % Sorting paths by A* algorithm cost

% -----------------
% Bus Details (Bus Number, Starting City, Destination City, [Stopping Cities])
% -----------------

bus(100, panadura, fort, [panadura, walana, keselwatta, moratuwa, ratmalana, galkissa, dehiwala, wellawatta, bambalapitiya, kollupitiya, 'galle face', fort]).

bus(101, moratuwa, fort, [moratuwa, ratmalana, galkissa, dehiwala, wellawatta, bambalapitiya, kollupitiya, 'slave island', 'lake house', fort]).

bus(102, moratuwa, kotahena, [moratuwa, ratmalana, galkissa, dehiwala, wellawatta, bambalapitiya, kollupitiya, 'galle face', fort, kochchikade, kotahena]).

bus(103, narahenpita, fort, [narahenpita, 'kanatta junction', borella, 'punchi borella', maradana, 'technical college junction', fort]).

bus(104, 'ja ela', bambalapitiya, ['ja ela', wattala, peliyagoda, 'new kelani bridge', orugodawatta, dematagoda, borella, 'kanatta junction', 'bauddhaloka mawatha', thummulla, bambalapitiya]).

bus(112, maharagama, kotahena, [maharagama, navinna, delkanda, nugegoda, kirillapone, 'havelock city', 'dickmans road', bambalapitiya, kollupitiya, 'galle face', fort, kochchikade, kotahena]).

bus(113, udahamulla, fort, [udahamulla, 'embuldeniya junction', 'jubilee post mirihana', nugegoda, kirillapone, 'havelock city', 'thimbirigasyaya junction', 'torrington avenue', 'independence square', 'cinnamon gardens', 'town hall', 'ibbanwala junction', 'tb jayah road', 'darley road', 'gamani hall junction', 'dr wijewardena road', 'lake house', fort]).

bus(117, ratmalana, nugegoda, [ratmalana, 'attidiya road', bellanthota, pepiliyana, 'gamsabha junction', 'kattiya junction', 'old kesbewa road', nugegoda]).

bus(119, maharagama, dehiwala, [maharagama, 'boralesgamuwa lake', 'pirivena junction', boralesgamuwa, dewalamulla, bellanwila, bellanthota, nikape, nedimala, karagampitiya, dehiwala]).

bus(120, piliyandala, fort, [piliyandala, werahera, boralesgamuwa, rattanapitiya, pepiliyana, kohuwala, 'dutugemunu street', pamankada, 'havelock city', 'thimbirigasyaya junction', thummulla, 'kumaratunga munidasa road', 'cambridge place', 'public library', 'dharmapala mawatha', 'town hall', 'ibbanwala junction', 'tb jayah road', 'darley road', 'gamani hall junction', 'dr wijewardena road', 'lake house', fort]).

bus(122, avissawella, fort, [avissawella, kosgama, 'kalu aggala', pahatgama, meepe, watareka, meegoda, godagama, homagama, makumbura, kottawa, pannipitiya, maharagama, navinna, delkanda, nugegoda, kirillapone, 'havelock city', 'thimbirigasyaya junction', thummulla, 'town hall', 'ibbanwala junction', 'tb jayah road', 'darley road', 'gamani hall junction', 'dr wijewardena road', 'lake house', fort]).

bus(125, padukka, fort, [padukka, meegoda, godagama, homagama, makumbura, kottawa, pannipitiya, maharagama, navinna, delkanda, nugegoda, kirillapone, 'havelock city', 'thimbirigasyaya junction', 'torrington avenue', 'independence square', 'cinnamon gardens', 'town hall', 'ibbanwala junction', 'tb jayah road', 'darley road', 'gamani hall junction', 'dr wijewardena road', 'lake house', fort]).

bus(135, kohuwala, kelaniya, [kohuwala, 'dutugemunu street', pamankada, 'havelock city', 'thimbirigasyaya junction', narahenpita,'kanatta junction', borella, dematagoda, orugodawatta, 'new kelani bridge', peliyagoda, 'biyagama road', kelaniya]).

bus(140, kollupitiya, wellampitiya, [kollupitiya, 'dharmapala mawatha', 'town hall', 'norris canal road', paranawadiya, 'maradana road', 'sri vajirangana road', dematagoda, 'kolonnawa road', wellampitiya]).

bus(176, dehiwala, kotahena, [dehiwala, 'hill street', karagampitiya, kohuwala, nugegoda, nawala, koswatta, rajagiriya, borella, 'punchi borella', maradana, kotahena]).

bus(180, nittambuwa, fort, [nittambuwa, yakkala, kirillawala, kadawatha, kiribathgoda, fort]).

bus(187/1, ekala, fort, [ekala, 'ja ela', kandana, welisara, wattala, peliyagoda, fort]).

bus(188, raddolugama, fort, [raddolugama, seeduwa, 'ja ela', kandana, wattala, peliyagoda, fort]).

bus(200, fort, gampaha, [fort, kiribathgoda, kadawatha, kirillawala, miriswatta, gampaha]).

bus(240, negombo, fort, [negombo, kattunayaka, seeduwa, 'ja ela', kandana, wattala, thotilanga, fort]).

% -----------------
% Graph Constructor (it turn the bus details into a grap, like creating a network to connect the cities for path finding)
% -----------------
nearbycity(A, B, N) :- 												% Checks if the two cities are directly connected on bus N
    bus(N, _, _, Stops),
    (append(_, [A,B|_], Stops); append(_, [B,A|_], Stops)).

unique_nearbycity(A, B, Bus) :- 									% Picks a deterministic bus for a city pair when multiple buses exist
    setof(N, nearbycity(A, B, N), [Bus|_]).

all_stops(Stops) :- 												% Collects a sorted list of all the cities as stops
    findall(S, (bus(_,_,_,Ls), member(S, Ls)), All),
    sort(All, Stops).

bus_bus(Bus, Stops) :- bus(Bus, _, _, Stops). 						% Returns all cities as stops for a specific bus

% -----------------
% Building Bus list by collected bus number along the path
% -----------------
build_buses([_], []). 												% if the path has only one stop, then no buses needed
build_buses([A,B|Rest], Buses) :-									% Determines which buses are used along given path of the cities as stops
    unique_nearbycity(A, B, FirstBus),
    build_buses_acc([B|Rest], FirstBus, [FirstBus], Buses).

build_buses_acc([_], _CurrentBus, Acc, Buses) :-					% Picks first bus and starts accumulator
    reverse(Acc, Buses).
build_buses_acc([X,Y|Rest], CurrentBus, Acc, Buses) :- 				% Walk through the path stop by stop, and build the list of buses used
    ( unique_nearbycity(X,Y,CurrentBus) ->							% Check if the current bus can continue or not
        NewAcc = Acc,
        NewBus = CurrentBus
    ; unique_nearbycity(X,Y,NewBus) ->
        NewAcc = [NewBus|Acc]
    ),
    build_buses_acc([Y|Rest], NewBus, NewAcc, Buses). 				% continue current bus or add new bus if transfer needed

% -----------------
% Bus Interchanging
% -----------------
find_switching(Path, Switching) :- 									% Scans the whole path, detects where the bus interchanges, and returns a list of transfer(Stop, FromBus, ToBus) structures
    findall(transfer(At, From, To),
        ( consecutive_edge_with_bus(Path, K, From), 
          K1 is K+1,
          consecutive_edge_with_bus(Path, K1, To),
          From \= To,
          nth1(K1, Path, At)
        ),
        RawSwitching),
    list_to_set(RawSwitching, Switching).

consecutive_edge_with_bus(Path, K, Bus) :- 							% Finds which bus connects two consecutive cities as stops in the path
    nth1(K, Path, A),
    K1 is K+1,
    nth1(K1, Path, B),
    unique_nearbycity(A, B, Bus).

% -----------------
% Algorithms
% -----------------
safe_call(Algo, Start, Goal, Path) :- 								% Calls any algorithm safely, avoids crashes

    catch(call(Algo, Start, Goal, Path), _, fail).

% Breadh Firsh Search Algorithm:-:

bfs(Start, Goal, Path) :-  											% Finds shortest path (fewest stops) from sart to goal
    bfs_search([[Start]], Goal, [Start], Rev),						% Bulid the paths backward
    reverse(Rev, Path).

bfs_search([[Goal|Rest]|_], Goal, _, [Goal|Rest]) :- !.				% (!) Stops the recurison when the goal in reached

bfs_search([Path|Queue], Goal, Visited, Sol) :-						% Explore all nearbycity of current stop / city in the breadh-first order
    Path = [Current|_],
    findall(Next,
        ( nearbycity(Current, Next, _),
          \+ memberchk(Next, Visited)
        ),
        Nexts),
    findall([N|Path], member(N, Nexts), NextPaths),
    append(Queue, NextPaths, NewQueue),
    append(Visited, Nexts, NewVisited),
    bfs_search(NewQueue, Goal, NewVisited, Sol).
	
% Depth Firsh Search Algorithm:-:

dfs(Start, Goal, Path) :-  											% Finds a path (may be longer) from start to goal
    dfs1(Start, Goal, [Start], Rev),
    reverse(Rev, Path).
	
dfs1(Goal, Goal, P, P) :- !.										% (!) Stops the recurison when the goal in reached
dfs1(Cur, Goal, Vis, Path) :-
    nearbycity(Cur, Next, _),
    \+ memberchk(Next, Vis),
    dfs1(Next, Goal, [Next|Vis], Path).
	
% Astar (A*) Search Algorithm:-:

astar(Start, Goal, Path) :-  					% Heuristic-based pathfinding
    astar_search([[Start]], Goal, Rev),
    reverse(Rev, Path).
astar_search([[Goal|Rest]|_], Goal, [Goal|Rest]) :- !.
astar_search([Path|Queue], Goal, Sol) :-
    Path = [Current|_],
    findall([Next|Path],
        (nearbycity(Current, Next, _), \+ memberchk(Next, Path)),
        NextPaths),
    append(Queue, NextPaths, Temp),
    sort_paths(Temp, Goal, Sorted),
    astar_search(Sorted, Goal, Sol).

path_cost(Path, Cost) :- length(Path, L), Cost is L - 1. 		% Number of stops along the path (not count the first stop)

heuristic(A, B, H) :- 											% Estimate distance from current stop to goal
    all_stops(Stops),
    nth1(I1, Stops, A),
    nth1(I2, Stops, B),
    H is abs(I1 - I2).

sort_paths(Paths, Goal, Sorted) :- 								% A* is faster than BFS and looks into paths with the lowest approximate total cost first,  for large graphs
    findall(F-Path,
        ( member(Path, Paths),
          Path = [Head|_],
          path_cost(Path, G),
          heuristic(Head, Goal, H),
          F is G + H
        ),
        Pairs),
    keysort(Pairs, SortedPairs),
    pairs_values(SortedPairs, Sorted).

% -----------------
% User Interface
% -----------------
run :- main_menu.											% Entry point, starts the main menu

main_menu :-    											% Display the main menu options and reads user inputs as string and pass it to handle_choice 
    nl, writeln('=============================='),
    writeln(' Colombo Bus Route Guider '),
    writeln('=============================='),
	writeln(' Please Choose your preference from the main menu: '),
    writeln('1) Find a bus'),
    writeln('2) Show all buses'),
    writeln('3) Exit'),
    prompt1('> '),
    read_line_to_string(user_input, S),
    handle_choice(S).

handle_choice("1") :- 										% Carries out the proper actions in response to menu choices and inputs from the user
    find_bus_flow,
    main_menu.
handle_choice("2") :-
    show_all_buses,
    main_menu.
handle_choice("3") :-
    writeln('Goodbye! Thank you for using our application'), !.
handle_choice(_) :-
    writeln('Invalid choice. Please select 1, 2 or 3.'),
    main_menu.


find_bus_flow :-											% Let the user find a route from the departure city to the arrival city step-by-step
    all_stops(Stops),										% Listout all availbale cities
    nl, writeln('List of Cities:'),							
    print_indexed(Stops, 1),								% Print all cities (numbering for easy selection)
    nl, read_index('Enter number for starting city: ', Stops, Start),
    read_index('Enter number for destination city: ', Stops, Goal),
    choose_algorithm_validated(Start, Goal, Algo),
    ( safe_call(Algo, Start, Goal, Path) ->
        build_buses(Path, Buses),
        find_switching(Path, Switching),
        path_cost(Path, Cost),   		% calculate path cost here
        format_bus_summary(Path, Buses, Switching, Cost, Summary),
        nl, writeln(Summary)
    ; writeln('No bus found for your selected destination.')
    ).


choose_algorithm_validated(Start, Goal, Algo) :-			% Ensure the user selects a pathfinding algorithm that can find a valid route between the start and goal
    repeat,
    choose_algorithm(UserAlgo),								% Prompt user for an algorithm choice
    ( safe_call(UserAlgo, Start, Goal, _) ->				% Test if the algorithm works safely
        Algo = UserAlgo, !        							% (!) stops the loop when a suitable algorithm is found and the chosen algorithm is valid
    ; writeln('The Travel Option you selected is not suitable for this route. Please choose another Travel Option.'),
      fail                       							% Continue the repeat loop
    ).


show_all_buses :- 											% Prints all buses with their stoping cities
    setof(Bus-Stops, bus_bus(Bus, Stops), Pairs),			% Collect all bus routes in sorted order
    nl, forall(member(Bus-Stops, Pairs), (					% Iterate over each bus and prints it's stoping cities
        format('Bus ~w: ', [Bus]),							% Print Bus numbers
        print_stops_arrow(Stops)							% Print the stops in the form (sotp1 -> stop2 -> stop3)
    )).

choose_algorithm(Algo) :- 					% Lets user pick BFS, DFS, or A* for pathfinding
    nl, writeln('Choose your preferred Travel Option:'),
    writeln('1) Shortest bus (BFS)'),
    writeln('2) Long bus (DFS)'),
    writeln('3) Smart Travel (A*)'),
    prompt1('> '),
    read_line_to_string(user_input, S),
    (   S = "1" -> Algo = bfs
    ;   S = "2" -> Algo = dfs
    ;   S = "3" -> Algo = astar
    ).

% -----------------
% Display Summary
% -----------------
format_bus_summary(Path, Buses, Switching, Cost, Summary) :-        % Creates a summary of routes that shows stops and switching for transfers in a user-friendly way
    mark_switching_in_path(Path, Switching, MarkedPath),			% Marks where switching occurs
    atomic_list_concat(MarkedPath, ' -> ', PathStr),				% Join the stops with arrows (->) for better user readability
    atomic_list_concat(Buses, ', ', BusesStr),						% Creates a list of bus numbers separated by commas
    switching_to_string(Switching, TStr),							% Forms bus switching information into strings.
    format(string(Summary),											% Organize all the information into a single summary string that is formatted correctly.
        '\n==============================\nYour Journey Summary\nstops at: ~w\nBuses Taken: ~w\nThis route has: ~w Stops\n\nBus Switching Points:\n~w\n==============================\nHave a Safe journey!\n',
        [PathStr, BusesStr, Cost, TStr]).


mark_switching_in_path([], _, []). 				     				% Adds "(Transfer)" label to stops where switching occur
mark_switching_in_path([Stop|Rest], Switching, [MarkedStop|MarkedRest]) :-
    ( member(transfer(Stop, _, _), Switching)
    -> atomic_list_concat([Stop, ' (Transfer)'], '', MarkedStop)
    ; MarkedStop = Stop
    ),
    mark_switching_in_path(Rest, Switching, MarkedRest).

switching_to_string([], 'No Bus switching needed.'). 				% Formats transfer information as readable text
switching_to_string(Switching, Str) :-
    findall(Line,
        (member(transfer(At, From, To), Switching),
         format(string(Line), 'Switch from Bus ~w to Bus ~w at ~w', [From, To, At])
        ),
        Lines),
    atomic_list_concat(Lines, '\n', Str).

print_indexed([], _). 												% Prints a numbered list of stoping cities for user entered input
print_indexed([H|T], I) :-
    format('~w. ~w~n', [I, H]),
    I2 is I+1, print_indexed(T, I2).

read_index(Prompt, List, Elem) :- 									% Reads and validates user selection by numbers
    repeat,
    write(Prompt),
    read_line_to_string(user_input, S),
    (   catch(number_string(N, S), _, fail),
        N >= 1, nth1(N, List, Elem)
    ->  true
    ;   writeln('Invalid index, try again.'), fail
    ).

print_stops_arrow([X]) :- format('~w~n', [X]). 						% Prints stops in arrow format for clarity
print_stops_arrow([A,B|Rest]) :- format('~w -> ', [A]), print_stops_arrow([B|Rest]).

% -----------------
% Entry point
% -----------------
:- initialization(run, main).					% Directive to run code when file loads 
												% The predicate that will execute (starts the program)
												% Run only if the file is executed as the main program
