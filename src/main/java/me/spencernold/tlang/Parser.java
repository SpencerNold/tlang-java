package me.spencernold.tlang;

import me.spencernold.tlang.compiler.Node;
import me.spencernold.tlang.lexer.Token;
import me.spencernold.tlang.lexer.TokenType;
import me.spencernold.tlang.parser.NodeType;
import me.spencernold.tlang.parser.TokenStream;

public class Parser {

    private final TokenStream stream;

    public Parser(Lexer lexer) {
        this.stream = TokenStream.wrap(lexer);
    }

    public void parse() {
        
    }

    private void parseFile() {
        Node<?> root = new Node<>(NodeType.NT_FILE);
        Token<?> token = stream.peek();
        if (token.getType() == TokenType.INCLUDE) {

        }
    }
}
