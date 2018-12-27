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
 * @author riccardo
 */
@Embeddable
public class LremapResourcePivotedLangNormPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "resourceid")
    private String resourceid;
    @Basic(optional = false)
    @Column(name = "language")
    private String language;

    public LremapResourcePivotedLangNormPK() {
    }

    public LremapResourcePivotedLangNormPK(String resourceid, String language) {
        this.resourceid = resourceid;
        this.language = language;
    }

    public String getResourceid() {
        return resourceid;
    }

    public void setResourceid(String resourceid) {
        this.resourceid = resourceid;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (resourceid != null ? resourceid.hashCode() : 0);
        hash += (language != null ? language.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapResourcePivotedLangNormPK)) {
            return false;
        }
        LremapResourcePivotedLangNormPK other = (LremapResourcePivotedLangNormPK) object;
        if ((this.resourceid == null && other.resourceid != null) || (this.resourceid != null && !this.resourceid.equals(other.resourceid))) {
            return false;
        }
        if ((this.language == null && other.language != null) || (this.language != null && !this.language.equals(other.language))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapResourcePivotedLangNormPK[ resourceid=" + resourceid + ", language=" + language + " ]";
    }
    
}
