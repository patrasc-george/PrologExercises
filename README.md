# Overview
This Prolog file contains various predicates for list manipulation and logic puzzles. The primary functionalities include flattening nested lists, calculating the greatest common divisor (GCD) of list elements, adding elements after specific positions in a list, counting occurrences of elements, deleting doubled values, finding maximum values and deleting them, finding differences between lists, adding elements after each list item, generating unions of lists, creating pairs from list elements, and solving a logic puzzle based on given hints.

# Flattening a Nested List
The flatten_list/2 predicate is used to convert a nested list into a single flattened list. It recursively processes each element, appending lists within lists to produce a single-level list.

Example Usage<br>
Given a nested list [1, [2, [3, 4], 5], 6], the predicate will produce the flattened list [1, 2, 3, 4, 5, 6].

# Greatest Common Divisor of List Elements
The list_gcd/2 predicate calculates the greatest common divisor (GCD) of a list of integers. It uses the Euclidean algorithm to determine the GCD of two numbers and applies this recursively across the list.

Example Usage
For the list [12, 15, 21], the predicate will find the GCD to be 3.

# Adding Elements After Specific Positions in a List
The add_after_pos_pow_2/3 predicate inserts a specified element after every position in the list that is a power of 2. It leverages an auxiliary predicate to handle the insertion logic.

Example Usage
For the list [1, 2, 3, 4, 5] and element x, the resulting list will be [1, x, 2, 3, x, 4, 5].

# Counting Occurrences of Elements
The number_atom/2 predicate counts the occurrences of each element in a list and returns a list of pairs, where each pair consists of an element and its count.

Example Usage
For the list [1, 2, 2, 3, 3, 3], the resulting list of pairs will be [[1, 1], [2, 2], [3, 3]].

# Deleting Doubled Values
The delete_doubled_values/2 predicate removes elements from a list that appear more than once, ensuring that only unique elements remain in the resulting list.

Example Usage
For the list [1, 2, 2, 3, 4, 4], the resulting list will be [1, 3].

# Finding Maximum and Deleting It
The delete_max/2 predicate finds the maximum value in a list and deletes all occurrences of this value from the list.

Example Usage
For the list [1, 3, 3, 4, 5, 5], the resulting list will be [1, 3, 3, 4] after deleting the maximum value 5.

# Finding Difference Between Lists
The diff/3 predicate computes the difference between two lists, resulting in elements that are present in the first list but not in the second.

Example Usage
For the lists [1, 2, 3] and [2, 3, 4], the resulting list will be [1].

# Adding 1 After Each Element
The add_1_after_elements/2 predicate adds the number 1 after each element in the list.

Example Usage
For the list [1, 2, 3], the resulting list will be [1, 1, 2, 1, 3, 1].

# Reunion of Multitudes
The reunion_of_multitudes/3 predicate computes the union of two lists, ensuring that each element appears only once in the resulting list.

Example Usage
For the lists [1, 2, 3] and [2, 3, 4], the resulting union list will be [1, 2, 3, 4].

# Einstein's Riddle
Einstein's Riddle is a logic puzzle involving five houses of different colors, inhabited by people of different nationalities, with different pets, drinks, and cigarettes. The objective is to determine who drinks water and who owns the zebra based on a set of 14 clues.

Clues
The Brit lives in the red house.
The Spaniard owns the dog.
Coffee is drunk in the green house.
The Ukrainian drinks tea.
The green house is immediately to the right of the ivory house.
The Old Gold smoker owns snails.
Kools are smoked in the yellow house.
Milk is drunk in the middle house.
The Norwegian lives in the first house.
The man who smokes Chesterfields lives next to the man with the fox.
Kools are smoked in the house next to the house with the horse.
The Lucky Strike smoker drinks orange juice.
The Japanese smokes Parliaments.
The Norwegian lives next to the blue house.

Objective
Using the given clues, the solution predicate deduces who drinks water and who owns the zebra.

Example Usage
The solution/1 predicate will deduce the attributes of each person and their houses based on the provided hints, allowing you to answer questions such as who drinks water and who owns the zebra.
