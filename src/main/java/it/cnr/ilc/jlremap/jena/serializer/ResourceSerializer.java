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
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Resource;
import com.hp.hpl.jena.util.iterator.ExtendedIterator;
import it.cnr.ilc.jlremap.Utils;
import it.cnr.ilc.jlremap.controllers.LremapSideTableResmetadataJpaController;
import it.cnr.ilc.jlremap.entities.LremapResource;
import it.cnr.ilc.jlremap.entities.LremapSideTableResmetadata;
import it.cnr.ilc.jlremap.jena.serializer.exceptions.WrongConstructorException;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManagerFactory;
import org.apache.log4j.Logger;

/**
 *
 * @author riccardo
 */
public class ResourceSerializer {

    /**
     * the Logger
     */
    private final String className = ResourceSerializer.class.getName();
    private Logger log = Logger.getLogger(className);

    private String format = "";
    private EntityManagerFactory emf;
    private String all;
    private String list;
    private String single;
    private List<LremapResource> resources = new ArrayList<LremapResource>();
    private int mode;
    private List<String> types = new ArrayList<String>();
    private List<String> uses = new ArrayList<String>();
    private List<String> mods = new ArrayList<String>();
    private List<String> avails = new ArrayList<String>();
    private List<String> prods = new ArrayList<String>();
    LremapSideTableResmetadataJpaController controller;// = new LremapSideTableResmetadataJpaController(emf);
    private static final String __NA__ = "__NOT_PROVIDED__";
    private static final String __NI__ = "Not_Inserted";

    /**
     * Constructor to be used when mode=1
     *
     * @param resources
     * @param list
     * @param single
     * @param mode
     * @throws WrongConstructorException
     */
    public ResourceSerializer(List<LremapResource> resources, String list, String single, int mode) throws WrongConstructorException {

        this.list = list;
        this.single = single;
        this.mode = mode;
        this.resources = resources;
        if (mode == 0) {
            throw new WrongConstructorException(className, "wrong mode value:" + mode + ", expected 1");
        }

    }

    /**
     * Constructor to be used when mode=0
     *
     * @param resources
     * @param all
     * @param mode
     * @throws WrongConstructorException
     */
    public ResourceSerializer(List<LremapResource> resources, String all, int mode) throws WrongConstructorException {
        this.all = all;

        this.resources = resources;
        if (mode == 1) {
            throw new WrongConstructorException(className, "wrong mode value:" + mode + ", expected 0");
        }
        init();
    }

    public void init() {
        String routine = className + "/init";
        String logmess;
        logmess = String.format("INFO INIT RESOURCESERIALIZER -%s- in routine -%s-", list, routine);
        log.info(logmess);
        List<LremapSideTableResmetadata> metadata = null;
        controller = new LremapSideTableResmetadataJpaController(getEmf());
        metadata = controller.findLremapSideTableResmetadataEntities();

        List<String> types = getTypes();
        List<String> uses = getUses();
        List<String> mods = getMods();
        List<String> avails = getAvails();
        List<String> prods = getProds();
        /* resource metadata*/
        String TYPE = "type", LT = "lan_type", PROD = "status", MOD = "mod", AVAIL = "avail", USE = "use";
        String attribute = "", value = "";

        for (LremapSideTableResmetadata md : metadata) {

            attribute = md.getLremapSideTableResmetadataPK().getAttribute();

            /*clean the value*/
            value = md.getLremapSideTableResmetadataPK().getValue();
            value = Utils.cleanAgivenStringInInput(value, "_", "/", "-");
            if (attribute.equals(TYPE)) {
                types.add(value);
            }
            if (attribute.equals(PROD)) {
                prods.add(value);
            }
            if (attribute.equals(AVAIL)) {
                avails.add(value);
            }
            if (attribute.equals(MOD)) {
                mods.add(value);
            }
            if (attribute.equals(USE)) {
                uses.add(value);
            }

        }
    }

    public void writeAll() {
    }

    /**
     *
     */
    public void writeSingleFileAndList() {
        String routine = className + "/writeSingleFileAndList";
        String logmess;
        logmess = String.format("INFO CREATING LIST OF RESOURCES -%s- in routine -%s-", list, routine);
        log.info(logmess);
        OutputStream out = null;
        PrintStream ps = null;
        try {
            out = new FileOutputStream(list);
            ps = new PrintStream(out);
        } catch (Exception e) {
        }

        /* namespaces*/
        String DC = "http://purl.org/dc/elements/1.1/";
        String IRI = "http://www.resourcebook.eu/lremap/owl/instances/listofresources";
        String MERGED = "http://www.resourcebook.eu/lremap/owl/mergedNew.owl#";
        String LOR = "http://www.resourcebook.eu/lremap/owl/instances/resources/";

        // create an empty model
        Model model = ModelFactory.createDefaultModel();
        OntModel m
                = ModelFactory.createOntologyModel(
                        OntModelSpec.OWL_MEM_RULE_INF,
                        model);

        m.setNsPrefix("mer", MERGED);
        m.setNsPrefix("lor", LOR);
        m.setNsPrefix("dc", DC);

        //m.setNsPrefix("list", IRI);
        Ontology ont = m.createOntology(IRI);
        String cmt = String.format("This file lists the Language Resources contained in the LREMAP (So far -%d-)", resources.size());
        Literal comment = m.createLiteral(cmt);
        ont.addVersionInfo(IRI + "/1.0.0");
        ont.addComment(comment);
        ont.addImport(model.createResource(MERGED));

        /*
         create a list such as
         <rdf:Description 
         rdf:about="http://www.resourcebook.eu/lremap/owl/instances/resources/6/6a2/6a27ec599b7dbcaa989527b402db9dce1909abe2">
         <rdfs:label>Conference: LREC and Year: 2014 and Passcode: 594X-H8J4C9D6J4 and Type: Corpus and Name: Corpus of Hindi Blogs 
         </rdfs:label></rdf:Description>
         */
        String label = "";
        Literal lbl = null;
        int i=1;
        for (LremapResource resource : resources) {
            String id, first, second, path;
            id = resource.getResourceid();
            first = id.substring(0, 1);
            second = id.substring(0, 3);
            path = LOR + first + "/" + second + "/" + id;

            //System.err.println("MERGED "+MERGED);
            Resource l = m.createResource(MERGED + "Resource");
            Individual y0 = m.createIndividual(path, l);

            label = String.format("Conference -%s- and Year -%s- and Passcode -%s- and Type -%s- and Name -%s-", resource.getConf(), resource.getYear(), resource.getPasscode(), resource.getType(), resource.getName());
            lbl = m.createLiteral(label);
            y0.addLabel(lbl);
            System.err.println("resource "  + id+ " # "+i);
            write(resource);
            i++;
        }
        model.write(ps, getFormat());
    }

    private void write(LremapResource resource) {
        String routine = className + "/write";
        String logmess;
        logmess = String.format("INFO CREATING RESOURCE FILE FOR ID -%s- in routine -%s-", resource.getResourceid(), routine);
        //log.info(logmess);
        String __RESOURCE__ = "resources";

        String id, first, second, path;

        /* resource metadata*/
        String TYPE = "", NAME = "", STATUS = "", MOD = "", AVAIL = "", USE = "";
        /* resource metadata*/
        String LNAME = "";
        String NAMECLASS = "ResourceName";
        String TYPECLASS = "ResourceType";

        OutputStream out = null;
        PrintStream ps = null;
        String filePath = "", dirPath = "";
        Resource l, r = null;
        Individual y0, i0 = null;
        Literal lbl = null;
        Literal comment = null;
        OntClass c = null;
        OntClass sc = null;
        Property p = null;
        String label = "";

        /* namespaces*/
        String DC = "http://purl.org/dc/elements/1.1/";
        String MERGED = "http://www.resourcebook.eu/lremap/owl/mergedNew.owl#";
        String LOR = "http://www.resourcebook.eu/lremap/owl/instances/resources/";

        String LVONT = "http://lexvo.org/ontology";
        String DCTERMS = "http://purl.org/dc/terms/#";
        String SUB = "http://www.resourcebook.eu/lremap/owl/lremap_sub";

        String RI = "http://www.resourcebook.eu/lremap/owl/instances";
        String LREMAP = "http://www.resourcebook.eu/lremap/owl/lremap_resource.owl#";
        String LREMAP_IMP = "http://www.resourcebook.eu/lremap/owl/lremap_resource.owl";

        id = resource.getResourceid();

        first = id.substring(0, 1);
        second = id.substring(0, 3);
        path = LOR + first + "/" + second + "/" + id;

        /*create the stream */
        File file = null;
        dirPath = single + first + "/" + second;
        filePath = dirPath + "/" + id;

        try {

            file = new File(dirPath);
            if (!file.exists()) {
                file.mkdirs();
            }

            out = new FileOutputStream(filePath);
            ps = new PrintStream(out);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Model model = ModelFactory.createDefaultModel();
        OntModel m
                = ModelFactory.createOntologyModel(
                        OntModelSpec.OWL_MEM_RULE_INF,
                        model);

        Ontology ont = m.createOntology(RI);
        String cmt = String.format("This file describes the LR with id -%s-", id);
        comment = m.createLiteral(cmt);
        ont.addVersionInfo(path + "/1.0.0");
        ont.addComment(comment);
        ont.addImport(model.createResource(MERGED));

        m.setNsPrefix("mer", MERGED);
        m.setNsPrefix("dcterms", DCTERMS);
        m.setNsPrefix("lremap", LREMAP);
        m.setNsPrefix("dc", DC);
        m.setNsPrefix("lvont", LVONT);
        m.setNsPrefix("sub", SUB);
        m.setNsPrefix("ri", RI);

//        /*fill metadata */
        
        LNAME = resource.getName();
       // LNAME="The Weka workbench[1] contains a collection of visualization tools and algorithms for data analysis and predictive modelling";
        if (LNAME.equals(__NA__)) {
            NAMECLASS = "NoName";
        }

        TYPE = resource.getType();
        //TYPE = __NA__;
        if (TYPE.equals(__NA__) || TYPE.equals(__NI__)) {
            TYPECLASS = "NoType";
        }

        NAME = Utils.cleanAgivenStringInInput(LNAME, "_", "/", "-");
        TYPE = Utils.cleanAgivenStringInInput(TYPE, "_", "/", "-");
        //System.err.println("label resname=" + LNAME + " " + NAME);

        /*let's create the instance of the resource
        
         <owl:NamedIndividual rdf:about="http://www.resourcebook.eu/lremap/owl/instancesresources/4/48a/48a42a2c2938759c17ce9c0f80b4c624149dc4da">
         <rdf:type rdf:resource="http://www.resourcebook.eu/lremap/owl/lremap_resource.owl#Annotation_Tool"/>
         <lremap:hasResourceAvailability rdf:resource="http://www.resourcebook.eu/lremap/owl/lremap_resource.owl#From_Owner"/>
         <lremap:hasResourceStatus rdf:resource="http://www.resourcebook.eu/lremap/owl/lremap_resource.owl#Newly_created-in_progress"/>
         <lremap:hasResourceModality rdf:resource="http://www.resourcebook.eu/lremap/owl/lremap_resource.owl#Written"/>
         <lremap:hasResourceName rdf:resource="http://www.resourcebook.eu/lremap/owl/instancesresources/4/48a/Simplify_Data_For_Parsers_Cz"/>
         <dcterms:references rdf:resource="http://www.resourcebook.eu/lremap/owl/lremap_sub#LREC2014-228X-A3C2H6B7F2"/>
         </owl:NamedIndividual>
         */
        if (TYPECLASS.equalsIgnoreCase("NoType")) {
            r = m.createResource(LREMAP + TYPECLASS);
        } else {
            r = m.createResource(LREMAP + TYPE);
        }
        i0 = m.createIndividual(path, r);

        /* let's create the resource name instance */
        //System.err.println("NAME "+NAMECLASS);
        
        if (NAMECLASS.equalsIgnoreCase("NoName")) {
            r = m.createResource(LREMAP + NAMECLASS);
        } else {
            r = m.createResource(LREMAP + NAME);
        }
        l = m.createResource(LREMAP + NAMECLASS);
        y0 = m.createIndividual(path + "#" + NAME, l);

        /* add the HasName property*/
        p = m.createProperty(LREMAP + "hasResourceName");
        i0.addProperty(p, y0);

        label = String.format("Original name -%s-", LNAME);
        lbl = m.createLiteral(label);
        y0.addLabel(lbl);

        /* read classes from LREMAP */
        OntModel inf = ModelFactory.createOntologyModel();

        inf.read(LREMAP_IMP);
        ExtendedIterator classes = inf.listClasses();

        /*look for resourcetype */
        while (classes.hasNext()) {
            OntClass essaClasse = (OntClass) classes.next();
            if (essaClasse != null) {
                String vClasse = essaClasse.getLocalName().toString();
                if (vClasse.contains(TYPECLASS)) {
                    c = essaClasse;
                    //System.err.println("vClasse "+vClasse);
                    break;
                }
                //
            }
        }
        /* let's create the new restype class*/
        if (!types.contains(TYPE)) {
            /* in this case a new subclass of resourcetype is created */
            //System.err.println("NO " + TYPE);

            //c = m.createClass(LREMAP + "ResourceType");
            
            if (!TYPECLASS.equalsIgnoreCase("NoType")) {
                sc = m.createClass(LREMAP + TYPE);
                c.addSubClass(sc);
            }

        }
        model.write(ps, getFormat());

    }

    /**
     * @return the format
     */
    public String getFormat() {
        return format;
    }

    /**
     * @param format the format to set
     */
    public void setFormat(String format) {
        this.format = format;
    }

    /**
     * @return the emf
     */
    public EntityManagerFactory getEmf() {
        return emf;
    }

    /**
     * @param emf the emf to set
     */
    public void setEmf(EntityManagerFactory emf) {
        this.emf = emf;
    }

    /**
     * @return the types
     */
    public List<String> getTypes() {
        return types;
    }

    /**
     * @param types the types to set
     */
    public void setTypes(List<String> types) {
        this.types = types;
    }

    /**
     * @return the uses
     */
    public List<String> getUses() {
        return uses;
    }

    /**
     * @param uses the uses to set
     */
    public void setUses(List<String> uses) {
        this.uses = uses;
    }

    /**
     * @return the mods
     */
    public List<String> getMods() {
        return mods;
    }

    /**
     * @param mods the mods to set
     */
    public void setMods(List<String> mods) {
        this.mods = mods;
    }

    /**
     * @return the avails
     */
    public List<String> getAvails() {
        return avails;
    }

    /**
     * @param avails the avails to set
     */
    public void setAvails(List<String> avails) {
        this.avails = avails;
    }

    /**
     * @return the prods
     */
    public List<String> getProds() {
        return prods;
    }

    /**
     * @param prods the prods to set
     */
    public void setProds(List<String> prods) {
        this.prods = prods;
    }

}
