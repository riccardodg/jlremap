/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.jena.serializer;

import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntModelSpec;
import com.hp.hpl.jena.ontology.Ontology;
import com.hp.hpl.jena.rdf.model.Model;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Resource;
import it.cnr.ilc.jlremap.entities.LremapConferences;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

/**
 * This class serializes the conference ontology
 *
 * @author riccardo
 */
public class ConfSerializer {

    private String format = "";
    private PrintStream out;
    private List<LremapConferences> confs = new ArrayList<LremapConferences>();

    /**
     *
     * @param confs
     * @param out
     * @param format
     */
    public ConfSerializer(List<LremapConferences> confs, PrintStream out, String format) {
        this.confs = confs;
        this.out = out;
        this.format = format;
    }

    /**
     * Use it for standard format RDF
     *
     * @param years
     * @param out
     *
     */
    public ConfSerializer(List<LremapConferences> confs, PrintStream out) {
        this.confs = confs;
        this.out = out;

    }

    /**
     * void constructor
     */
    public ConfSerializer() {
    }

    public void write() {
        
        Set Locations = new TreeSet();

        /* namespaces*/
        String YEAR = "http://www.resourcebook.eu/lremap/owl/lremap_year#";
        String DC = "http://purl.org/dc/elements/1.1/";
        String BASE = "http://www.resourcebook.eu/lremap/owl/";
        String CONF = "http://www.resourcebook.eu/lremap/owl/lremap_conf#";
        String SWC = "http://data.semanticweb.org/ns/swc/ontology#";
        String TL = "http://purl.org/NET/c4dm/timeline.owl#";
        String GEO = "http://www.w3.org/2003/01/geo/wgs84_pos#";

        // create an empty model
        Model model = ModelFactory.createDefaultModel();
        OntModel m
                = ModelFactory.createOntologyModel(
                        OntModelSpec.OWL_MEM_RULE_INF,
                        model);

        m.setNsPrefix("year", YEAR);
        m.setNsPrefix("dc", DC);
        m.setNsPrefix("swc", SWC);
        m.setNsPrefix("tl", TL);
        m.setNsPrefix("geo", GEO);
        m.setNsPrefix("base", BASE);
        m.setNsPrefix("conf", CONF);
        Ontology ont = m.createOntology(CONF);
        ont.addImport(model.createResource(SWC));
        /*adding individuals 
        
         <rdfs:label>LREC 2014</rdfs:label>
         <rdf:type rdf:resource="&swc;#ConferenceEvent"/>
         <tl:atYear rdf:datatype="&xsd;#gYear">2014</tl:atYear>
         <swc:hasLocation rdf:resource="&swc;#Reykjavik"/>
         */
        
        /**/
        Resource r = null;
        Resource location=null;
        Property hasLocation=null;
        String confName, year;
        for (LremapConferences item : confs) {
            String type = item.getType();
            if (type.equals("MAIN")) {
                r = model.createResource(SWC + "ConferenceEvent");
                location = model.createResource(SWC+item.getLocation());
                /* create instance */
                confName=item.getLremapConferencesPK().getConf();
                year=item.getLremapConferencesPK().getYear();
                
                Individual y0 = m.createIndividual(SWC + confName+year, r);
                
                /*add hasLocation*/
                hasLocation=m.createProperty(SWC, "hasLocation");
                y0.addProperty(hasLocation, location);
                y0.setLabel(confName+" "+year,"en");

            } else {
                
                r = model.createResource(SWC + "WorkshopEvent");
            }
            
//            System.err.println(YEAR + lremapYear.getYear());
//            //m.removeNsPrefix(YEAR + lremapYear.getYear());
//            y0.addSameAs(sameas);
//            year.addSubClass(subyear);  
        }
        model.write(out, format, BASE);

    }
}
