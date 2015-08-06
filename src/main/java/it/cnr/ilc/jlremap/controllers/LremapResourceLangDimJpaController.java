/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.controllers.exceptions.NonexistentEntityException;
import it.cnr.ilc.jlremap.controllers.exceptions.PreexistingEntityException;
import it.cnr.ilc.jlremap.entities.LremapResourceLangDim;
import it.cnr.ilc.jlremap.entities.LremapResourceLangDimPK;
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
public class LremapResourceLangDimJpaController implements Serializable {

    public LremapResourceLangDimJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(LremapResourceLangDim lremapResourceLangDim) throws PreexistingEntityException, Exception {
        if (lremapResourceLangDim.getLremapResourceLangDimPK() == null) {
            lremapResourceLangDim.setLremapResourceLangDimPK(new LremapResourceLangDimPK());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(lremapResourceLangDim);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findLremapResourceLangDim(lremapResourceLangDim.getLremapResourceLangDimPK()) != null) {
                throw new PreexistingEntityException("LremapResourceLangDim " + lremapResourceLangDim + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(LremapResourceLangDim lremapResourceLangDim) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            lremapResourceLangDim = em.merge(lremapResourceLangDim);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                LremapResourceLangDimPK id = lremapResourceLangDim.getLremapResourceLangDimPK();
                if (findLremapResourceLangDim(id) == null) {
                    throw new NonexistentEntityException("The lremapResourceLangDim with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(LremapResourceLangDimPK id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            LremapResourceLangDim lremapResourceLangDim;
            try {
                lremapResourceLangDim = em.getReference(LremapResourceLangDim.class, id);
                lremapResourceLangDim.getLremapResourceLangDimPK();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The lremapResourceLangDim with id " + id + " no longer exists.", enfe);
            }
            em.remove(lremapResourceLangDim);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<LremapResourceLangDim> findLremapResourceLangDimEntities() {
        return findLremapResourceLangDimEntities(true, -1, -1);
    }

    public List<LremapResourceLangDim> findLremapResourceLangDimEntities(int maxResults, int firstResult) {
        return findLremapResourceLangDimEntities(false, maxResults, firstResult);
    }

    private List<LremapResourceLangDim> findLremapResourceLangDimEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(LremapResourceLangDim.class));
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

    public LremapResourceLangDim findLremapResourceLangDim(LremapResourceLangDimPK id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(LremapResourceLangDim.class, id);
        } finally {
            em.close();
        }
    }

    public int getLremapResourceLangDimCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<LremapResourceLangDim> rt = cq.from(LremapResourceLangDim.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
