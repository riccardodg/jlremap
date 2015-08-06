/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.controllers.exceptions.NonexistentEntityException;
import it.cnr.ilc.jlremap.controllers.exceptions.PreexistingEntityException;
import it.cnr.ilc.jlremap.entities.LremapResourcePivotedLang;
import it.cnr.ilc.jlremap.entities.LremapResourcePivotedLangPK;
import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

/**
 *
 * @author riccardo
 */
public class LremapResourcePivotedLangJpaController implements Serializable {

    public LremapResourcePivotedLangJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(LremapResourcePivotedLang lremapResourcePivotedLang) throws PreexistingEntityException, Exception {
        if (lremapResourcePivotedLang.getLremapResourcePivotedLangPK() == null) {
            lremapResourcePivotedLang.setLremapResourcePivotedLangPK(new LremapResourcePivotedLangPK());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(lremapResourcePivotedLang);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findLremapResourcePivotedLang(lremapResourcePivotedLang.getLremapResourcePivotedLangPK()) != null) {
                throw new PreexistingEntityException("LremapResourcePivotedLang " + lremapResourcePivotedLang + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(LremapResourcePivotedLang lremapResourcePivotedLang) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            lremapResourcePivotedLang = em.merge(lremapResourcePivotedLang);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                LremapResourcePivotedLangPK id = lremapResourcePivotedLang.getLremapResourcePivotedLangPK();
                if (findLremapResourcePivotedLang(id) == null) {
                    throw new NonexistentEntityException("The lremapResourcePivotedLang with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(LremapResourcePivotedLangPK id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            LremapResourcePivotedLang lremapResourcePivotedLang;
            try {
                lremapResourcePivotedLang = em.getReference(LremapResourcePivotedLang.class, id);
                lremapResourcePivotedLang.getLremapResourcePivotedLangPK();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The lremapResourcePivotedLang with id " + id + " no longer exists.", enfe);
            }
            em.remove(lremapResourcePivotedLang);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<LremapResourcePivotedLang> findLremapResourcePivotedLangEntities() {
        return findLremapResourcePivotedLangEntities(true, -1, -1);
    }

    public List<LremapResourcePivotedLang> findLremapResourcePivotedLangEntities(int maxResults, int firstResult) {
        return findLremapResourcePivotedLangEntities(false, maxResults, firstResult);
    }

    private List<LremapResourcePivotedLang> findLremapResourcePivotedLangEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(LremapResourcePivotedLang.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public LremapResourcePivotedLang findLremapResourcePivotedLang(LremapResourcePivotedLangPK id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(LremapResourcePivotedLang.class, id);
        } finally {
            em.close();
        }
    }

    public int getLremapResourcePivotedLangCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<LremapResourcePivotedLang> rt = cq.from(LremapResourcePivotedLang.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
