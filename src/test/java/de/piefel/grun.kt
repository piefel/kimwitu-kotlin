package de.piefel

import org.antlr.v4.gui.TestRig

fun main() {
    println("Starting TestRig")
    TestRig.main(arrayOf("de.piefel.rpn", "line", "-gui"))
//    TestRig.main(arrayOf())
}
