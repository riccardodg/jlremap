/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author riccardo
 */
@Entity
@Table(name = "lremap_authors")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LremapAuthors.findAll", query = "SELECT l FROM LremapAuthors l"),
    @NamedQuery(name = "LremapAuthors.findByResourceid", query = "SELECT l FROM LremapAuthors l WHERE l.lremapAuthorsPK.resourceid = :resourceid"),
    @NamedQuery(name = "LremapAuthors.findByAuthornumber", query = "SELECT l FROM LremapAuthors l WHERE l.lremapAuthorsPK.authornumber = :authornumber")})
public class LremapAuthors implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected LremapAuthorsPK lremapAuthorsPK;
    @Lob
    @Column(name = "username")
    private String username;
    @Lob
    @Column(name = "firstname")
    private String firstname;
    @Lob
    @Column(name = "lastname")
    private String lastname;
    @Lob
    @Column(name = "email")
    private String email;
    @Lob
    @Column(name = "affiliation")
    private String affiliation;
    @Lob
    @Column(name = "country")
    private String country;
    @JoinColumn(name = "resourceid", referencedColumnName = "resourceid", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private LremapPapers lremapPapers;

    public LremapAuthors() {
    }

    public LremapAuthors(LremapAuthorsPK lremapAuthorsPK) {
        this.lremapAuthorsPK = lremapAuthorsPK;
    }

    public LremapAuthors(String resourceid, String authornumber) {
        this.lremapAuthorsPK = new LremapAuthorsPK(resourceid, authornumber);
    }

    public LremapAuthorsPK getLremapAuthorsPK() {
        return lremapAuthorsPK;
    }

    public void setLremapAuthorsPK(LremapAuthorsPK lremapAuthorsPK) {
        this.lremapAuthorsPK = lremapAuthorsPK;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAffiliation() {
        return affiliation;
    }

    public void setAffiliation(String affiliation) {
        this.affiliation = affiliation;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public LremapPapers getLremapPapers() {
        return lremapPapers;
    }

    public void setLremapPapers(LremapPapers lremapPapers) {
        this.lremapPapers = lremapPapers;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (lremapAuthorsPK != null ? lremapAuthorsPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LremapAuthors)) {
            return false;
        }
        LremapAuthors other = (LremapAuthors) object;
        if ((this.lremapAuthorsPK == null && other.lremapAuthorsPK != null) || (this.lremapAuthorsPK != null && !this.lremapAuthorsPK.equals(other.lremapAuthorsPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "it.cnr.ilc.jlremap.entities.LremapAuthors[ lremapAuthorsPK=" + lremapAuthorsPK + " ]";
    }
    
}
