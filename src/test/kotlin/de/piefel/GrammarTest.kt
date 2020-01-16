package de.piefel

import org.antlr.v4.runtime.CharStreams
import org.antlr.v4.runtime.Token
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

internal class GrammarTest {

    @Test
    fun lexer() {
        val lexer = RpnLexer(CharStreams.fromString("4 a"))
        val allTokens: List<Token> = lexer.allTokens

        assertThat(allTokens.map { it.type }).isEqualTo(listOf(RpnLexer.IDENT, RpnLexer.NUMBER))
    }

}
