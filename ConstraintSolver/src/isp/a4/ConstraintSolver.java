package isp.a4;

import isp.a4.data.Constraint;
import isp.a4.data.Kante;
import isp.a4.data.Knoten;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by florian on 04.06.2016.
 */
public class ConstraintSolver {
    public List<Knoten> knoten = new ArrayList<>();
    private Set<Kante> kanten = new HashSet<>();

    public Knoten addVariable(String name, List<Integer> dom) {
        Knoten k = new Knoten(name, dom);
        knoten.add(k);
        return k;
    }

    public void addUnaryConstraint(Knoten from, Knoten to, Constraint constraint) {
        kanten.add(new Kante(from, to, constraint));
    }

    public void addBiConstraint(Knoten a, Knoten b, Constraint constraint) {
        addUnaryConstraint(a, b, constraint);
        addUnaryConstraint(b, a, constraint);
    }

    public void allDifferent(Collection<Knoten> knoten) {
        for (Knoten elem : knoten) {
            for (Knoten elem2 : knoten) {
                if (!elem.equals(elem2)) {
                    addBiConstraint(elem, elem2, Constraint.ungleich);
                }
            }
        }
    }

    public boolean ac3LA(int cv) {
        Queue<Kante> queue = addKorrekteKanten(cv);
        boolean consistent = true;
        while (!queue.isEmpty() && consistent) {
            Kante delete = queue.poll();

            if (revise(delete)) {
                for (Kante k : delete.getStart().getEintreffendeKanten()) {
                    if ((knoten.indexOf(k.getStart()) != knoten.indexOf(k.getEnde())) && (knoten.indexOf(k.getStart()) != knoten.indexOf(delete.getEnde())) && (knoten.indexOf(k.getStart()) > cv)) {
                        queue.add(k);
                    }

                }
                consistent = !delete.getStart().getDomain().isEmpty();
            }
        }
        return consistent;
    }

    public boolean solve(int currentIndex) {
        if (knoten.get(currentIndex).getDomain().isEmpty()) {
            return false;
        }

        // Backup
        Set<Kante> backupKanten = new HashSet<>(kanten);
        Map<Knoten, List<Integer>> backupDomains = backupDomains(knoten);
        List<Integer> backupDomain = new ArrayList<>(knoten.get(currentIndex).getDomain());

        for (int bv : knoten.get(currentIndex).getDomain()) {
            List<Integer> nd = new ArrayList<>();
            nd.add(bv);

            knoten.get(currentIndex).setDomain(nd);
            if (ac3LA(currentIndex)) {
                if (currentIndex == knoten.size() - 1) return true;
                if (solve(currentIndex + 1)) {
                    return true;
                } else {
                    kanten = backupKanten;
                    resetDomains(backupDomains);
                    knoten.get(currentIndex).setDomain(backupDomain);
                }

            } else {
                kanten = backupKanten;
                resetDomains(backupDomains);
                knoten.get(currentIndex).setDomain(backupDomain);
            }
        }
        return false;
    }

    private Map<Knoten, List<Integer>> backupDomains(List<Knoten> knoten) {
        Map<Knoten, List<Integer>> domains = new HashMap<>();

        for (Knoten k : knoten) {
            List<Integer> domain = new ArrayList<>(k.getDomain());
            domains.put(k, domain);
        }

        return domains;
    }

    private void resetDomains(Map<Knoten, List<Integer>> domains) {
        for (Map.Entry<Knoten, List<Integer>> e : domains.entrySet()) {
            Knoten k = e.getKey();
            k.setDomain(new ArrayList<>(e.getValue()));
        }
    }

    public void checkUnary() {
        final List<Kante> unaryConstraints = kanten.stream().filter(edge -> {
            return edge.getStart().equals(edge.getEnde());
        }).collect(Collectors.toCollection(ArrayList::new));

        for (Kante k : unaryConstraints) {
            List<Integer> dom = k.getStart().getDomain();
            List<Integer> result = new ArrayList<>();
            for (Integer i : dom) {
                if (ConstraintChecker.check(k.getConstraint(), i, i)) result.add(i);
            }
            k.getStart().setDomain(result);
        }
    }

    private Queue<Kante> addKorrekteKanten(int cv) {
        Queue<Kante> result = new LinkedList<>();
        for (Kante k : kanten) {
            if (knoten.indexOf(k.getStart()) > cv && knoten.indexOf(k.getEnde()) == cv) {
                result.add(k);
            }
        }
        return result;
    }

    private boolean revise(Kante edge) {
        boolean action = false;
        // To avoid Concurrent Modification Error:
        List<Integer> list = new ArrayList<>(edge.getStart().getDomain());
        for (Integer value : list) {
            if (!isValuePossible(edge, value)) {
                action = true;
                edge.getStart().getDomain().remove(value);
            }
        }
        return action;
    }

    private boolean isValuePossible(Kante edge, Integer value) {
        for (Integer value2 : edge.getEnde().getDomain()) {
            if (ConstraintChecker.check(edge.getConstraint(), value, value2)) {
                return true;
            }
        }
        return false;
    }
}
