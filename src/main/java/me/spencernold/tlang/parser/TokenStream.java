package me.spencernold.tlang.parser;


import me.spencernold.tlang.Errors;
import me.spencernold.tlang.Lexer;
import me.spencernold.tlang.lexer.Token;

import java.io.IOException;

public class TokenStream {

    private final Lexer lexer;

    private Token<?> next;

    private TokenStream(Lexer lexer) throws IOException {
        this.lexer = lexer;
        this.next = lexer.yylex();
    }

    public Token<?> next() throws IOException {
        Token<?> next = this.next;
        this.next = lexer.yylex();
        return next;
    }

    public Token<?> peek() {
        return next;
    }

    public static TokenStream wrap(Lexer lexer) {
        try {
            return new TokenStream(lexer);
        } catch (IOException e) {
            Errors.print(e);
            return null;
        }
    }
}
