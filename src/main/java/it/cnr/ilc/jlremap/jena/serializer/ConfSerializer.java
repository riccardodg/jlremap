/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.jena.serializer;

import com.hp.hpl.jena.datatypes.xsd.XSDDatatype;
import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntModelSpec;
import com.hp.hpl.jena.ontology.Ontology;
import com.hp.hpl.jena.rdf.model.Literal;
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

        Set<String> Locations = new TreeSet<String>();

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

        //m.setNsPrefix("year", YEAR);
        m.setNsPrefix("dc", DC);
        m.setNsPrefix("swc", SWC);
        m.setNsPrefix("tl", TL);
        m.setNsPrefix("geo", GEO);
        m.setNsPrefix("base", BASE);
        m.setNsPrefix("conf", CONF);
        Ontology ont = m.createOntology(CONF);
        ont.addImport(model.createResource(SWC));
        Literal comment = m.createLiteral("This ontology models the conferencesmanaged in LREMAP according to the SWC ontology");
        ont.addComment(comment);
        /*adding individuals 
        
         <rdfs:label>LREC 2014</rdfs:label>
         <rdf:type rdf:resource="&swc;#ConferenceEvent"/>
         <tl:atYear rdf:datatype="&xsd;#gYear">2014</tl:atYear>
         <swc:hasLocation rdf:resource="&swc;#Reykjavik"/>
         ....
         <swc:isSubEventOf rdf:resource="&swc;#LREC2014"/>
         */

        /**/
        Resource r = null;
        Resource location = null;
        Resource main = null;
        Property hasLocation = null;
        Property subEventOf = null;
        Property atYear = null;
        String confName, year, mainEvent = "";
        Individual y0 = null;
        /* in this loop create main and location list*/
        for (LremapConferences item : confs) {
            Locations.add(item.getLocation());
            confName = item.getLremapConferencesPK().getConf();
            year = item.getLremapConferencesPK().getYear();
            mainEvent = confName + year;

            if (item.getType().equals("MAIN")) {
                main = model.createResource(SWC + mainEvent);
            }

        }
        for (LremapConferences item : confs) {
            String type = item.getType();

            confName = item.getLremapConferencesPK().getConf();
            year = item.getLremapConferencesPK().getYear();

            if (type.equals("MAIN")) {
                r = model.createResource(SWC + "ConferenceEvent");
                y0 = m.createIndividual(SWC + mainEvent, r);
                /* create instance */

                /*add hasLocation*/
            } else {
                r = model.createResource(SWC + "WorkshopEvent");
                y0 = m.createIndividual(SWC + confName + year, r);
                subEventOf = m.createProperty(SWC + "isSubEventOf");
                y0.addProperty(subEventOf, main);
            }

            location = model.createResource(SWC + item.getLocation());
            atYear = model.createProperty(TL + "atYear");

            hasLocation = model.createProperty(SWC + "hasLocation");
            y0.addProperty(hasLocation, location);
            y0.setLabel(confName + " " + year, "en");
            y0.addProperty(atYear, year, XSDDatatype.XSDgYear);

//            System.err.println(YEAR + lremapYear.getYear());
//            //m.removeNsPrefix(YEAR + lremapYear.getYear());
//            y0.addSameAs(sameas);
//            year.addSubClass(subyear);  
        }
        
        /*add location as 
        <owl:NamedIndividual rdf:about="&swc;#Reykjavik">
		<rdf:type rdf:resource="&geo;#SpatialThing"/>
	</owl:NamedIndividual>
        */
        
        for (String loc :Locations){
            Resource l = m.createResource(GEO+"SpatialThing");
            y0=m.createIndividual(SWC+loc, l);
        }
        
        model.write(out, format, BASE);

    }
}
