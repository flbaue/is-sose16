package isp.a4;

import isp.a4.data.Constraint;
import isp.a4.data.Kante;
import isp.a4.data.Knoten;

import java.util.*;

/**
 * Created by florian on 04.06.2016.
 */
public class ConstraintSolver {
    public List<Knoten> knoten = new ArrayList<>();
    private Set<Kante> kanten = new HashSet<>();

    /**
     * Erstellt eine Variable und speichert sie in einer Liste
     * @param name der Variable
     * @param domain der Variable
     * @return die Variable
     */
    public Knoten addVariable(String name, List<Integer> domain) {
        Knoten k = new Knoten(name, domain);
        knoten.add(k);
        return k;
    }

    /**
     * Fügt einen gerichteten Constraint hinzu.
     * @param from Variable
     * @param to Varible
     * @param constraint
     */
    public void addUnaryConstraint(Knoten from, Knoten to, Constraint constraint) {
        kanten.add(new Kante(from, to, constraint));
    }

    /**
     * Fügt beidseitigen Constraint hinzu. Wird durch zwei gerichtete abgebildet.
     * @param a Variable
     * @param b Variable
     * @param constraint
     */
    public void addBiConstraint(Knoten a, Knoten b, Constraint constraint) {
        addUnaryConstraint(a, b, constraint);
        addUnaryConstraint(b, a, constraint);
    }

    /**
     * Fügt constraints hinzu, so dass alle gegebenen Variablen unterschiedlich sein müssen.
     * @param knoten Menge von Variablen
     */
    public void allDifferent(Collection<Knoten> knoten) {
        for (Knoten elem : knoten) {
            for (Knoten elem2 : knoten) {
                if (!elem.equals(elem2)) {
                    addBiConstraint(elem, elem2, Constraint.ungleich);
                }
            }
        }
    }

    /**
     * AC-3 mit Look a Head
     * @param cv Nummer der aktuell belegten Variable
     * @return konsistent oder nicht
     */
    public boolean ac3LA(int cv) {
        Queue<Kante> queue = findeKanten(cv);
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

    /**
     * Rekursive Methode welche jeweils die aktuelle Variable belegt und mit AC-3 LaH überprüft.
     * @param currentIndex der aktuellen Variable (aus der Liste)
     * @return false wenn es keine konsistente Lösung gibt. Sonst true, Lösung ist der aktuelle zustand der Variablen.
     */
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

    /**
     * Erstellt Kopien aller Domain-Listen der Variablen in einer Map
     * @param knoten Variablen
     * @return Map mit Domain-Kopien und Variablenreferenz
     */
    private Map<Knoten, List<Integer>> backupDomains(List<Knoten> knoten) {
        Map<Knoten, List<Integer>> domains = new HashMap<>();

        for (Knoten k : knoten) {
            List<Integer> domain = new ArrayList<>(k.getDomain());
            domains.put(k, domain);
        }

        return domains;
    }

    /**
     * Setzt die Domains der gegebenen Variablen wieder auf den gesicherten Zustand zurück.
     * @param domains
     */
    private void resetDomains(Map<Knoten, List<Integer>> domains) {
        for (Map.Entry<Knoten, List<Integer>> e : domains.entrySet()) {
            Knoten k = e.getKey();
            k.setDomain(new ArrayList<>(e.getValue()));
        }
    }

    /**
     * Findet alle Kanten die zur Variablen mit dem gegeben Index gehören
     * @param cv Index
     * @return Kanten
     */
    private Queue<Kante> findeKanten(int cv) {
        Queue<Kante> result = new LinkedList<>();
        for (Kante k : kanten) {
            if (knoten.indexOf(k.getStart()) > cv && knoten.indexOf(k.getEnde()) == cv) {
                result.add(k);
            }
        }
        return result;
    }

    /**
     * Prüft und reduziert die Variablen-Domain nach dem gegebenen Constraint
     * @param edge Constraint
     * @return Ob eine Reduzierung stattgefunden hat
     */
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

    /**
     * Prüft ob konkrete Domain-Werte möglich sind
     * @param edge Constraint
     * @param value Wert
     * @return
     */
    private boolean isValuePossible(Kante edge, Integer value) {
        for (Integer value2 : edge.getEnde().getDomain()) {
            if (ConstraintChecker.check(edge.getConstraint(), value, value2)) {
                return true;
            }
        }
        return false;
    }
}
