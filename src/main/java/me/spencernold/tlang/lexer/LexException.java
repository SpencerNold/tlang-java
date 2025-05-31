package me.spencernold.tlang.lexer;

import me.spencernold.tlang.compiler.TLangCompileException;

public class LexException extends TLangCompileException {

    private final String message;
    private final int line;
    private final String context;

    public LexException(String message, int line, String context) {
        this.message = message;
        this.line = line;
        this.context = context;
    }

    @Override
    public void print() {
        System.out.printf("%s on line %d: '%s'\n", message, line, context);
    }
}
