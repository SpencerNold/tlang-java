package me.spencernold.tlang.lexer;

public class Token<T> {

    private final int type;
    private final T value;

    private final int line;
    private final int index;

    public Token(int type, T value, int line, int index) {
        this.type = type;
        this.value = value;
        this.line = line;
        this.index = index;
    }

    public int getType() {
        return type;
    }

    public T getValue() {
        return value;
    }

    public int getLine() {
        return line;
    }

    public int getIndex() {
        return index;
    }
}
