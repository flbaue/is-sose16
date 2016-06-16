package haw.isp.v1;

import haw.isp.Constraint;
import haw.isp.Domains.*;
import haw.isp.Prädikat;

import java.util.ArrayList;
import java.util.EnumSet;
import java.util.List;

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
        EnumSet<Tier> tiere = EnumSet.allOf(Tier.class);
        EnumSet<Getränk> getränke = EnumSet.allOf(Getränk.class);
        EnumSet<Marke> marken = EnumSet.allOf(Marke.class);


        Variable v1 = new Variable(Position.P1, farben, nationen, tiere, getränke, marken);
        Variable v2 = new Variable(Position.P2, farben, nationen, tiere, getränke, marken);
        Variable v3 = new Variable(Position.P3, farben, nationen, tiere, getränke, marken);
        Variable v4 = new Variable(Position.P4, farben, nationen, tiere, getränke, marken);
        Variable v5 = new Variable(Position.P5, farben, nationen, tiere, getränke, marken);


        Constraint<Nation, Farbe> c1 = new Constraint<>(Prädikat.GLEICH, Nation.BRITISCH, Farbe.ROT);
        Constraint<Nation, Tier> c2 = new Constraint<>(Prädikat.GLEICH, Nation.SCHEDISCH, Tier.HUND);
        Constraint<Nation, Getränk> c3 = new Constraint<>(Prädikat.GLEICH, Nation.DÄNISCH, Getränk.TEE);
        Constraint<Farbe, Farbe> c4 = new Constraint<>(Prädikat.LINKS_VON, Farbe.WEIß, Farbe.GRÜN);
        Constraint<Farbe, Getränk> c5 = new Constraint<>(Prädikat.GLEICH, Farbe.GRÜN, Getränk.KAFFEE);
        Constraint<Marke, Tier> c6 = new Constraint<>(Prädikat.GLEICH, Marke.PALL_MALL, Tier.VOGEL);
        Constraint<Position, Getränk> c7 = new Constraint<>(Prädikat.GLEICH, Position.P3, Getränk.MILCH);
        Constraint<Farbe, Marke> c8 = new Constraint<>(Prädikat.GLEICH, Farbe.GELB, Marke.DUNHILL);
        Constraint<Nation, Position> c9 = new Constraint<>(Prädikat.GLEICH, Nation.NORWEGISCH, Position.P1);
        Constraint<Marke, Tier> c10 = new Constraint<>(Prädikat.NEBEN, Marke.MALBORO, Tier.KATZE);
        Constraint<Tier, Marke> c11 = new Constraint<>(Prädikat.NEBEN, Tier.PFERD, Marke.DUNHILL);
        Constraint<Marke, Getränk> c12 = new Constraint<>(Prädikat.GLEICH, Marke.WINFIELD, Getränk.BIER);
        Constraint<Nation, Farbe> c13 = new Constraint<>(Prädikat.NEBEN, Nation.NORWEGISCH, Farbe.BLAU);
        Constraint<Nation, Marke> c14 = new Constraint<>(Prädikat.GLEICH, Nation.DEUTSCH, Marke.ROTHMANNS);
        Constraint<Marke, Getränk> c15 = new Constraint<>(Prädikat.NEBEN, Marke.MALBORO, Getränk.WASSER);

        List<Arc> arcs = new ArrayList<>();
        //arcs.add(new Arc())


    }
}
