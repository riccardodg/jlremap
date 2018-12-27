/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.entities;

import java.io.Serializable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author riccardo
 */
@Entity
@Table(name = "lremap_resource_lang_dim")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LremapResourceLangDim.findAll", query = "SELECT l FROM LremapResourceLangDim l"),
    @NamedQuery(name = "LremapResourceLangDim.findByResourceid", query = "SELECT l FROM LremapResourceLangDim l WHERE l.lremapResourceLangDimPK.resourceid = :resourceid"),
    @NamedQuery(name = "LremapResourceLangDim.findByLangType", query = "SELECT l FROM LremapResourceLangDim l WHERE l.lremapResourceLangDimPK.langType = :langType")})
public class LremapResourceLangDim implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected LremapResourceLangDimPK lremapResourceLangDimPK;

    public LremapResourceLangDim() {
    }

    public LremapResourceLangDim(LremapResourceLangDimPK lremapResourceLangDimPK) {
        this.lremapResourceLangDimPK = lremapResourceLangDimPK;
    }

    public LremapResourceLangDim(String resourceid, String langType) {
        this.lremapResourceLangDimPK = new LremapResourceLangDimPK(resourceid, langType);
    }

    public LremapResourceLangDimPK getLremapResourceLangDimPK() {
        return lremapResourceLangDimPK;
    }

    public void setLremapResourceLangDimPK(LremapResourceLangDimPK lremapResourceLangDimPK) {
        this.lremapResourceLangDimPK = lremapResourceLangDimPK;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (lremapResourceLangDimPK != null ? lremapResourceLangDimPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapResourceLangDim)) {
            return false;
        }
        LremapResourceLangDim other = (LremapResourceLangDim) object;
        if ((this.lremapResourceLangDimPK == null && other.lremapResourceLangDimPK != null) || (this.lremapResourceLangDimPK != null && !this.lremapResourceLangDimPK.equals(other.lremapResourceLangDimPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapResourceLangDim[ lremapResourceLangDimPK=" + lremapResourceLangDimPK + " ]";
    }
    
}
