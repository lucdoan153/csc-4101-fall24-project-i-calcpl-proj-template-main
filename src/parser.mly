%{
open Ast
%}

%token <int> INT
%token <float> FLOAT
%token <string> ID
%token TRUE
%token FALSE
%token LEQ
%token GEQ
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token PLUS_F
%token MINUS_F
%token TIMES_F
%token DIV_F
%token LPAREN
%token RPAREN
%token LET
%token EQUALS
%token IN
%token IF
%token THEN
%token ELSE
%token COLON
%token INT_TYPE
%token BOOL_TYPE 
%token FLOAT_TYPE
%token EOF

%left LEQ GEQ
%left PLUS MINUS
%left TIMES DIV
%left PLUS_F MINUS_F
%left TIMES_F DIV_F
%nonassoc IN
%nonassoc ELSE

%%

prog:
  | e = expr; EOF { e }

expr:
  | i = INT { Int i }
  | f = FLOAT { Float f }
  | x = ID { Var x }
  | TRUE { Bool true }
  | FALSE { Bool false }
  | e1 = expr; PLUS; e2 = expr { Binop (Add, e1, e2) }
  | e1 = expr; MINUS; e2 = expr { Binop (Sub, e1, e2) }
  | e1 = expr; TIMES; e2 = expr { Binop (Mult, e1, e2) }
  | e1 = expr; DIV; e2 = expr { Binop (Div, e1, e2) }
  | e1 = expr; PLUS_F; e2 = expr { Binop (AddF, e1, e2) }
  | e1 = expr; MINUS_F; e2 = expr { Binop (SubF, e1, e2) }
  | e1 = expr; TIMES_F; e2 = expr { Binop (MulF, e1, e2) }
  | e1 = expr; DIV_F; e2 = expr { Binop (DivF, e1, e2) }
  | e1 = expr; LEQ; e2 = expr { Binop (Leq, e1, e2) }
  | e1 = expr; GEQ; e2 = expr { Binop (Geq, e1, e2) }
  | LET; x = ID; COLON; t = typ; EQUALS; e1 = expr; IN; e2 = expr
        { Let (x, t, e1, e2) }
  | IF; e1 = expr; THEN; e2 = expr; ELSE; e3 = expr
        { If (e1, e2, e3) }
  | LPAREN; e = expr; RPAREN { e }

typ:
  | INT_TYPE { TInt }
  | BOOL_TYPE { TBool }
  | FLOAT_TYPE { TFloat }
