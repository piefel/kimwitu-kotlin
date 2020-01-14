grammar Rpn;

/*
Original bison code:


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

*/

// My root. Ignore IntelliJ warning.
line returns [Line ln]:
    expression
        { $ln = new Line($expression.ctx.exp); };

term returns [Term trm]:
    NUMBER
        { $trm = new Number($NUMBER.int); }
    | IDENT
        { $trm = new Ident($IDENT.text); }
    ;

expression returns [Expression exp]:
    term
        { $exp = new TermExpression($term.ctx.trm); }
    | l=expression r=expression '+'
        { $exp = new Plus($l.ctx.exp, $r.ctx.exp); }
    | l=expression r=expression '*'
        { $exp = new Mul($l.ctx.exp, $r.ctx.exp); }
    | l=expression r=expression '-'
        { $exp = new Minus($l.ctx.exp, $r.ctx.exp); }
    | l=expression r=expression '/'
        { $exp = new Div($l.ctx.exp, $r.ctx.exp); }
    ;


/*
Original flex code:

    // Reverse Polish Notation, lexic.l
    // © 2001, Michael Piefel <piefel@informatik.hu-berlin.de>

    #include <iostream>
    #include "k.h"
    #include "yystype.h"
    #include "syntax.h"
    #include "rpn.h"

%option noyywrap

%%

-?[0-9]+    { yylval.yt_integer = mkinteger(atoi(yytext)); return NUMBER;}
[a-z]+      { yylval.yt_casestring = mkcasestring(yytext); return IDENT; }
[+*-/]      { return yytext[0]; }
[\t ]+      { / * empty * / }
\n          { return EOF; }
.           { std::cerr << "Unkown character: " << yytext[0] << std::endl; }

%%

extern void yyerror(const char *s)
{
    std::cerr << "Syntax error: " << s << std::endl;
}

*/

NUMBER: '-'?[0-9]+ ;

IDENT: [a-z]+ ;

WS: [\t ]+ -> skip ;

EOL: '\n' ;

