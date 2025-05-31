package me.spencernold.tlang;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class Main {

    public static void main(String[] args) {
        try {
            File file = new File("stdtl/test.tl");
            Compiler compiler = new Compiler();
            compiler.compile(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
