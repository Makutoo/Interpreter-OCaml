(** CS510 Assignment1 Mini-Logo Programs *)
(** Author: Ziheng Zhu  *)
(** Create Date: Sep 12 *)
(** Last modified Sep 18*)

(** Defined Datatypes *)
type  program = int  list;;
let  square : program = [0; 2; 2; 3; 3; 4; 4; 5; 5; 1];;
let  letter_e : program = [0;2;2;3;3;5;5;4;3;5;4;3;3;5;5;1];;

(** This function print list of int *)
let rec print_list_int l = 
    match l with 
    |[] -> print_endline ""
    | h::t -> print_int h ; print_string " " ; print_list_int t;;

(** Define map *)
let rec map : ( 'a -> 'b ) -> 'a list -> 'b list  =
  fun f l ->
   match l with
  | [] -> []
  | h::t -> f h :: map f t

(** Exercises 1 *)
(** This is helper function for function mirror_image *)
let mirror_image_helper n = 
    match n with
    |2 -> 4
    |4 -> 2
    |3 -> 5
    |5 -> 3
    |_ -> n;;

(** Without using map *)
let rec mirror_image  l = 
    match l with
    |[] -> []
    |h::t -> mirror_image_helper(h)::mirror_image(t);;

(** Using map *)
let mirror_image' = map mirror_image_helper;;

(** TESTING fuction mirror_image/mirror_image' *)
(** 
print_endline "Before apply funtion \"mirror_image\":";;
print_list_int(letter_e);;
print_endline "After apply funtion \"mirror_image\":";;
print_list_int(mirror_image'(letter_e));;
*)

(** Exercises 2 *)
(** This is helper function for function rotate_90_letter *)
let rotate_90_letter_helper n = 
    match n with
    |2 -> 3
    |3 -> 4
    |4 -> 5
    |5 -> 2
    |_ -> n;;

(** Without using map *)
let rec rotate_90_letter l = 
    match l with 
    |[] -> []
    |h::t -> rotate_90_letter_helper(h)::rotate_90_letter(t);;  

(** Using map *)
let rotate_90_letter' = map rotate_90_letter_helper;;


(** TESTING fuction rotate_90_letter/rotate_90_letter' *)
(** 
print_endline "Before apply funtion \"rotate_90_letter\":";;
print_list_int(letter_e);;
print_endline "After apply funtion \"rotate_90_letter\":";;
print_list_int(rotate_90_letter(letter_e));;
print_endline "After apply funtion \"rotate_90_letter'\":";;
print_list_int(rotate_90_letter'(letter_e));;
*)

(** Exercises 3 *)
(** Without using map *)
let rec rotate_90_word l = 
    match l with
    |[] -> []
    |h::t -> rotate_90_letter(h)::rotate_90_word(t);;

(** Using map *)
let rotate_90_word' = map rotate_90_letter';;


(** Exercises 4 *)
let rec repeat n x = 
    match n with
    |0 -> []
    |_ -> x :: repeat (n-1) x;;

(** Exercises 5 *)
(** Define map for Exercises 5 *)
let rec map' = fun f n l ->
    match l with
    |[] -> []
    |h::t -> f n h @ map' f n t;;

(** This is helper function for function pantograph *)
let rec pantograph_helper n x = 
    match n with 
    |0 -> []
    |_ -> 
        if(x = 2 || x = 3 || x = 4 || x = 5) then x :: pantograph_helper(n-1) x
        else [x] ;;

(** Using map *)
let pantograph' = map' pantograph_helper;;

(** Without using map *)
let rec pantograph_nm n p = 
    match p with 
    |[] -> []
    |h::t -> pantograph_helper n h @ pantograph_nm n t;;

(** Define fold for Exercises 5 *)
let rec foldr  =
  fun f a n l ->
  match l with
  | [] -> a
  | h::t -> f h n (foldr f a n t);;

(** Using fold *)
let pantograph_f = foldr (fun h n r -> (pantograph_helper n h) @ r) [];;


(** TESTING function pantograph_nm/pantograph'/pantograph_f *)
(** 
print_endline "Before apply funtion \"pantograph\":";;
print_list_int(letter_e);;
print_endline "After apply funtion \"pantograph_nm\":";;
print_list_int(pantograph_nm 2 letter_e);;
print_endline "After apply funtion \"pantograph'\":";;
print_list_int(pantograph' 2 letter_e);;
print_endline "After apply funtion \"pantograph_f'\":";;
print_list_int(pantograph_f 2 letter_e);;
*)

(** Exercises 6 *)
(** helper function for function coverage *)
let to_coordinate (x, y) num = 
    match num with 
    |2 -> (x, y+1)
    |3 -> (x+1, y)
    |4 -> (x, y-1)
    |5 -> (x-1, y)
    |_ -> (x,y);;

let rec coverage (x, y) l = 
    match l with 
    |[] -> []
    |h::t -> to_coordinate (x,y) h :: coverage(to_coordinate (x, y) h) t;;

(** This function print list of (int, int) *)
let rec print_list_turple_int l = 
    match l with 
    |[] -> ()
    |(a,b)::t -> print_string"("; print_int a; print_string","; print_int b; print_string ")"; print_list_turple_int t;;

(** TESTING fuction coverage *)
(** print_list_turple_int(coverage (0,0) letter_e);; *)




(** Exercises 7 *)
(** This fuction convert int list to (int, 1) list *)
let rec to_tuple_list l = 
    match l with
    |[] -> []
    |h::t -> (h,1) :: to_tuple_list(t);;

(** This is helper functioin for functioin compress *)
let rec compress_helper l = 
    match l with
    |[]->[]
    |(a,b)::[] -> (a,b) :: []
    |(a,b) :: (c,d) :: t ->
        if(a = c)
            then compress_helper((c, b+d) :: t)
        else 
            (a,b) :: compress_helper((c,d)::t);;

let compress l = compress_helper(to_tuple_list(l));;

(** TESTING functioin compress *)
(** print_list_turple_int(compress letter_e);; *)

(** Exercises 8 *)
let rec uncompress l = 
    match l with
    |[] -> []
    |(a, b) :: t ->
        if(b > 1) then a :: uncompress(((a, b-1) :: t))
        else a :: uncompress(t);;

(** TESTING functioin uncompress *)
(** print_list_int(uncompress(compress(letter_e)));; *)

(** Exercises 9 *)
(** This is helper function for function optimize *)
let rec optimize_helper l = 
    match l with
    |[] -> []
    |h :: [] -> h :: []
    |h :: next :: t -> 
        if(h != next) then h :: optimize_helper(next :: t)
        else 
            if(h != 0 && h != 1) then h :: next :: optimize_helper(t)
            else optimize_helper(next :: t);;

(** This function remove first number '1' in list if exist *)            
let remove_first_1 l = 
    match l with 
    |[] -> []
    |h::t -> 
        if(h = 1) then t
        else h::t;;

let optimize l = remove_first_1(optimize_helper(l));;


(** TESTING function optimize *)
(** print_list_int(optimize [1]);; *)
(** print_list_int(optimize [1;1;1;1]);; *)
(** print_list_int(optimize [1;1;1;1;0]);; *)
(** print_list_int(optimize [1;1;1;1;0;1;0;1]);; *)
(** print_list_int(optimize [1;1;1;1;0;1;0;1;1;1;1]);; *)
(** print_list_int(optimize [0;1;0;1]);; *)
(** print_list_int(optimize [2;3;4;5]);; *)