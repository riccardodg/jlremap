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
public class LremapConferencesPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "CONF")
    private String conf;
    @Basic(optional = false)
    @Column(name = "YEAR")
    private String year;

    public LremapConferencesPK() {
    }

    public LremapConferencesPK(String conf, String year) {
        this.conf = conf;
        this.year = year;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (conf != null ? conf.hashCode() : 0);
        hash += (year != null ? year.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapConferencesPK)) {
            return false;
        }
        LremapConferencesPK other = (LremapConferencesPK) object;
        if ((this.conf == null && other.conf != null) || (this.conf != null && !this.conf.equals(other.conf))) {
            return false;
        }
        if ((this.year == null && other.year != null) || (this.year != null && !this.year.equals(other.year))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapConferencesPK[ conf=" + conf + ", year=" + year + " ]";
    }
    
}
