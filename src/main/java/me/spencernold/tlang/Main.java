package me.spencernold.tlang;

import me.spencernold.tlang.lexer.Token;

import java.io.IOException;
import java.io.StringReader;

public class Main {

    public static void main(String[] args) {
        try {
            Lexer lexer = new Lexer(new StringReader("5.5"));
            Token<?> token;
            while ((token = lexer.yylex()) != null) {
                System.out.printf("%04X\n", token.getType());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
