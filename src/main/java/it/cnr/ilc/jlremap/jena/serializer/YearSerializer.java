/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.jena.serializer;

import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntModelSpec;
import com.hp.hpl.jena.ontology.Ontology;
import com.hp.hpl.jena.rdf.model.Literal;
import com.hp.hpl.jena.rdf.model.Model;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.Resource;
import it.cnr.ilc.jlremap.entities.LremapYears;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

/**
 * This class serializes the year ontology
 *
 * @author riccardo
 */
public class YearSerializer {

    private String format = "";
    private PrintStream out;
    private List<LremapYears> years = new ArrayList<LremapYears>();

    /**
     *
     * @param years
     * @param out
     * @param format
     */
    public YearSerializer(List<LremapYears> years, PrintStream out, String format) {
        this.years = years;
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
    public YearSerializer(List<LremapYears> years, PrintStream out) {
        this.years = years;
        this.out = out;

    }

    /**
     * void constructor
     */
    public YearSerializer() {
    }

    public void write() {

        /* namespaces*/
        String YEAR = "http://www.resourcebook.eu/lremap/owl/lremap_year#";
        String DC = "http://purl.org/dc/elements/1.1/";
        String BASE = "http://www.resourcebook.eu/lremap/owl/";

        // create an empty model
        Model model = ModelFactory.createDefaultModel();
        OntModel m
                = ModelFactory.createOntologyModel(
                        OntModelSpec.OWL_MEM_RULE_INF,
                        model);
        
        Ontology ont =m.createOntology(YEAR);
        Literal ltr = m.createLiteral("Simple Year Ontology");
        ont.addComment(ltr);

        m.setNsPrefix("year", YEAR);
        m.setNsPrefix("dc", DC);
        m.setNsPrefix("base", BASE);

        /* create the year Class*/
        OntClass year = m.createClass(YEAR + "Year");
        year.setLabel("Year", "en");
        Resource dbpedia = model.getResource("http://dbpedia.org/ontology/Year");
        year.setSeeAlso(dbpedia);
        
        
        /*adding subclasses */
        for (LremapYears lremapYear:years){
            OntClass subyear = m.createClass(YEAR + lremapYear.getYear());
            Resource sameas=model.getResource("http://dbpedia.org/resource/"+lremapYear.getYear());
            //subyear.addSameAs(sameas);
            
            Individual y0 = m.createIndividual( YEAR + lremapYear.getYear(), subyear );
            //System.err.println(YEAR + lremapYear.getYear());
            //m.removeNsPrefix(YEAR + lremapYear.getYear());
            y0.addSameAs(sameas);
            year.addSubClass(subyear);  
        }
        model.write(out, format, BASE);

    }
}
