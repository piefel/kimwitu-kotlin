package de.piefel

data class Line(val expression: Expression)

sealed class Term
data class Number(val integer: Int) : Term()
data class Ident(val casestring: String) : Term()

sealed class Expression
data class TermExpression(val term: Term) : Expression()
data class Plus(val exp1: Expression, val exp2: Expression) : Expression()
data class Mul(val exp1: Expression, val exp2: Expression) : Expression()
data class Minus(val exp1: Expression, val exp2: Expression) : Expression()
data class Div(val exp1: Expression, val exp2: Expression) : Expression()
data class Div2(val exp1: Expression, val casestring: String, val exp2: Expression) : Expression()

