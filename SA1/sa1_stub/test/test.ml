open OUnit2
open Recq.Interp
open Recq.Ds

(* A few test cases *)
let tests_let = [
  "int"  >:: (fun _ -> assert_equal (Ok (NumVal 22)) (interp "22"));
  "add"  >:: (fun _ -> assert_equal (Ok (NumVal 22)) (interp "11+11"));
  "adds" >:: (fun _ -> assert_equal (Ok (NumVal 22)) (interp "(10+1)+(5+6)"));
  "let"  >:: (fun _ -> assert_equal (Ok (NumVal 22)) (interp "let x=22 in x"));
  "lets" >:: (fun _ -> assert_equal (Ok (NumVal 22)) (interp "let x = 0 in let x = 22 in x"));
]


let tests_proc = [
  "int"  >:: (fun _ -> assert_equal (Ok (NumVal 3))
                 (interp "(proc (x) { x+1 } 2)"))
]

let tests_rec = [
  "int"  >:: (fun _ -> assert_equal (Ok (NumVal 120))
                 (interp "letrec f(x) = if zero?(x) then 1 else x*(f (x-1))
in (f 5)"))
]

let tests_recht = [
  "queue1"  >:: (fun _ -> assert_equal (Ok (QueueVal []))
                 (interp "emptyqueue"))
  ;
  "queue2"  >:: (fun _ -> assert_equal (Ok (QueueVal [NumVal 4; NumVal 3; NumVal 2; NumVal 1]))
                 (interp "addq(4, addq(3, addq(2, addq(1, emptyqueue))))"))
  ;
    "queue3"  >:: (fun _ -> assert_equal (Ok (QueueVal [NumVal 4; NumVal 3; NumVal 2]))
                      (interp
                         "remove(addq(4, addq(3, addq(2, addq(1, emptyqueue)))))"))
  ;
    "queue4"  >:: (fun _ -> assert_equal (Ok (NumVal 1))
                      (interp
                         "element(addq(4, addq(3, addq(2, addq(1, emptyqueue)))))"))
  ;
    "queue5"  >:: (fun _ -> assert_equal (Ok (NumVal 4))
                      (interp
                          "size(addq(4, addq(3, addq(2, addq(1, emptyqueue)))))"))
  ;
     "queue6"  >:: (fun _ -> assert_equal ( Ok (BoolVal false))
                      (interp
                           "empty?(addq(4, addq(3, addq(2, addq(1, emptyqueue)))))"))
]

let _ = run_test_tt_main ("suite" >::: (tests_let @ tests_proc
                                        @ tests_rec @  tests_recht))
