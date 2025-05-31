package me.spencernold.tlang;

import me.spencernold.tlang.compiler.Node;
import me.spencernold.tlang.lexer.Token;
import me.spencernold.tlang.lexer.TokenType;
import me.spencernold.tlang.parser.NodeType;
import me.spencernold.tlang.parser.ParseException;
import me.spencernold.tlang.parser.TokenStream;

import java.io.IOException;

public class Parser {

    private final TokenStream stream;

    public Parser(Lexer lexer) throws IOException {
        this.stream = new TokenStream(lexer);
    }


    public Node<?> parse() throws IOException {
        return parseFile();
    }

    // First(FILE) = { include, First(DECLARATION), class }
    // Follow(FILE) = { $ }
    private Node<?> parseFile() throws IOException {
        Node<?> root = new Node<>(NodeType.NT_FILE);
        Token<?> token = stream.peek();
        if (token == null)
            return root;
        int type = token.getType();
        // First(FILE -> INCLUDE) = { include }
        if (type == TokenType.INCLUDE) {
            Node<?> include = parseInclude();
            root.addChild(include);
        // First(FILE -> DECLARATION) = { *ACCESS*, *TYPE_MASK*, IDENTIFIER }
        } else if (type == TokenType.PRIVATE
                || type == TokenType.PROTECTED
                || type == TokenType.IDENTIFIER
                || TokenType.isType(TokenType.TYPE_MASK, type)) {
            Node<?> declaration = parseDeclaration();
            root.addChild(declaration);
        // First(FILE -> CLASS) = { class }
        } else if (type == TokenType.CLASS) {

        }
        return root;
    }

    // First(INCLUDE) -> { include }
    private Node<?> parseInclude() throws IOException {
        Node<?> root = new Node<>(NodeType.NT_INCLUDE);
        Token<?> include = checkNextToken(TokenType.INCLUDE);
        root.addChild(new Node<>(include.getType()));
        Token<?> path = checkNextToken(TokenType.STRING_LIT);
        root.addChild(new Node<>(path.getType(), path.getValue()));
        return root;
    }

    private Node<?> parseDeclaration() throws IOException {
        Node<?> root = new Node<>(NodeType.NT_DECLARATION);
        Token<?> token = stream.peek();
        if (token == null)
            throw new ParseException("Premature EOF", -1, 0);
        int type = token.getType();
        if (type == TokenType.PROTECTED || type == TokenType.PRIVATE) {
            Node<?> node = parseAccess();
            root.addChild(node);
        }
        return root;
    }

    private Node<?> parseAccess() throws IOException {
        Node<?> root = new Node<>(NodeType.NT_ACCESS);
        Token<?> token = stream.peek();
        if (token.getType() == TokenType.PRIVATE || token.getType() == TokenType.PROTECTED) {
            Token<?> access = stream.next();
            root.addChild(new Node<>(access.getType()));
        } else if (token.getType() != TokenType.IDENTIFIER && !TokenType.isType(TokenType.TYPE_MASK, token.getType())) {
            // throw new ParseException("Syntax Error", token.getLine());
        }
        return root;
    }

    private Token<?> checkNextToken(int... types) throws IOException {
        Token<?> token = stream.next();
        if (token == null)
            throw new ParseException("Premature EOF", -1, 0);
        boolean in = false;
        for (int type : types) {
            if (type == token.getType()) {
                in = true;
                break;
            }
        }
        if (!in)
            throw new ParseException("Syntax Error", token.getLine(), token.getIndex());
        return token;
    }
}
