/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author riccardo
 */
@Entity
@Table(name = "lremap_years")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LremapYears.findAll", query = "SELECT l FROM LremapYears l"),
    @NamedQuery(name = "LremapYears.findByYear", query = "SELECT l FROM LremapYears l WHERE l.year = :year")})
public class LremapYears implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "YEAR")
    private String year;

    public LremapYears() {
    }

    public LremapYears(String year) {
        this.year = year;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (year != null ? year.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapYears)) {
            return false;
        }
        LremapYears other = (LremapYears) object;
        if ((this.year == null && other.year != null) || (this.year != null && !this.year.equals(other.year))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapYears[ year=" + year + " ]";
    }
    
    /*
    public String toRdfClass() {
        String thisYear = getYear();

        String rdf = String.format("<owl:Class rdf:about=\"&year;#%s\">\n\t<rdfs:label>%s</rdfs:label>\n\t<rdfs:subClassOf rdf:resource=\"&year;#Year\"/>\n</owl:Class>", thisYear, thisYear);

        return rdf;
    }
*/
}
