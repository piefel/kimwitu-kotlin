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
