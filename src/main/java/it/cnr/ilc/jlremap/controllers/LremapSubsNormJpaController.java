/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.controllers.exceptions.IllegalOrphanException;
import it.cnr.ilc.jlremap.controllers.exceptions.NonexistentEntityException;
import it.cnr.ilc.jlremap.controllers.exceptions.PreexistingEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import it.cnr.ilc.jlremap.entities.LremapResourceKeys;
import it.cnr.ilc.jlremap.entities.LremapSubsNorm;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author Riccardo Del Gratta
 * @mail riccardo.delgratta@{gmail.com|ilc.cnr.it}
 */
public class LremapSubsNormJpaController implements Serializable {

    public LremapSubsNormJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(LremapSubsNorm lremapSubsNorm) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            LremapResourceKeys lremapResourceKeys = lremapSubsNorm.getLremapResourceKeys();
            if (lremapResourceKeys != null) {
                lremapResourceKeys = em.getReference(lremapResourceKeys.getClass(), lremapResourceKeys.getResourceid());
                lremapSubsNorm.setLremapResourceKeys(lremapResourceKeys);
            }
            em.persist(lremapSubsNorm);
            if (lremapResourceKeys != null) {
                LremapSubsNorm oldResourceNormidOfLremapResourceKeys = lremapResourceKeys.getResourceNormid();
                if (oldResourceNormidOfLremapResourceKeys != null) {
                    oldResourceNormidOfLremapResourceKeys.setLremapResourceKeys(null);
                    oldResourceNormidOfLremapResourceKeys = em.merge(oldResourceNormidOfLremapResourceKeys);
                }
                lremapResourceKeys.setResourceNormid(lremapSubsNorm);
                lremapResourceKeys = em.merge(lremapResourceKeys);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findLremapSubsNorm(lremapSubsNorm.getResourceid()) != null) {
                throw new PreexistingEntityException("LremapSubsNorm " + lremapSubsNorm + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(LremapSubsNorm lremapSubsNorm) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            LremapSubsNorm persistentLremapSubsNorm = em.find(LremapSubsNorm.class, lremapSubsNorm.getResourceid());
            LremapResourceKeys lremapResourceKeysOld = persistentLremapSubsNorm.getLremapResourceKeys();
            LremapResourceKeys lremapResourceKeysNew = lremapSubsNorm.getLremapResourceKeys();
            List<String> illegalOrphanMessages = null;
            if (lremapResourceKeysOld != null && !lremapResourceKeysOld.equals(lremapResourceKeysNew)) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("You must retain LremapResourceKeys " + lremapResourceKeysOld + " since its resourceNormid field is not nullable.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (lremapResourceKeysNew != null) {
                lremapResourceKeysNew = em.getReference(lremapResourceKeysNew.getClass(), lremapResourceKeysNew.getResourceid());
                lremapSubsNorm.setLremapResourceKeys(lremapResourceKeysNew);
            }
            lremapSubsNorm = em.merge(lremapSubsNorm);
            if (lremapResourceKeysNew != null && !lremapResourceKeysNew.equals(lremapResourceKeysOld)) {
                LremapSubsNorm oldResourceNormidOfLremapResourceKeys = lremapResourceKeysNew.getResourceNormid();
                if (oldResourceNormidOfLremapResourceKeys != null) {
                    oldResourceNormidOfLremapResourceKeys.setLremapResourceKeys(null);
                    oldResourceNormidOfLremapResourceKeys = em.merge(oldResourceNormidOfLremapResourceKeys);
                }
                lremapResourceKeysNew.setResourceNormid(lremapSubsNorm);
                lremapResourceKeysNew = em.merge(lremapResourceKeysNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = lremapSubsNorm.getResourceid();
                if (findLremapSubsNorm(id) == null) {
                    throw new NonexistentEntityException("The lremapSubsNorm with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(String id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            LremapSubsNorm lremapSubsNorm;
            try {
                lremapSubsNorm = em.getReference(LremapSubsNorm.class, id);
                lremapSubsNorm.getResourceid();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The lremapSubsNorm with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            LremapResourceKeys lremapResourceKeysOrphanCheck = lremapSubsNorm.getLremapResourceKeys();
            if (lremapResourceKeysOrphanCheck != null) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This LremapSubsNorm (" + lremapSubsNorm + ") cannot be destroyed since the LremapResourceKeys " + lremapResourceKeysOrphanCheck + " in its lremapResourceKeys field has a non-nullable resourceNormid field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(lremapSubsNorm);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<LremapSubsNorm> findLremapSubsNormEntities() {
        return findLremapSubsNormEntities(true, -1, -1);
    }

    public List<LremapSubsNorm> findLremapSubsNormEntities(int maxResults, int firstResult) {
        return findLremapSubsNormEntities(false, maxResults, firstResult);
    }

    private List<LremapSubsNorm> findLremapSubsNormEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(LremapSubsNorm.class));
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

    public LremapSubsNorm findLremapSubsNorm(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(LremapSubsNorm.class, id);
        } finally {
            em.close();
        }
    }

    public int getLremapSubsNormCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<LremapSubsNorm> rt = cq.from(LremapSubsNorm.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
