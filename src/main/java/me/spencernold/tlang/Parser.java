package me.spencernold.tlang;

import me.spencernold.tlang.parser.TokenStream;

public class Parser {

    private final TokenStream stream;

    public Parser(Lexer lexer) {
        this.stream = TokenStream.wrap(lexer);
    }

    public void parseFile() {
        
    }
}
