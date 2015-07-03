/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
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
@Table(name = "lremap_conferences")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LremapConferences.findAll", query = "SELECT l FROM LremapConferences l"),
    @NamedQuery(name = "LremapConferences.findByConf", query = "SELECT l FROM LremapConferences l WHERE l.lremapConferencesPK.conf = :conf"),
    @NamedQuery(name = "LremapConferences.findByYear", query = "SELECT l FROM LremapConferences l WHERE l.lremapConferencesPK.year = :year"),
    @NamedQuery(name = "LremapConferences.findByType", query = "SELECT l FROM LremapConferences l WHERE l.type = :type"),
    @NamedQuery(name = "LremapConferences.findBySubEVentOf", query = "SELECT l FROM LremapConferences l WHERE l.subEVentOf = :subEVentOf"),
    @NamedQuery(name = "LremapConferences.findByLocation", query = "SELECT l FROM LremapConferences l WHERE l.location = :location")})
public class LremapConferences implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected LremapConferencesPK lremapConferencesPK;
    @Basic(optional = false)
    @Column(name = "TYPE")
    private String type;
    @Basic(optional = false)
    @Column(name = "subEVentOf")
    private String subEVentOf;
    @Basic(optional = false)
    @Column(name = "location")
    private String location;

    public LremapConferences() {
    }

    public LremapConferences(LremapConferencesPK lremapConferencesPK) {
        this.lremapConferencesPK = lremapConferencesPK;
    }

    public LremapConferences(LremapConferencesPK lremapConferencesPK, String type, String subEVentOf, String location) {
        this.lremapConferencesPK = lremapConferencesPK;
        this.type = type;
        this.subEVentOf = subEVentOf;
        this.location = location;
    }

    public LremapConferences(String conf, String year) {
        this.lremapConferencesPK = new LremapConferencesPK(conf, year);
    }

    public LremapConferencesPK getLremapConferencesPK() {
        return lremapConferencesPK;
    }

    public void setLremapConferencesPK(LremapConferencesPK lremapConferencesPK) {
        this.lremapConferencesPK = lremapConferencesPK;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSubEVentOf() {
        return subEVentOf;
    }

    public void setSubEVentOf(String subEVentOf) {
        this.subEVentOf = subEVentOf;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (lremapConferencesPK != null ? lremapConferencesPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapConferences)) {
            return false;
        }
        LremapConferences other = (LremapConferences) object;
        if ((this.lremapConferencesPK == null && other.lremapConferencesPK != null) || (this.lremapConferencesPK != null && !this.lremapConferencesPK.equals(other.lremapConferencesPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapConferences[ lremapConferencesPK=" + lremapConferencesPK + " ]";
    }
    
}
