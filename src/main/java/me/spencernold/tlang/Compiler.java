package me.spencernold.tlang;

import java.io.Reader;

public class Compiler {

    public void compile(Reader reader) {
        Lexer lexer = new Lexer(reader);
        Parser parser = new Parser(lexer);
        parser.parse();
    }
}
