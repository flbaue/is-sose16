package haw.isp.v2;

import haw.isp.Constraint;
import haw.isp.Domains.*;
import haw.isp.Prädikat;

import java.util.*;

/**
 * Created by florian on 15.06.16.
 */
public class AC3LookAhead {
    public static void main(String[] args) {
        new AC3LookAhead().run();
    }

    private void run() {

        EnumSet<Farbe> farben = EnumSet.allOf(Farbe.class);
        EnumSet<Nation> nationen = EnumSet.allOf(Nation.class);
        EnumSet<Tier> tiere = EnumSet.of(Tier.FISCH);
        EnumSet<Getränk> getränke = EnumSet.allOf(Getränk.class);
        EnumSet<Marke> marken = EnumSet.allOf(Marke.class);
        EnumSet<Position> positionen = EnumSet.allOf(Position.class);

        Variable<Farbe> vFarbe = new Variable<>(farben);
        Variable<Nation> vNation = new Variable<>(nationen);
        Variable<Tier> vTier = new Variable<>(tiere);
        Variable<Getränk> vGetränk = new Variable<>(getränke);
        Variable<Marke> vMarke = new Variable<>(marken);
        Variable<Position> vPosition = new Variable<>(positionen);


        Constraint<Tier, Marke> c6 = new Constraint<>(Prädikat.GLEICH, Tier.VOGEL, Marke.PALL_MALL);


        Set<Arc> arcs = new HashSet<>();
        arcs.add(new Arc(c6, vTier, vMarke));

        Deque<Arc> q = new LinkedList<>();
        //q.push(arc);

        while (!q.isEmpty()) {
            Arc a = q.pop();
            if (revise(a)) {

            }
        }

    }

    private boolean revise(Arc a) {
        return false;
    }
}
