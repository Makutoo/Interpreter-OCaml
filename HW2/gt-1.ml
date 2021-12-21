(** CS510 Assignment2 general trees operations *)
(** Author: Ziheng Zhu  *)
(** Create Date: Sep 27 *)
(** Last modified Sep 28*)

type 'a gt = Node of 'a*('a gt) list;;
let t : int gt = 
    Node (33,
        [Node  (12 ,[]);
        Node (77,
            [Node (37,
                [Node (14, [])]);
            Node (48, []);
            Node  (103,  [])])]);;

let t1 : int gt = 
    Node(33,[
        Node(12,[
            Node(7,[])]);
        Node(44,[
            Node(22,[]); Node(41,[])]);
        Node(35,[
            Node(23,[]); Node(33, [
                Node(11,[])
            ])
        ])]);;

let t2 : int gt = 
    Node(33,[
        Node(12,[
            Node(7,[]); Node(44,[])]);
        Node(44,[
            Node(22,[]); Node(41,[])]);
        Node(35,[
            Node(23,[]); Node(33, [])])
        ]);;

let t3 : int gt = 
    Node(33,[
        Node(12,[])
        ]);;

(** exercise 1 *)
let rec map : ( 'a -> 'b ) -> 'a list -> 'b list  =
  fun f l ->
   match l with
  | [] -> []
  | h::t -> f h :: map f t

(** The function return the max element in the list *)
let rec getMax l = 
    match l with 
    |[] -> failwith "None"
    |h::[] -> h
    |h::next::t -> getMax(max(h)(next)::t);;

let rec height t = 
    match t with
    |Node(d,[]) -> 1 (* if current node is leaf, then its height is 1*)
    |Node(d, l) -> 1 + getMax(map height l);; (* if current node has children, then its height is 1 plus the Max height among its children *)

(* 
print_int (height t);;
print_int (height t1);;
*)

(** exercise 2 *)
let rec map' f l =
   match l with
  | [] -> 0
  | h::t -> f h + (map' f t);;

let rec size t = 
    match t with 
    |Node(d, []) -> 1
    |Node(d, l) -> 1 + map' size l;;


(** Different way to get size *)
let rec sum l = 
    match l with
    |[]-> 0
    |Node(d, dl)::t -> 1 + sum dl+ sum t;;

let rec size' t = 
    match t with 
    |Node(d, l) -> 1 + sum l;;

(** 
print_int (size t);;
print_int (size t1);;
print_int (size' t);;
print_int (size' t1);;
*)

(** exercise 3 *)
(** function paths_to_leaves return every path from the root to leaves *)
(** functioin paths_to_leaves' is the answer for assignment  *)
let rec map'' f l =
   match l with
  | [] ->  failwith "Impossible" (** function paths_to_leaves will handle empty list case  *)
  | h :: [] -> f h 
  | h::t -> f h @ map'' f t;;

let rec append_to_front n l = 
    match l with
    |[] -> []
    |h :: t -> (n :: h) :: append_to_front n t;;

let rec paths_to_leaves t = 
    match t with
    |Node(d,[]) -> [[d]] (** Here handle empty list case *)
    |Node(d, l) -> append_to_front d (map'' paths_to_leaves l);;


let rec to_index l i = 
    match l with 
    |[] -> []
    |Node(d, l)::t -> Node(i,l) :: to_index t (i+1);;

(** this functioin change d to its index in the list *)
let rec modi_tree t = 
    match t with
    |Node(d, l) -> Node(d, map modi_tree(to_index l 0));;

let remove_first l = 
    match l with 
    |[] -> []
    |h :: t -> t;;

let paths_to_leaves' t = map remove_first (paths_to_leaves (modi_tree t));;

(** exercise 4 *)
(** Using paths_to_leaves fuction from exercise 3, if all the paths have the same length then true else false *)
let rec path_depths l = map List.length l;;

let rec is_leaf_perfect_helper l = 
    match l with
    |[] -> true
    |h::[]-> true
    |h::next::t -> if(h = next) then is_leaf_perfect_helper (next::t) else false;;

let is_leaf_perfect t = is_leaf_perfect_helper(path_depths(paths_to_leaves t));;

(** exercise 5 *)
let rec preorder t =
    match t with
    |Node(d, []) -> [d]
    |Node(d, l) -> d :: map'' preorder l;;

(** exercise 6 *)
let rec mirror t =
    match t with
    |Node(d, []) -> Node(d, [])
    |Node(d, l) -> Node(d, List.rev(map mirror l));;

(** exercise 7 *)
let rec mapt f t = 
    match t with 
    |Node(d, []) -> Node(f d, []);
    |Node(d, l) -> Node(f d, map (mapt f) l);;

(** exercise 8 *)
let rec foldt f t = 
    match t with
    |Node(d, l) -> f d (map (foldt f) l);;

let  sumt t = foldt (fun i rs -> i + List.fold_left (fun i j -> i+j) 0 rs) t;;
let  memt t e =foldt (fun i rs -> i=e || List.exists (fun i -> i) rs) t;;

(** exercise 9 *)
let mirror' t = foldt (fun i rs -> Node(i, List.rev(rs))) t;;