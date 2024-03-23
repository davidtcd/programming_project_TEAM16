import java.util.*;

public class TreeMap {
    
    private int x, y;
    private int width, height;
    
    TreeMap() {
        List<Double> data = new ArrayList<>();
        data.add(Double.valueOf(5));
        data.add(Double.valueOf(10));
        data.add(Double.valueOf(11));
        data.add(Double.valueOf(20));
        
        
        TreeBuilder treebuilder = new TreeBuilder();
        Tree tree = treebuilder.buildTree(data); // first node of tree (top/root node)
    }
    
    public int getX() {
        return this.x;
    }
    
    public void setX(int x) {
        this.x = x;
    }
    
    public int getY() {
        return this.y;
    }
    
    public void setY(int y) {
        this.y = y;
    }
    
    public int getWidth() {
        return this.width;
    }
    
    public void setWidth(int width) {
        this.width = width;
    }
    
    public int getHeight() {
        return this.height;
    }
    
    public void setHeight(int height) {
        this.height = height;
    }
    
}


public static class Tree {
    double root;
    Tree left;
    Tree right;
    
    Tree(double root) {
        this.root = root;
        this.left = null;
        this.right = null;
    }
    
    Tree(double root, Tree left, Tree right) {
        this.root = root;
        this.left = left;
        this.right = right;
    }
    
}

public class TreeBuilder {
    
    public Tree buildTree(List<Double> data) {
        List<Tree> trees = new ArrayList<>();
        for (Double d : data) {
            trees.add(new Tree(d));
        }
        
        Collections.sort(trees, Comparator.comparingDouble(t -> t.root));
        Collections.reverse(trees);
        while(trees.size() > 1) {
            Tree tree1 = trees.remove(trees.size() - 1);
            Tree tree2 = trees.remove(trees.size() - 1);
            trees.add(new Tree(tree1.root + tree2.root, tree1, tree2));
            Collections.sort(trees, Comparator.comparingDouble(t -> t.root));
            Collections.reverse(trees);
        }
        return trees.get(0);
    }
    
    public void printTree(Tree root, String label) {
        if (root == null)
            return;
        printTree(root.left, "left");
        println(label + ": " +  root.root);
        printTree(root.right, "right");
    }
}
