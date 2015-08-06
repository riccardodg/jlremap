/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.controllers.exceptions.NonexistentEntityException;
import it.cnr.ilc.jlremap.controllers.exceptions.PreexistingEntityException;
import it.cnr.ilc.jlremap.entities.LremapResourceOtherLangNorm;
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
public class LremapResourceOtherLangNormJpaController implements Serializable {

    public LremapResourceOtherLangNormJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(LremapResourceOtherLangNorm lremapResourceOtherLangNorm) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(lremapResourceOtherLangNorm);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findLremapResourceOtherLangNorm(lremapResourceOtherLangNorm.getResourceid()) != null) {
                throw new PreexistingEntityException("LremapResourceOtherLangNorm " + lremapResourceOtherLangNorm + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(LremapResourceOtherLangNorm lremapResourceOtherLangNorm) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            lremapResourceOtherLangNorm = em.merge(lremapResourceOtherLangNorm);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = lremapResourceOtherLangNorm.getResourceid();
                if (findLremapResourceOtherLangNorm(id) == null) {
                    throw new NonexistentEntityException("The lremapResourceOtherLangNorm with id " + id + " no longer exists.");
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
            LremapResourceOtherLangNorm lremapResourceOtherLangNorm;
            try {
                lremapResourceOtherLangNorm = em.getReference(LremapResourceOtherLangNorm.class, id);
                lremapResourceOtherLangNorm.getResourceid();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The lremapResourceOtherLangNorm with id " + id + " no longer exists.", enfe);
            }
            em.remove(lremapResourceOtherLangNorm);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<LremapResourceOtherLangNorm> findLremapResourceOtherLangNormEntities() {
        return findLremapResourceOtherLangNormEntities(true, -1, -1);
    }

    public List<LremapResourceOtherLangNorm> findLremapResourceOtherLangNormEntities(int maxResults, int firstResult) {
        return findLremapResourceOtherLangNormEntities(false, maxResults, firstResult);
    }

    private List<LremapResourceOtherLangNorm> findLremapResourceOtherLangNormEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(LremapResourceOtherLangNorm.class));
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

    public LremapResourceOtherLangNorm findLremapResourceOtherLangNorm(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(LremapResourceOtherLangNorm.class, id);
        } finally {
            em.close();
        }
    }

    public int getLremapResourceOtherLangNormCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<LremapResourceOtherLangNorm> rt = cq.from(LremapResourceOtherLangNorm.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
