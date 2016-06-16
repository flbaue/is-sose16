package haw.isp;

import haw.isp.Prädikat;

/**
 * Created by florian on 15.06.16.
 */
public class Constraint<X,Y> {
    public final Prädikat prädikat;
    public final X w1;
    public final Y w2;

    public Constraint(Prädikat prädikat, X w1, Y w2) {
        this.prädikat = prädikat;
        this.w1 = w1;
        this.w2 = w2;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Constraint<?, ?> that = (Constraint<?, ?>) o;

        if (prädikat != that.prädikat) return false;
        if (w1 != null ? !w1.equals(that.w1) : that.w1 != null) return false;
        return w2 != null ? w2.equals(that.w2) : that.w2 == null;

    }

    @Override
    public int hashCode() {
        int result = prädikat != null ? prädikat.hashCode() : 0;
        result = 31 * result + (w1 != null ? w1.hashCode() : 0);
        result = 31 * result + (w2 != null ? w2.hashCode() : 0);
        return result;
    }
}
