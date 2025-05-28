package me.spencernold.tlang;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class Main {

    public static void main(String[] args) {
        try {
            File file = new File("stdtl/stdio.tl");
            FileReader reader = new FileReader(file);
            Compiler compiler = new Compiler();

            compiler.compile(new BufferedReader(reader));

            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
