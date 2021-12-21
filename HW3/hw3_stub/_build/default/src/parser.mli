
(* The type of tokens. *)

type token = 
  | TL
  | TIMES
  | THEN
  | RPAREN
  | RBRACE
  | PROC
  | PLUS
  | OF
  | NODE
  | MINUS
  | LPAREN
  | LET
  | LBRACE
  | ISZERO
  | INT of (int)
  | IN
  | IF
  | ID of (string)
  | HD
  | EQUALS
  | EOF
  | EMPTYTREE
  | EMPTYLIST
  | EMPTY
  | ELSE
  | DIVIDED
  | CONS
  | COMMA
  | CASET
  | ARROW
  | ABS

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.prog)
