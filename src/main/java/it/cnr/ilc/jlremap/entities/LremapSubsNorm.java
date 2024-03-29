/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author riccardo
 */
@Entity
@Table(name = "lremap_subs_norm")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LremapSubsNorm.findAll", query = "SELECT l FROM LremapSubsNorm l"),
    @NamedQuery(name = "LremapSubsNorm.findByResourceid", query = "SELECT l FROM LremapSubsNorm l WHERE l.resourceid = :resourceid"),
    @NamedQuery(name = "LremapSubsNorm.findByConf", query = "SELECT l FROM LremapSubsNorm l WHERE l.conf = :conf"),
    @NamedQuery(name = "LremapSubsNorm.findByYear", query = "SELECT l FROM LremapSubsNorm l WHERE l.year = :year"),
    @NamedQuery(name = "LremapSubsNorm.findByPasscode", query = "SELECT l FROM LremapSubsNorm l WHERE l.passcode = :passcode")})
public class LremapSubsNorm implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "resourceid")
    private String resourceid;
    @Basic(optional = false)
    @Column(name = "CONF")
    private String conf;
    @Basic(optional = false)
    @Column(name = "YEAR")
    private String year;
    @Basic(optional = false)
    @Column(name = "passcode")
    private String passcode;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "resourceNormid")
    private LremapResourceKeys lremapResourceKeys;

    public LremapSubsNorm() {
    }

    public LremapSubsNorm(String resourceid) {
        this.resourceid = resourceid;
    }

    public LremapSubsNorm(String resourceid, String conf, String year, String passcode) {
        this.resourceid = resourceid;
        this.conf = conf;
        this.year = year;
        this.passcode = passcode;
    }

    public String getResourceid() {
        return resourceid;
    }

    public void setResourceid(String resourceid) {
        this.resourceid = resourceid;
    }

    public String getConf() {
        return conf;
    }

    public void setConf(String conf) {
        this.conf = conf;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getPasscode() {
        return passcode;
    }

    public void setPasscode(String passcode) {
        this.passcode = passcode;
    }

    public LremapResourceKeys getLremapResourceKeys() {
        return lremapResourceKeys;
    }

    public void setLremapResourceKeys(LremapResourceKeys lremapResourceKeys) {
        this.lremapResourceKeys = lremapResourceKeys;
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
        if (!(object instanceof LremapSubsNorm)) {
            return false;
        }
        LremapSubsNorm other = (LremapSubsNorm) object;
        if ((this.resourceid == null && other.resourceid != null) || (this.resourceid != null && !this.resourceid.equals(other.resourceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapSubsNorm[ resourceid=" + resourceid + " ]";
    }
    
}
