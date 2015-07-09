/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.jena.serializer.exceptions;

import org.apache.log4j.Logger;

/**
 *
 * @author riccardo
 */
public class WrongConstructorException extends Exception {

    String message;
    /**
     * for log
     */
    static final String className = WrongConstructorException.class.getName();

    /**
     * the Logger
     */
    static Logger log = Logger.getLogger(className);

    public WrongConstructorException(String caller, String message) {
        super(message);
        String routine = className, logmess;

        if (message == null) {
            this.message = "";
        } else {
            this.message = message;
        }
        logmess = String.format("FATAL CREATING -%s- message -%s-", caller, message);
        log.fatal(logmess);

    }

    public String getMessage() {
        return message;
    }
}
