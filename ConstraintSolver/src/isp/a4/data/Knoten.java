package isp.a4.data;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Created by florian on 04.06.2016.
 */
public class Knoten {
  private String name;
  private List<Integer> domain;
  private Set<Kante> ausgehendeKanten = new HashSet<>();
  private Set<Kante> eintreffendeKanten = new HashSet<>();

  public Knoten(String name, List<Integer> domain) {
    this.name = name;
    this.domain = domain;
  }

  public void addOutgoingEdge(Kante kante) {
    ausgehendeKanten.add(kante);
  }

  public void addIncomingEdge(Kante kante) {
    eintreffendeKanten.add(kante);
  }

  public String getName() {
    return name;
  }

  public List<Integer> getDomain() {
    return domain;
  }

  public void setDomain(List<Integer> domain) {
    this.domain = domain;
  }

  public Set<Kante> getAusgehendeKanten() {
    return ausgehendeKanten;
  }

  public Set<Kante> getEintreffendeKanten() {
    return eintreffendeKanten;
  }

  public Set<Knoten> getNachbarn() {
    Set<Knoten> nachbarn = ausgehendeKanten.stream().filter(k -> !k.getEnde().equals(this)).map(Kante::getEnde).collect(Collectors.toSet());
    nachbarn.addAll(eintreffendeKanten.stream().filter(k -> !k.getStart().equals(this)).map(Kante::getStart).collect(Collectors.toList()));
    return nachbarn;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;

    Knoten knoten = (Knoten) o;

    return name != null ? name.equals(knoten.name) : knoten.name == null;

  }

  @Override
  public int hashCode() {
    return name != null ? name.hashCode() : 0;
  }

  @Override
  public String toString() {
    final StringBuffer sb = new StringBuffer("Knoten{");
    sb.append("name='").append(name).append('\'');
    sb.append(", domain=").append(domain);
    sb.append('}');
    return sb.toString();
  }
}
