/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.controllers.exceptions.NonexistentEntityException;
import it.cnr.ilc.jlremap.controllers.exceptions.PreexistingEntityException;
import it.cnr.ilc.jlremap.entities.LremapYears;
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
 * @author Riccardo Del Gratta
 * @mail riccardo.delgratta@{gmail.com|ilc.cnr.it}
 */
public class LremapYearsJpaController implements Serializable {

    public LremapYearsJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(LremapYears lremapYears) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(lremapYears);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findLremapYears(lremapYears.getYear()) != null) {
                throw new PreexistingEntityException("LremapYears " + lremapYears + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(LremapYears lremapYears) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            lremapYears = em.merge(lremapYears);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = lremapYears.getYear();
                if (findLremapYears(id) == null) {
                    throw new NonexistentEntityException("The lremapYears with id " + id + " no longer exists.");
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
            LremapYears lremapYears;
            try {
                lremapYears = em.getReference(LremapYears.class, id);
                lremapYears.getYear();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The lremapYears with id " + id + " no longer exists.", enfe);
            }
            em.remove(lremapYears);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<LremapYears> findLremapYearsEntities() {
        return findLremapYearsEntities(true, -1, -1);
    }

    public List<LremapYears> findLremapYearsEntities(int maxResults, int firstResult) {
        return findLremapYearsEntities(false, maxResults, firstResult);
    }

    private List<LremapYears> findLremapYearsEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(LremapYears.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            System.err.println("q all "+q);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public LremapYears findLremapYears(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(LremapYears.class, id);
        } finally {
            em.close();
        }
    }

    public int getLremapYearsCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<LremapYears> rt = cq.from(LremapYears.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
