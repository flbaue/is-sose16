package haw.isp.v2;

import haw.isp.Constraint;

/**
 * Created by florian on 15.06.16.
 */
public class Arc {
    public final Constraint constraint;
    public final Variable v1;
    public final Variable v2;

    public Arc(Constraint constraint, Variable v1, Variable v2) {
        this.constraint = constraint;
        this.v1 = v1;
        this.v2 = v2;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Arc arc = (Arc) o;

        if (constraint != null ? !constraint.equals(arc.constraint) : arc.constraint != null) return false;
        if (v1 != null ? !v1.equals(arc.v1) : arc.v1 != null) return false;
        return v2 != null ? v2.equals(arc.v2) : arc.v2 == null;

    }

    @Override
    public int hashCode() {
        int result = constraint != null ? constraint.hashCode() : 0;
        result = 31 * result + (v1 != null ? v1.hashCode() : 0);
        result = 31 * result + (v2 != null ? v2.hashCode() : 0);
        return result;
    }
}
