/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package omg.gotodoc.service;

import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.core.MediaType;

import java.io.ByteArrayOutputStream;
import javax.ws.rs.PathParam;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.QuerySolution;
import org.apache.jena.query.ResultSet;
import org.apache.jena.query.ResultSetFormatter;
import org.apache.jena.rdf.model.Literal;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.RDFNode;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.util.FileManager;

@Path("CustomQueryService")
public class CustomQueryService {

    private QueryExecution qexec;

    @Context
    private UriInfo context;

    public CustomQueryService() {

    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("{Cidade}")
    public String getJson(@PathParam("Cidade") String Cidade) {

        String queryString = "";
        queryString = queryString + " PREFIX foaf: <http://xmlns.com/foaf/0.1/>			";
        queryString = queryString + " PREFIX geo: <http://www.opengis.net/ont/geosparql#>	";
        queryString = queryString + " PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>	";
        queryString = queryString + " PREFIX owl: <http://www.w3.org/2002/07/owl#>		";
        queryString = queryString + " PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>	";
        queryString = queryString + " PREFIX vcard: <http://www.w3.org/2006/vcard/ns#>		";
        queryString = queryString + " SELECT DISTINCT ?url ?nome ?cidade ?lng ?lat		";
        queryString = queryString + " WHERE {							";
        queryString = queryString + "   ?url vcard:id ?id .					";
        queryString = queryString + "   ?url vcard:locality ?cidade .				";
        queryString = queryString + "   ?url vcard:organization-name ?nome .			";
        queryString = queryString + "   ?url vcard:locality '" + Cidade + "' .			";
        queryString = queryString + "   ?url vcard:longitude ?lng .				";
        queryString = queryString + "   ?url vcard:latitude ?lat				";
        queryString = queryString + "   } 							";
        queryString = queryString + " LIMIT 300						";

        Query query = QueryFactory.create(queryString);
        qexec = QueryExecutionFactory.sparqlService("http://localhost:3030/dataset_ubs/query", query);
        
        try {
            ResultSet results = qexec.execSelect();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            ResultSetFormatter.outputAsJSON(outputStream, results);
            String json = new String(outputStream.toByteArray());
            return json;
        } finally {
            qexec.close();
        }

    }

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void putJson(String content) {
    }
}
