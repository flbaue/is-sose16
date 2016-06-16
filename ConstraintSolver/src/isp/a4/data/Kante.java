package isp.a4.data;


/**
 * Created by florian on 04.06.2016.
 */
public class Kante {
  private Knoten start;
  private Knoten ende;
  private Constraint constraint;

  public Kante(Knoten start, Knoten ende, Constraint constraint) {
    this.start = start;
    this.ende = ende;
    this.constraint = constraint;

    start.addOutgoingEdge(this);
    ende.addIncomingEdge(this);
  }

  public Knoten getStart() {
    return start;
  }

  public Knoten getEnde() {
    return ende;
  }

  public Constraint getConstraint() {
    return constraint;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;

    Kante kante = (Kante) o;

    if (start != null ? !start.equals(kante.start) : kante.start != null) return false;
    if (ende != null ? !ende.equals(kante.ende) : kante.ende != null) return false;
    return constraint == kante.constraint;

  }

  @Override
  public int hashCode() {
    int result = start != null ? start.hashCode() : 0;
    result = 31 * result + (ende != null ? ende.hashCode() : 0);
    result = 31 * result + (constraint != null ? constraint.hashCode() : 0);
    return result;
  }
}
