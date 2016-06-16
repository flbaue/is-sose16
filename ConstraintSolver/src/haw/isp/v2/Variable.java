package haw.isp.v2;

import java.util.EnumSet;

/**
 * Created by florian on 15.06.16.
 */
public class Variable<T extends Enum<T>> {
    public final EnumSet<T> domain;

    public Variable(EnumSet<T> domain) {
        this.domain = domain.clone();
    }


}
