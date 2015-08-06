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
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author riccardo
 */
@Entity
@Table(name = "lremap_resource_other_lang")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LremapResourceOtherLang.findAll", query = "SELECT l FROM LremapResourceOtherLang l"),
    @NamedQuery(name = "LremapResourceOtherLang.findByResourceid", query = "SELECT l FROM LremapResourceOtherLang l WHERE l.resourceid = :resourceid")})
public class LremapResourceOtherLang implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "resourceid")
    private String resourceid;
    @Lob
    @Column(name = "language")
    private String language;

    public LremapResourceOtherLang() {
    }

    public LremapResourceOtherLang(String resourceid) {
        this.resourceid = resourceid;
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
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapResourceOtherLang)) {
            return false;
        }
        LremapResourceOtherLang other = (LremapResourceOtherLang) object;
        if ((this.resourceid == null && other.resourceid != null) || (this.resourceid != null && !this.resourceid.equals(other.resourceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapResourceOtherLang[ resourceid=" + resourceid + " ]";
    }
    
}
