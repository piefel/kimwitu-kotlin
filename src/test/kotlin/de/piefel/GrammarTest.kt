package de.piefel

import org.antlr.v4.runtime.CharStreams
import org.antlr.v4.runtime.CommonTokenStream
import org.antlr.v4.runtime.Token
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

internal class GrammarTest {

    @Test
    fun lexer() {
        val lexer = RpnLexer(CharStreams.fromString("a 4 id 42\n"))
        val allTokens: List<Token> = lexer.allTokens

        assertThat(allTokens.map { it.type }).isEqualTo(listOf(
                RpnLexer.IDENT, RpnLexer.NUMBER, RpnLexer.IDENT, RpnLexer.NUMBER, RpnLexer.EOL))
    }

    @Test
    fun parser() {
        val lexer = RpnLexer(CharStreams.fromString("4 a +"))
        val tokenStream = CommonTokenStream(lexer)
        val parser = RpnParser(tokenStream)

        val lineContext: RpnParser.LineContext = parser.line()
        val line: Line = lineContext.ln

        assertThat(line.expression).isInstanceOf(Plus::class.java)
        assertThat((line.expression as Plus).exp1).isInstanceOf(TermExpression::class.java)
        assertThat((line.expression as Plus).exp2).isInstanceOf(TermExpression::class.java)

        assertThat(((line.expression as Plus).exp1 as TermExpression).term).isInstanceOf(Number::class.java)
        assertThat(((line.expression as Plus).exp2 as TermExpression).term).isInstanceOf(Ident::class.java)
    }

}
