{
open Parser
}

let white = [' ' '\t']+
let digit = ['0'-'9']
let float = digit+ '.' digit+
let int = '-'? digit+
let letter = ['a'-'z' 'A'-'Z']
let id = letter+

rule read =
  parse
  | white { read lexbuf }
  | "true" { TRUE }
  | "false" { FALSE }
  | ">=" { GEQ }
  | "=>" { GEQ }
  | "<=" { LEQ }
  | "+." { PLUS_F }
  | "-." { MINUS_F }
  | "*." { TIMES_F }
  | "/." { DIV_F }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { TIMES }
  | "/" { DIV }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | "let" { LET }
  | "=" { EQUALS }
  | "in" { IN }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | ":" { COLON }
  | "int" { INT_TYPE }
  | "bool" { BOOL_TYPE }
  | "float" { FLOAT_TYPE }
  | float { FLOAT (float_of_string (Lexing.lexeme lexbuf)) }
  | int { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | id { ID (Lexing.lexeme lexbuf) }
  | eof { EOF }
