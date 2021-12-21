
(* The type of tokens. *)

type token = 
  | UNPAIR
  | TL
  | TIMES
  | THEN
  | SUPER
  | SND
  | SETREF
  | SET
  | SEND
  | SEMICOLON
  | SELF
  | RPAREN
  | RBRACE
  | PROC
  | PLUS
  | PAIR
  | NEWREF
  | NEW
  | MINUS
  | METHOD
  | LPAREN
  | LIST
  | LETREC
  | LET
  | LBRACE
  | ISZERO
  | INT of (int)
  | IN
  | IF
  | ID of (string)
  | HD
  | FST
  | FIELD
  | EXTENDS
  | EQUALS
  | EOF
  | END
  | EMPTYPRED
  | ELSE
  | DOT
  | DIVIDED
  | DEREF
  | DEBUG
  | CONS
  | COMMA
  | CLASS
  | BEGIN

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.prog)
