package de.piefel

import org.antlr.v4.runtime.CharStreams
import org.antlr.v4.runtime.CommonTokenStream

fun main() {
    val lexer = RpnLexer(CharStreams.fromString("4 a +"))
    val tokenStream = CommonTokenStream(lexer)
    val parser = RpnParser(tokenStream)

    val lineContext: RpnParser.LineContext = parser.line()
    val line: Line = lineContext.ln

    println("line = ${line}")
}
