/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.controllers;

import it.cnr.ilc.jlremap.entities.LremapConferences;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Query;
/**
 *
 * @author riccardo
 */
public class ConfController {
    
    

    private EntityManagerFactory emf;

     

        private EntityManager getEntityManager() {

            if (emf == null) {

                emf = Persistence.createEntityManagerFactory("lremapPu");

            }

            return emf.createEntityManager();

        }

     
        /**
         * get the list of years from the database 
         * @return the list of years from the database 
         */
        public List<LremapConferences> geConferences() {
            List<LremapConferences> confs=new ArrayList<LremapConferences>();

            EntityManager em = getEntityManager();

            try {

                Query q = em.createNamedQuery("LremapConferences.findAll");
                confs=q.getResultList();
                

                return confs;

            } finally {

                em.close();

            }

        }

    
}
