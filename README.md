# Kimwitu(++) and Kotlin

This project aims to explore how to use pure Kotlin to simulate the term processors
[Kimwitu](https://fmt.ewi.utwente.nl/tools/kimwitu/) and
[Kimwitu++](https://www2.informatik.hu-berlin.de/sam/kimwitu++/).

## What is Kimwitu(++)?

Kimwitu++ is an extension to Kimwitu to create C++ instead of C. But what is Kimwitu?

Kimwitu is a language to _define_ the structure of an abstract syntax tree (AST) and
traverse/process an AST using pattern matching. It comes itself as an extension to C
(or C++), as a preprocessor. It turned out to be extremely handy in building compilers.

For an AST to capture mathematical expressions, a fragment could look like:

    term:
            Number(integer) | Ident(casestring);
    
    expression:
            Term( term )
            | Plus( expression expression );

The real power is using the AST data structure: There are _unparse_ and _rewrite_ rules
with extensive pattern matching.

    Plus( exp1, exp2 )
        ->    [: exp1 "+" exp2 ];
    Plus( Term(Number(a)), Term(Number(b)) )
        ->    <: Term(Number(plus(a,b)))>;
            
The [Kimwitu++ example](https://www2.informatik.hu-berlin.de/sam/kimwitu++/example/)
contains an almost self-explanatory program that reads expressions in RPN and writes
them out in different notations.

So, what’s bad about it? Well, I do not use neither C nor C++ these days, and really
both projects have come to a halt.

## KotlinK?

It is a non-goal to create a real KotlinK. I do not have the resources, I do not have
the need anymore.

## Ersatz

A typical Kimwitu/Kimwitu++ program had three parts (or four, with two being very
very similar):

1. A lexing/parsing phase. (Well, we could count that as two parts as well, I guess).
   In the old days, I used flex and bison, which are great tools – but for C.
1. A definition of the AST data structure. I used Kimwitu++ for this part.
1. Many rules to
   1. transform the AST (_rewrite_ it) to some normalized or simplified form,
   1. and equally many to use the final AST for writing out some result (_unparse_ it,
   also to C++ in my old projects, where we created compilers that had C or C++ as the
   target language). I used Kimwitu++ for these parts as well, of course.

### Lexing and parsing

I’m not a compiler writer anymore, so I really do not know what’s en vogue, but seeing
that ANTLR was the tool of choice a decade ago and seems to be popular still, I concede
that I should finally be learning it. There are several Kotlin libraries to create
parsers without external programs, but for the real Bison feeling I won’t use them, and
also not the listener approach that is obviously favoured by the ANTLR author.

Without talking too much about the next bullet point in this file: The generated parser
will be in Java, not in Kotlin. That means that, even though I wanted to create a Kotlin
project, I had to write the actions in Java fragments. So, for this good old Bison
feeling I had to sacrifice Kotlin in the lexer/parser.

The result is in [Rpn.g4](file:src/main/antlr4/de/piefel/Rpn.g4). One example parser
rule looks like this, the closest I could get to the original Bison code:

```antlrv4
term returns [Term trm]:
    NUMBER
        { $trm = new Number($NUMBER.int); }
    | IDENT
        { $trm = new Ident($IDENT.text); }
    ;
```

### Definition of the AST

That is the simple part! Support is virtually built into the language, it’s `sealed`
classes and `data` classes.

One thing that did not map well was the convention to name
the phyla (the abstract node types of the AST) starting with a lowercase letter (often
the very same name as the corresponding parser rule) and the names of the creator
functions starting with an uppercase letter. The phyla are now classes, and I will stick
to upper-case class names here. The creator functions – well, the easy mapping is to
have those as _constructors_, not regular functions, meaning that they can be upper-case,
too. In Kotlin proper, a phylum creation would look exactly the same as in my old C++
code (unfortunately, though, the creation is fom Java, oh well).

The definition of the abstract phylum `term` above can now be written as:
```kotlin
sealed class Term
data class Number(val integer: Int) : Term()
data class Ident(val casestring: String) : Term()
```

The only downside is that it looks a bit unconnected, the classes do not have to stand
together, but at least they must be within the same source file. Also, I need additional
names for the parameters, because they map to properties. Sometimes that’s a bit superfluous,
sometimes it is helpful.
