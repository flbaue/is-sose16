package isp.a4;


import isp.a4.data.Constraint;

/**
 * Created by florian on 04.06.2016.
 */
public class ConstraintChecker {
    public static boolean check(Constraint constraint, int value1, int value2) {

        switch (constraint) {
            case gleich:
                return value1 == value2;

            case ungleich:
                return (value1 != value2);

            case linksvon:
                return value1 == value2 - 1;

            case rechtsvon:
                return value1 == value2 + 1;

            case neben:
                return (Math.abs(value1 - value2) == 1);

//            case mittleresHaus:
//                return value1 == 2;
//
//            case erstesHaus:
//                return value1 == 0;

            default:
                throw new RuntimeException("WRONG CHECK " + constraint);
        }
    }
}
