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
public class LremapResourceLangDimPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "resourceid")
    private String resourceid;
    @Basic(optional = false)
    @Column(name = "lang_type")
    private String langType;

    public LremapResourceLangDimPK() {
    }

    public LremapResourceLangDimPK(String resourceid, String langType) {
        this.resourceid = resourceid;
        this.langType = langType;
    }

    public String getResourceid() {
        return resourceid;
    }

    public void setResourceid(String resourceid) {
        this.resourceid = resourceid;
    }

    public String getLangType() {
        return langType;
    }

    public void setLangType(String langType) {
        this.langType = langType;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (resourceid != null ? resourceid.hashCode() : 0);
        hash += (langType != null ? langType.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapResourceLangDimPK)) {
            return false;
        }
        LremapResourceLangDimPK other = (LremapResourceLangDimPK) object;
        if ((this.resourceid == null && other.resourceid != null) || (this.resourceid != null && !this.resourceid.equals(other.resourceid))) {
            return false;
        }
        if ((this.langType == null && other.langType != null) || (this.langType != null && !this.langType.equals(other.langType))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapResourceLangDimPK[ resourceid=" + resourceid + ", langType=" + langType + " ]";
    }
    
}
