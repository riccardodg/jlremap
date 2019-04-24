/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.cnr.ilc.jlremap.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author riccardo
 */
public class DbConnect {

    public final String host = "localhost";
    public final String user = "mystart";
    public final String passwd = "mystart";
    public final String database = "lremap_new";
    private Connection conn = null;
    

    public Connection db_connect() {
        String connStr = "jdbc:mysql://" + host + "/" + database + "?" + "user=" + user + "&password=" + passwd;

        try {

            Class.forName("com.mysql.jdbc.Driver");
            if (conn == null) {
                conn = DriverManager
                        .getConnection(connStr);
            }

        } catch (SQLException | ClassNotFoundException sqle) {

            System.exit((-1));

        }
        return conn;
    }
    
    public int execStm(Connection conn, String stm){
        Statement statement = null;
        try {
            
            statement = conn.createStatement();
            // Result set get the result of the SQL query
            statement
                    .executeQuery(stm);
            

        } catch (Exception e) {
            return 1;
           
        }
    
        return 0;
    }
    

}
