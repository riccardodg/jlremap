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
@Table(name = "lremap_resource_pivoted_lang")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LremapResourcePivotedLang.findAll", query = "SELECT l FROM LremapResourcePivotedLang l"),
    @NamedQuery(name = "LremapResourcePivotedLang.findByResourceid", query = "SELECT l FROM LremapResourcePivotedLang l WHERE l.lremapResourcePivotedLangPK.resourceid = :resourceid"),
    @NamedQuery(name = "LremapResourcePivotedLang.findByLanguage", query = "SELECT l FROM LremapResourcePivotedLang l WHERE l.lremapResourcePivotedLangPK.language = :language")})
public class LremapResourcePivotedLang implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected LremapResourcePivotedLangPK lremapResourcePivotedLangPK;

    public LremapResourcePivotedLang() {
    }

    public LremapResourcePivotedLang(LremapResourcePivotedLangPK lremapResourcePivotedLangPK) {
        this.lremapResourcePivotedLangPK = lremapResourcePivotedLangPK;
    }

    public LremapResourcePivotedLang(String resourceid, String language) {
        this.lremapResourcePivotedLangPK = new LremapResourcePivotedLangPK(resourceid, language);
    }

    public LremapResourcePivotedLangPK getLremapResourcePivotedLangPK() {
        return lremapResourcePivotedLangPK;
    }

    public void setLremapResourcePivotedLangPK(LremapResourcePivotedLangPK lremapResourcePivotedLangPK) {
        this.lremapResourcePivotedLangPK = lremapResourcePivotedLangPK;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (lremapResourcePivotedLangPK != null ? lremapResourcePivotedLangPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapResourcePivotedLang)) {
            return false;
        }
        LremapResourcePivotedLang other = (LremapResourcePivotedLang) object;
        if ((this.lremapResourcePivotedLangPK == null && other.lremapResourcePivotedLangPK != null) || (this.lremapResourcePivotedLangPK != null && !this.lremapResourcePivotedLangPK.equals(other.lremapResourcePivotedLangPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapResourcePivotedLang[ lremapResourcePivotedLangPK=" + lremapResourcePivotedLangPK + " ]";
    }
    
}
