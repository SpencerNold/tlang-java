package me.spencernold.tlang.compiler;

import me.spencernold.tlang.FileContext;

public abstract class TLangCompileException extends RuntimeException {

    public static FileContext context;

    public abstract void print();
}
