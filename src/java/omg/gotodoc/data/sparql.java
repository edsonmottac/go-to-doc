/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package omg.gotodoc.data;

import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import java.text.Normalizer;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.QuerySolution;
import org.apache.jena.query.ResultSet;
import org.apache.jena.rdf.model.Literal;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.RDFNode;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.util.FileManager;

public class sparql {

    public QueryExecution qexec;

    public String loadPrefixos() {
        String prefixos = "";
        prefixos = prefixos + " PREFIX foaf: <http://xmlns.com/foaf/0.1/>                       ";
        prefixos = prefixos + " PREFIX geo: <http://www.opengis.net/ont/geosparql#>             ";
        prefixos = prefixos + " PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>            ";
        prefixos = prefixos + " PREFIX owl: <http://www.w3.org/2002/07/owl#>                    ";
        prefixos = prefixos + " PREFIX gtd: <http://localhost:3030/>                            ";
        prefixos = prefixos + " PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>	";
        prefixos = prefixos + " PREFIX vcard: <http://www.w3.org/2006/vcard/ns#>		";
        return prefixos;
    }

    public ResultSet getPointsByCity(String regiao, String cidade, String estado , String detalhe, String rate1, String rate2, String rate3, String rate4, String tipounidade) throws UnsupportedEncodingException {
       
        if (cidade != null ) 
        { 
            cidade = new String(cidade.getBytes(), "UTF-8"); 
            cidade= (cidade.equals("") ? "" : "FILTER (?cidade ='" + cidade  + "') . ");
        }else {
            if (cidade== null && estado==null && regiao==null) {
                cidade = "FILTER (?cidade ='Salvador') . ";
            }
        }
            
        if (estado != null ) {estado= (estado.equals("") ? "" : "FILTER (?estado ='" + estado  + "') . ");} else {estado="";}
        if (regiao != null ) {regiao= (regiao.equals("") ? "" : "FILTER (?regiao ='" + regiao  + "') . ");} else {regiao="";}
        
        //tipounidade="UBS";
        String tp = tipounidade;
        if (tipounidade != null ) 
        {
            tipounidade= (tipounidade.equals("") ? "FILTER (?tipo ='UBS') . " : "FILTER (?tipo ='" + tipounidade  + "') . ");
        } else {
            tipounidade= "FILTER (?tipo ='UBS') . ";
        }
        
        if (rate1 != null ) {rate1= (rate1.equals("") ? "" : "FILTER (?rate1 ='" + rate1  + "') . ");} else {rate1="";}
        if (rate2 != null ) {rate2= (rate2.equals("") ? "" : "FILTER (?rate2 ='" + rate2  + "') . ");} else {rate2="";}
        if (rate3 != null ) {rate3= (rate3.equals("") ? "" : "FILTER (?rate3 ='" + rate3  + "') . ");} else {rate3="";}
        if (rate4 != null ) {rate4= (rate4.equals("") ? "" : "FILTER (?rate4 ='" + rate4  + "') . ");} else {rate4="";}

        
        String queryString = loadPrefixos();
        queryString = queryString + " SELECT 	";
        queryString = queryString + " 	?url ?nome ?tp_unidade  ?lat ?lng  ?endereco ?bairro ?telefone ?especialidades ?detalhe ?regiao ?cidade ?estado ?horario ?local ?uf?tipo ?rate1 ?rate2 ?rate3 ?rate4 ";
        queryString = queryString + " WHERE {  ";
        queryString = queryString + "   ?url vcard:organization-name ?nome .        ";
        queryString = queryString + "   ?url vcard:organization-unit  ?tp_unidade .   ";
        queryString = queryString + "   ?url vcard:street-address  ?endereco .        ";
        queryString = queryString + "   ?url vcard:neighborhood  ?bairro .        ";
        queryString = queryString + "   ?url vcard:phone  ?telefone . ";
        queryString = queryString + "   ?url vcard:region  ?regiao .    " + regiao + "  ";
        queryString = queryString + "   ?url vcard:locality ?cidade .  " + cidade + "  ";
        queryString = queryString + "   ?url vcard:uf ?estado  .  " + estado + "  ";
        queryString = queryString + "   ?url vcard:locality ?local .";
        queryString = queryString + "   ?url vcard:time ?horario .";
        queryString = queryString + "   ?url vcard:category ?especialidades .";
        queryString = queryString + "   ?url vcard:latitude  ?lng .";
        queryString = queryString + "   ?url vcard:longitude  ?lat .";
        queryString = queryString + "   ?url vcard:hasUID   ?id .  ";
        
        
        queryString = queryString + "   ?url vcard:role ?tipo  .  " +  tipounidade + " ";
        
        if (tp ==null || tp == "UBS") {
            queryString = queryString + "   ?url gtd:rate_ambiencia ?rate1 . " + rate1 + "  ";
            queryString = queryString + "   ?url gtd:rate_adaptacao  ?rate2 . " + rate2 + "  ";
            queryString = queryString + "   ?url gtd:rate_equipamentos  ?rate3 . " + rate3 + "  ";
            queryString = queryString + "   ?url gtd:rate_medicamentos  ?rate4 . " + rate4 + "  ";
        }
                
        if (detalhe != null ) 
        {
            detalhe= (detalhe.equals("") ? "" : "FILTER (?detalhe ='" + detalhe  + "') . ");
            queryString = queryString + "   ?url vcard:title ?detalhe . " + detalhe + "  ";
        }
        
        
        queryString = queryString + " } LIMIT 5000";



        System.out.println(queryString);
        Query query = QueryFactory.create(queryString);
        qexec = QueryExecutionFactory.sparqlService("http://localhost:3030/CNESDataRecource/query", query);
        try {
            ResultSet results = qexec.execSelect();
            return results;

        } finally {
            //qexec.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="COMBOS & LISTAGENS">
    public String getComboListRegion(String item) throws UnsupportedEncodingException {

        System.out.println(item);

        String queryString = loadPrefixos();
        queryString = queryString + " SELECT DISTINCT ?region                                   ";
        queryString = queryString + " WHERE {							";
        queryString = queryString + "   ?url vcard:region ?region 				";
        queryString = queryString + "   } 							";
        queryString = queryString + " ORDER BY ?region                                          ";
        queryString = queryString + "                                                           ";

        Query query = QueryFactory.create(queryString);
        qexec = QueryExecutionFactory.sparqlService("http://localhost:3030/CNESDataRecource/query", query);
        try {
            ResultSet results = qexec.execSelect();
            String options = "";
            while (results.hasNext()) {
                QuerySolution soln = results.nextSolution();
                RDFNode region = soln.get("region");
                options = options + "<option value='" + region + "'";
                if (item != null) {
                    item = new String(item.getBytes(), "UTF-8");
                }
                if (region.toString().equals(item)) {
                    options = options + " selected ";
                }
                options = options + ">" + region + "</option>";
            }
            return options;

        } finally {
            qexec.close();
        }

    }

    public String getComboListCity(String item) throws UnsupportedEncodingException {

        String c="";
        
        //response.setContentType("text/html;charset=UTF-8");
        String queryString = loadPrefixos();
        queryString = queryString + " SELECT DISTINCT ?cidade                                   ";
        queryString = queryString + " WHERE {							";
        queryString = queryString + "   ?url vcard:locality ?cidade 				";
        queryString = queryString + "   } 							";
        queryString = queryString + " ORDER BY ?name                                            ";
        queryString = queryString + "                                                           ";

        Query query = QueryFactory.create(queryString);
        qexec = QueryExecutionFactory.sparqlService("http://localhost:3030/CNESDataRecource/query", query);
        try {
            ResultSet results = qexec.execSelect();
            String options = "";
            while (results.hasNext()) {
                QuerySolution soln = results.nextSolution();
                RDFNode cidade = soln.get("cidade");
                options = options + "<option value='" + cidade + "'";
                if (item != null) {
                    item = new String(item.getBytes(), "UTF-8");
                    item= Normalizer.normalize(item, Normalizer.Form.NFD);
                    item = item.replaceAll("[^\\p{ASCII}]", "");
                    
                    c = Normalizer.normalize(cidade.toString(), Normalizer.Form.NFD);
                    c = c.replaceAll("[^\\p{ASCII}]", "");
                }
                
                if (item==null) {item="Salvador";}
                
                if (c.equals(item)) {
                    options = options + " selected ";
                }
                options = options + ">" + cidade + "</option>";
            }
            return options;

        } finally {
            qexec.close();
        }

    }

    public String getComboListSpecialization(String item) throws UnsupportedEncodingException {

        String queryString = loadPrefixos();
        queryString = queryString + " SELECT DISTINCT ?especialidade                                    ";
        queryString = queryString + " WHERE {                                                           ";
        queryString = queryString + "   ?url vcard:title ?especialidade 				";
        queryString = queryString + "   }                                                               ";
        queryString = queryString + " ORDER BY ?especialidade                                           ";
        queryString = queryString + "                                                                   ";

        Query query = QueryFactory.create(queryString);
        qexec = QueryExecutionFactory.sparqlService("http://localhost:3030/CNESDataRecource/query", query);
        try {
            ResultSet results = qexec.execSelect();
            String options = "";
            while (results.hasNext()) {
                QuerySolution soln = results.nextSolution();
                RDFNode especialidade = soln.get("especialidade");
                options = options + "<option value='" + especialidade + "'";
                if (item != null) {
                    item = new String(item.getBytes(), "UTF-8");
                }
                if (especialidade.toString().equals(item)) {
                    options = options + " selected ";
                }
                options = options + ">" + especialidade + "</option>";
            }
            return options;

        } finally {
            qexec.close();
        }

    }
    
    public String getComboListEstado(String item) throws UnsupportedEncodingException {

        String queryString = loadPrefixos();
        queryString = queryString + " SELECT DISTINCT ?estado                                    ";
        queryString = queryString + " WHERE {                                                           ";
        queryString = queryString + "   ?url vcard:uf ?estado 				";
        queryString = queryString + "   }                                                               ";
        queryString = queryString + " ORDER BY ?estado                                           ";
        queryString = queryString + "                                                                   ";

        Query query = QueryFactory.create(queryString);
        qexec = QueryExecutionFactory.sparqlService("http://localhost:3030/CNESDataRecource/query", query);
        try {
            ResultSet results = qexec.execSelect();
            String options = "";
            while (results.hasNext()) {
                QuerySolution soln = results.nextSolution();
                RDFNode estado = soln.get("estado");
                options = options + "<option value='" + estado + "'";
                if (item != null) {
                    item = new String(item.getBytes(), "UTF-8");
                }
                if (estado.toString().equals(item)) {
                    options = options + " selected ";
                }
                options = options + ">" + estado + "</option>";
            }
            return options;

        } finally {
            qexec.close();
        }

    }

    // </editor-fold>
}
