/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package it.cnr.ilc.jlremap.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 *
 * @author Riccardo Del Gratta
 * @mail riccardo.delgratta@{gmail.com|ilc.cnr.it}
 */
@Embeddable
public class LremapSideTableResmetadataPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "attribute")
    private String attribute;
    @Basic(optional = false)
    @Column(name = "value")
    private String value;

    public LremapSideTableResmetadataPK() {
    }

    public LremapSideTableResmetadataPK(String attribute, String value) {
        this.attribute = attribute;
        this.value = value;
    }

    public String getAttribute() {
        return attribute;
    }

    public void setAttribute(String attribute) {
        this.attribute = attribute;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (attribute != null ? attribute.hashCode() : 0);
        hash += (value != null ? value.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapSideTableResmetadataPK)) {
            return false;
        }
        LremapSideTableResmetadataPK other = (LremapSideTableResmetadataPK) object;
        if ((this.attribute == null && other.attribute != null) || (this.attribute != null && !this.attribute.equals(other.attribute))) {
            return false;
        }
        if ((this.value == null && other.value != null) || (this.value != null && !this.value.equals(other.value))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapSideTableResmetadataPK[ attribute=" + attribute + ", value=" + value + " ]";
    }

}
