grammar Rpn;

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


NUMBER: '-'?[0-9]+ ;

IDENT: [a-z]+ ;

WS: [\t ]+ -> skip ;

EOL: '\n' ;

