package me.spencernold.tlang.lexer;

public class Token<T> {

    private final int type;
    private final T value;

    public Token(int type, T value) {
        this.type = type;
        this.value = value;
    }

    public Token(int type) {
        this(type, null);
    }

    public int getType() {
        return type;
    }

    public T getValue() {
        return value;
    }
}
