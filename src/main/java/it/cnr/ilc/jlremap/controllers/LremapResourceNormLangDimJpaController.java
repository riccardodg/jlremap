/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.controllers.exceptions.NonexistentEntityException;
import it.cnr.ilc.jlremap.controllers.exceptions.PreexistingEntityException;
import it.cnr.ilc.jlremap.entities.LremapResourceNormLangDim;
import it.cnr.ilc.jlremap.entities.LremapResourceNormLangDimPK;
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
public class LremapResourceNormLangDimJpaController implements Serializable {

    public LremapResourceNormLangDimJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(LremapResourceNormLangDim lremapResourceNormLangDim) throws PreexistingEntityException, Exception {
        if (lremapResourceNormLangDim.getLremapResourceNormLangDimPK() == null) {
            lremapResourceNormLangDim.setLremapResourceNormLangDimPK(new LremapResourceNormLangDimPK());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(lremapResourceNormLangDim);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findLremapResourceNormLangDim(lremapResourceNormLangDim.getLremapResourceNormLangDimPK()) != null) {
                throw new PreexistingEntityException("LremapResourceNormLangDim " + lremapResourceNormLangDim + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(LremapResourceNormLangDim lremapResourceNormLangDim) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            lremapResourceNormLangDim = em.merge(lremapResourceNormLangDim);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                LremapResourceNormLangDimPK id = lremapResourceNormLangDim.getLremapResourceNormLangDimPK();
                if (findLremapResourceNormLangDim(id) == null) {
                    throw new NonexistentEntityException("The lremapResourceNormLangDim with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(LremapResourceNormLangDimPK id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            LremapResourceNormLangDim lremapResourceNormLangDim;
            try {
                lremapResourceNormLangDim = em.getReference(LremapResourceNormLangDim.class, id);
                lremapResourceNormLangDim.getLremapResourceNormLangDimPK();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The lremapResourceNormLangDim with id " + id + " no longer exists.", enfe);
            }
            em.remove(lremapResourceNormLangDim);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<LremapResourceNormLangDim> findLremapResourceNormLangDimEntities() {
        return findLremapResourceNormLangDimEntities(true, -1, -1);
    }

    public List<LremapResourceNormLangDim> findLremapResourceNormLangDimEntities(int maxResults, int firstResult) {
        return findLremapResourceNormLangDimEntities(false, maxResults, firstResult);
    }

    private List<LremapResourceNormLangDim> findLremapResourceNormLangDimEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(LremapResourceNormLangDim.class));
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

    public LremapResourceNormLangDim findLremapResourceNormLangDim(LremapResourceNormLangDimPK id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(LremapResourceNormLangDim.class, id);
        } finally {
            em.close();
        }
    }

    public int getLremapResourceNormLangDimCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<LremapResourceNormLangDim> rt = cq.from(LremapResourceNormLangDim.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
