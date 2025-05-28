package me.spencernold.tlang.compiler;

import java.util.ArrayList;
import java.util.List;

public class Node<T> {

    private final int type;
    private final T value;
    private final List<Node<?>> children = new ArrayList<>();

    public Node(int type, T value) {
        this.type = type;
        this.value = value;
    }

    public Node(int type) {
        this(type, null);
    }

    public void addChild(Node<?> node) {
        children.add(node);
    }

    public boolean isLeaf() {
        return children.isEmpty();
    }

    public T getValue() {
        return value;
    }

    public int getType() {
        return type;
    }
}
