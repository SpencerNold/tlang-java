package me.spencernold.tlang.parser;

import me.spencernold.tlang.compiler.TLangCompileException;

import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class ParseException extends TLangCompileException {

    private final String message;
    private final int line;
    private final int index;

    public ParseException(String message, int line, int index) {
        this.message = message;
        this.line = line;
        this.index = index;
    }

    @Override
    public void print() {
        System.out.printf("%s on line %d in %s\n\n", message, line, context.getName());
        System.out.println(context.get(line));
        System.out.println(generateWhiteSpace(index) + "^");
        System.out.println();
    }

    private String generateWhiteSpace(int length) {
        byte[] bytes = new byte[length];
        Arrays.fill(bytes, (byte) ' ');
        return new String(bytes, StandardCharsets.UTF_8);
    }
}
