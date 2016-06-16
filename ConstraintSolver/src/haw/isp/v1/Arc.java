package haw.isp.v1;

import haw.isp.Constraint;

import java.util.Arrays;
import java.util.List;

/**
 * Created by florian on 15.06.16.
 */
public class Arc<X, Y> {
    public final Constraint<X, Y> constraint;
    List<Variable> vars;

    public Arc(Constraint<X, Y> constraint, Variable... vars) {
        this.vars = Arrays.asList(vars);
        this.constraint = constraint;
    }
}
