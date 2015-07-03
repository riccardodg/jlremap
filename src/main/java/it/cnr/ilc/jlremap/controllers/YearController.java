/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.controllers;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import it.cnr.ilc.jlremap.entities.LremapYears;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Query;
/**
 *
 * @author riccardo
 */
public class YearController {
    
    

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
        public List<LremapYears> getYears() {
            List<LremapYears> years=new ArrayList<LremapYears>();

            EntityManager em = getEntityManager();

            try {

                Query q = em.createNamedQuery("LremapYears.findAll");
                years=q.getResultList();
                

                return years;

            } finally {

                em.close();

            }

        }

    
}
