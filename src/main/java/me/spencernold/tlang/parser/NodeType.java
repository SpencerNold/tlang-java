package me.spencernold.tlang.parser;

public class NodeType {

    public static final int NON_TERMINAL_MASK = 0xFFFFFFFF;
    public static final int ROOT = 0xFFFFFFF0;
    public static final int NT_FILE = 0xFFFFFFF1;
    public static final int NT_INCLUDE = 0xFFFFFFF2;
    public static final int NT_DECLARATION = 0xFFFFFFF3;
    public static final int NT_ACCESS = 0xFFFFFFF4;
}
