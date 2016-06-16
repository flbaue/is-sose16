package haw.isp.v1;

import haw.isp.Domains.*;

import java.util.EnumSet;

/**
 * Created by florian on 15.06.16.
 */
public class Variable {

    public final EnumSet<Farbe> domainFarbe;
    public final EnumSet<Nation> domainNation;
    public final EnumSet<Tier> domainTier;
    public final EnumSet<Getränk> domainGetränk;
    public final EnumSet<Marke> domainMarke;
    public final Position position;

    public String farbe;
    public String nation;
    public String tier;
    public String getränk;
    public String marke;

    public Variable(Position position, EnumSet<Farbe> domainFarbe, EnumSet<Nation> domainNation, EnumSet<Tier> domainTier,
                    EnumSet<Getränk> domainGetränk, EnumSet<Marke> domainMarke) {

        this.position = position;
        this.domainFarbe = domainFarbe.clone();
        this.domainNation = domainNation.clone();
        this.domainTier = domainTier.clone();
        this.domainGetränk = domainGetränk.clone();
        this.domainMarke = domainMarke.clone();
    }
}
