package com.company;

import java.util.*;
import java.util.stream.Collectors;

public class Solver {


    public static void main(String[] args) {
        new Solver().run();
    }

    private void run() {
        Map<String, String> constraints = new HashMap<>();
        constraints.put("a", "b");
        constraints.put("b", "c");
        constraints.put("c", "d");

        List<String> values = new ArrayList<>();
        values.add("a");
        values.add("b");
        values.add("c");
        values.add("d");
        Collections.shuffle(values);

        List<String> solution = solve(new ArrayList<>(), values, constraints);

        System.out.println(solution);

    }

    private List<String> solve(List<String> solution, List<String> values, Map<String, String> constraints) {

        System.out.println("Solve: solution: " + solution + ", values: " + values + ", constraints: " + constraints);
        if (rejectSolution(solution, values, constraints)) {
            return Collections.EMPTY_LIST;
        } else if (acceptSolution(solution, constraints)) {
            return solution;
        }

        for (String v : values) {
            List<String> tmpValues = copyValueList(values);
            List<String> tmpSolution = copyValueList(solution);
            tmpValues.remove(v);
            tmpSolution.add(v);
            List<String> result = solve(tmpSolution, tmpValues, constraints);
            if (!result.isEmpty()) {
                return result;
            }
        }

        return Collections.EMPTY_LIST;
    }

    private boolean acceptSolution(List<String> solution, Map<String, String> constraints) {
        for (Map.Entry<String, String> e : constraints.entrySet()) {
            int i = solution.indexOf(e.getKey());
            if (i == -1 || solution.size() <= i + 1 || !solution.get(i + 1).equals(e.getValue())) {
                return false;
            }
        }
        return true;
    }

    private boolean rejectSolution(List<String> solution, List<String> values, Map<String, String> constraints) {

        if (solution.size() - values.size() > 0) {
            return false;
        }

        for (Map.Entry<String, String> e : constraints.entrySet()) {
            int i = solution.indexOf(e.getKey());
            if (i != -1 && solution.size() > i + 1 && !solution.get(i + 1).equals(e.getValue())) {
                return true;
            }
        }
        return false;
    }

    private List<String> copyValueList(List<String> values) {
        return values.stream().collect(Collectors.toList());
    }

}
