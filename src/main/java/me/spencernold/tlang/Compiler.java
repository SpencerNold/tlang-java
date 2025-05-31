package me.spencernold.tlang;

import me.spencernold.tlang.compiler.TLangCompileException;

import java.io.*;

public class Compiler {

    public void compile(File file) throws IOException {
        if (!file.exists()) {
            return;
        }
        TLangCompileException.context = new FileContext(file);
        FileReader reader = new FileReader(file);
        compile(new BufferedReader(reader));
        reader.close();
    }

    private void compile(Reader reader) throws IOException {
        try {
            Lexer lexer = new Lexer(reader);
            Parser parser = new Parser(lexer);
            parser.parse();
        } catch (TLangCompileException e) {
            e.print();
            System.exit(1);
        }
    }
}
