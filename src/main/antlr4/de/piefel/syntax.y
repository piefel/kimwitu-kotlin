%{
// Reverse Polish Notation, syntax.y
// © 2001, Michael Piefel <piefel@informatik.hu-berlin.de>

#include "k.h"
#include "yystype.h"
#include <cstdlib>
#include <string>

extern void yyerror(const char*);
extern int yylex();
%}

%token <yt_integer> NUMBER
%token <yt_casestring> IDENT
%token NEWLINE

%type <yt_expression> expression
%type <yt_term> term
%type <yt_line> line

%%

line:
        expression
        { TheLine = $$ = Line($1); };


term:
        NUMBER
        { $$ = Number($1); }
        | IDENT
        { $$ = Ident($1); }
;


expression:
        term
        { $$ = Term($1); }
        | expression expression '+'
        { $$ = Plus($1,$2); }
        | expression expression '*'
        { $$ = Mul($1,$2); }
        | expression expression '-'
        { $$ = Minus($1,$2); }
        | expression expression '/'
        { $$ = Div($1,$2); }
;
