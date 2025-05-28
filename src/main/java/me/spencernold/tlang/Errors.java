package me.spencernold.tlang;

public class Errors {

    public static void print(String type, int line, String text) {
        System.out.printf("%s on line %d: \"%s\"\n", type, line, text);
        System.exit(1);
    }

    public static void print(Throwable throwable) {
        System.out.println("Internal exception: " + throwable.getMessage());
        System.exit(1);
    }
}
