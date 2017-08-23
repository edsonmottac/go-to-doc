package omg.gotodoc.data;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

@WebServlet(name = "rdfdata", urlPatterns = {"/rdfdata"})
public class rdfdata extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);

        String txt = request.getParameter("txtBuscar");
        
        FileManager.get().addLocatorClassLoader(rdfdata.class.getClassLoader());
        Model model = FileManager.get().loadModel("d:/data.rdf");
        
        //String querystring = "SELECT ?name WHERE { ?name rdf:type dbo:Plant} LIMIT 100";
        String queryString = 
        " PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
        " PREFIX foaf: <http://xmlns.com/foaf/0.1/>" +
        " SELECT * WHERE { " +
        " ?person foaf:name ?x ." +
        "}";
        
        Query query = QueryFactory.create(queryString);
        QueryExecution qexec = QueryExecutionFactory.create(query, model);
        
        //Model model2 = qexec.execConstruct();
        //model2.write(System.out, "RDF/XML");
        
        try {
            
            ResultSet results = qexec.execSelect();
            
            request.setAttribute("ResultSet", results);
            request.getRequestDispatcher("panelsearch.jsp").forward(request, response);
            
            while (results.hasNext() ) {
                 QuerySolution soln = results.nextSolution();
                 Literal name = soln.getLiteral("x");
                 PrintWriter out =response.getWriter();
                 out.println(name+"<br/>");
                 out.println("<br/>");
                 out.println("<br/>");                 
            }
            
        } finally {
            qexec.close();
        }


    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
