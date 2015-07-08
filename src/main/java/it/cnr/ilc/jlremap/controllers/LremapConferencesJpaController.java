/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.controllers.exceptions.NonexistentEntityException;
import it.cnr.ilc.jlremap.controllers.exceptions.PreexistingEntityException;
import it.cnr.ilc.jlremap.entities.LremapConferences;
import it.cnr.ilc.jlremap.entities.LremapConferencesPK;
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
public class LremapConferencesJpaController implements Serializable {

    public LremapConferencesJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(LremapConferences lremapConferences) throws PreexistingEntityException, Exception {
        if (lremapConferences.getLremapConferencesPK() == null) {
            lremapConferences.setLremapConferencesPK(new LremapConferencesPK());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(lremapConferences);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findLremapConferences(lremapConferences.getLremapConferencesPK()) != null) {
                throw new PreexistingEntityException("LremapConferences " + lremapConferences + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(LremapConferences lremapConferences) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            lremapConferences = em.merge(lremapConferences);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                LremapConferencesPK id = lremapConferences.getLremapConferencesPK();
                if (findLremapConferences(id) == null) {
                    throw new NonexistentEntityException("The lremapConferences with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(LremapConferencesPK id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            LremapConferences lremapConferences;
            try {
                lremapConferences = em.getReference(LremapConferences.class, id);
                lremapConferences.getLremapConferencesPK();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The lremapConferences with id " + id + " no longer exists.", enfe);
            }
            em.remove(lremapConferences);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<LremapConferences> findLremapConferencesEntities() {
        return findLremapConferencesEntities(true, -1, -1);
    }

    public List<LremapConferences> findLremapConferencesEntities(int maxResults, int firstResult) {
        return findLremapConferencesEntities(false, maxResults, firstResult);
    }

    private List<LremapConferences> findLremapConferencesEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(LremapConferences.class));
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

    public LremapConferences findLremapConferences(LremapConferencesPK id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(LremapConferences.class, id);
        } finally {
            em.close();
        }
    }

    public int getLremapConferencesCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<LremapConferences> rt = cq.from(LremapConferences.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
