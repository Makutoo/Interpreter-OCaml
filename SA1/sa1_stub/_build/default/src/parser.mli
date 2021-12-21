
(* The type of tokens. *)

type token = 
  | TIMES
  | THEN
  | SIZE
  | SETREF
  | SET
  | SEMICOLON
  | RPAREN
  | REMOVE
  | RBRACE
  | PROC
  | PLUS
  | NEWREF
  | MINUS
  | LPAREN
  | LETREC
  | LET
  | LBRACE
  | ISZERO
  | ISEMPTY
  | INT of (int)
  | IN
  | IF
  | ID of (string)
  | EQUALS
  | EOF
  | END
  | EMPTYQUEUE
  | ELSE
  | ELEMENT
  | DIVIDED
  | DEREF
  | DEBUG
  | COMMA
  | BEGIN
  | ADDQ

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expr)
