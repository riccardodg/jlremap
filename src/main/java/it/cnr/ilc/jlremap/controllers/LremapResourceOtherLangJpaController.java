/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.controllers.exceptions.NonexistentEntityException;
import it.cnr.ilc.jlremap.controllers.exceptions.PreexistingEntityException;
import it.cnr.ilc.jlremap.entities.LremapResourceOtherLang;
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
public class LremapResourceOtherLangJpaController implements Serializable {

    public LremapResourceOtherLangJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(LremapResourceOtherLang lremapResourceOtherLang) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(lremapResourceOtherLang);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findLremapResourceOtherLang(lremapResourceOtherLang.getResourceid()) != null) {
                throw new PreexistingEntityException("LremapResourceOtherLang " + lremapResourceOtherLang + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(LremapResourceOtherLang lremapResourceOtherLang) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            lremapResourceOtherLang = em.merge(lremapResourceOtherLang);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = lremapResourceOtherLang.getResourceid();
                if (findLremapResourceOtherLang(id) == null) {
                    throw new NonexistentEntityException("The lremapResourceOtherLang with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(String id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            LremapResourceOtherLang lremapResourceOtherLang;
            try {
                lremapResourceOtherLang = em.getReference(LremapResourceOtherLang.class, id);
                lremapResourceOtherLang.getResourceid();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The lremapResourceOtherLang with id " + id + " no longer exists.", enfe);
            }
            em.remove(lremapResourceOtherLang);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<LremapResourceOtherLang> findLremapResourceOtherLangEntities() {
        return findLremapResourceOtherLangEntities(true, -1, -1);
    }

    public List<LremapResourceOtherLang> findLremapResourceOtherLangEntities(int maxResults, int firstResult) {
        return findLremapResourceOtherLangEntities(false, maxResults, firstResult);
    }

    private List<LremapResourceOtherLang> findLremapResourceOtherLangEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(LremapResourceOtherLang.class));
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

    public LremapResourceOtherLang findLremapResourceOtherLang(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(LremapResourceOtherLang.class, id);
        } finally {
            em.close();
        }
    }

    public int getLremapResourceOtherLangCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<LremapResourceOtherLang> rt = cq.from(LremapResourceOtherLang.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
