package me.spencernold.tlang;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

public class FileContext {

    private final List<String> lines;
    private final String name;

    public FileContext(File file) throws IOException {
        this.lines = Files.readAllLines(file.toPath());
        this.name = file.getName();
    }

    public String get(int index) {
        if (index == -1)
            return get(getLength());
        return lines.get(index - 1);
    }

    public List<String> getLines() {
        return lines;
    }

    public int getLength() {
        return lines.size();
    }

    public String getName() {
        return name;
    }
}
