<%-- 
    Document   : panelsearch
    Created on : 19/07/2017, 11:48:13
    Author     : edson
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="omg.gotodoc.data.sparql"%>

<%@page import="org.apache.jena.query.Query"%>
<%@page import="org.apache.jena.query.QueryExecution"%>
<%@page import="org.apache.jena.query.QueryExecutionFactory"%>
<%@page import="org.apache.jena.query.QueryFactory"%>
<%@page import="org.apache.jena.query.QuerySolution"%>
<%@page import="org.apache.jena.query.ResultSet"%>
<%@page import="org.apache.jena.rdf.model.Literal"%>
<%@page import="org.apache.jena.rdf.model.Model"%>
<%@page import="org.apache.jena.rdf.model.RDFNode"%>
<%@page import="org.apache.jena.rdf.model.Resource"%>
<%@page import="org.apache.jena.util.FileManager"%>

<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="org.apache.jena.query.ResultSetFormatter"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Unidades Básicas de Saúde</title>

        <link rel="stylesheet" href="css/navbar.css">
        <link rel="stylesheet" href="css/listbox.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="js/infobox.js"></script>
        <script src="js/funcoes.js"></script>
        <script src="js/rating.js"></script>

        <script>
            $(document).ready(function () {
                $('[data-toggle="popover"]').popover();
            });
            
            $(document)
                .on( 'click', '.dropdown-menu', function (e){
                    e.stopPropagation();
            });
            
            function validateForm() {
                if ((document.forms["frmfilter"]["CmbRegiao"].value === "") && (document.forms["frmfilter"]["CmbCidade"].value === "") && (document.forms["frmfilter"]["CmbEstado"].value ===""))
                 {
                    var resp = confirm("Atenção,\nNenhuma cidade ou região foi filtrada no mapa. Esta oepração operação poderá levar alguns minutos.\n\nDeseja continuar?");
                    if (resp == true) {return true;} else {return false;}
                }
                return true;
            }
            
        </script>
        
    </head>
    <body>

        <%
            //sparql s = new sparql();
            //ResultSet results = s.getPointsByCity("Salvador");
            //while (results.hasNext()) {
            //    QuerySolution soln = results.nextSolution();
            //    RDFNode nome = soln.get("nome");
             //}
            
//            String json="";
//            ByteArrayOutputStream outputStream=null;

//                    sparql s = new sparql();
//                    ResultSet results = s.getPointsByCity("Salvador");
//                    CustomQueryService ws = new CustomQueryService();
//                    String chamada="http://localhost:8080/go-to-doc/CustomQueryService";
//                    chamada=ws.hello("Edson");
//                    while (results.hasNext()) {
//                        QuerySolution soln = results.nextSolution();
//                        RDFNode nome = soln.get("nome");
//                        RDFNode cidade = soln.get("cidade");
//                        RDFNode latitude = soln.get("lat");
//                        RDFNode longitude = soln.get("lng");
//                        outputStream = new ByteArrayOutputStream();
//                        ResultSetFormatter.outputAsJSON(outputStream, results);
//                        json = new String(outputStream.toByteArray());
            //}
            //   s.qexec.close();

         sparql s = new sparql();
         ResultSet results;
        %>

        <!--Barra de navegação topo-->
        <nav id="myNavbar" class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbarCollapse">
                        <span class="sr-only">Unidades de Saúde</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../go-to-doc">go-to-doc.com</a>
                </div>
                <div class="collapse navbar-collapse" id="navbarCollapse" >
                    <ul class="nav navbar-nav" style="display:none" > 
                        <li class="active"><a href="https://www.tutorialrepublic.com" target="_blank">Home</a></li>
                        <li><a href="https://www.tutorialrepublic.com/about-us.php" target="_blank">About</a></li>
                        <li><a href="https://www.tutorialrepublic.com/contact-us.php" target="_blank">Contact</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <br><br><br><br>

         <!--NavBar-->
        <div class="container">
            <div class="row" >
                <nav class="navbar navbar-default">
                    <div class="container">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-3">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="#">Unidades de Saúde</a>
                        </div>
                        
                        <div class="collapse navbar-collapse" id="navbar-collapse-3">
                            <ul class="nav navbar-nav navbar-right">
                                <li>
                                    <form name="frmfilter" action="panelsearch.jsp" method="GET" class="navbar-form" role="search" onsubmit="return validateForm();">
                                        
                                        <%//Tipo%>
                                        <div class="form-group">
                                            <select name="CmbTipo" id="CmbTipo" class="form-control" style="width:80px">
                                                <option value="">Tipo</option>
                                                <option value="UBS">USB - Unidades Básicas de Saúde</option>
                                                <option value="ESP">GRL - Todas as Unidades de Saúde</option>
                                                
                                            </select>
                                        </div>
                                            
                                        <%//Região%>
                                        <div class="form-group">
                                            <select name="CmbRegiao" id="CmbRegiao" class="form-control" style="width:100px">
                                                <option value="">Região</option>
                                                <%=s.getComboListRegion(request.getParameter("CmbRegiao"))%>
                                            </select>
                                        </div>
                                            
                                        <%//UF%>
                                        <div class="form-group">
                                            <select name="CmbEstado" id="CmbEstado" class="form-control" style="width:80px">
                                                <option value="">UF</option>
                                                <%= s.getComboListEstado(request.getParameter("CmbEstado"))%>
                                            </select>
                                        </div>
                                            
                                        <%//Cidade%>
                                        <div class="form-group">
                                            <select name="CmbCidade" id="CmbCidade" class="form-control" style="width:150px">
                                                <option value="">Cidade</option>
                                                <%= s.getComboListCity(request.getParameter("CmbCidade"))%>
                                            </select>
                                        </div>

                                        <%//Especialidades%>
                                        <div class="form-group">
                                            <select name="CmbEspecialidade" id="CmbEspecialidade" class="form-control" style="width:150px">
                                                <option value="">Espacialidade</option>
                                                <%=s.getComboListSpecialization(request.getParameter("CmbEspecialidade"))%>
                                            </select>
                                        </div>

                                        <%//Avaliação%>
                                        <div class="form-group">
                                            <li class="dropdown" >
                                                <a href="#" class="form-control" data-toggle="dropdown" style="text-decoration:none!important">Avaliação &nbsp&nbsp <span class="glyphicon glyphicon-star-empty pull-right" style="padding-top:2px;"></span></a>
                                                <ul class="dropdown-menu mega-dropdown-menu row panel-footer" >
                                                    <li>
                                                        <section>
                                                            <div class="container-fluid" style="width: 300px">
                                                                <div>
                                                                    <h5>1. Estrutura física e ambiência</h5>
                                                                    
                                                                    <div>
                                                                        <select name="rate1" id="rate1" class="form-control" style="width:200px">
                                                                            <option value="">Sem filtro</option>
                                                                            <option value=5 <%= (request.getParameter("rate1") != null && request.getParameter("rate1").equals("5") ? "selected" : "") %>  >Muito acima da média</option>
                                                                            <option value=4 <%= (request.getParameter("rate1") != null && request.getParameter("rate1").equals("4") ? "selected" : "") %>  >Acima da média</option>
                                                                            <option value=3 <%= (request.getParameter("rate1") != null && request.getParameter("rate1").equals("3") ? "selected" : "") %> >Mantém a média</option>
                                                                            <option value=2 <%= (request.getParameter("rate1") != null && request.getParameter("rate1").equals("2") ? "selected" : "") %> >Abaixo da média</option>
                                                                            <option value=1 <%= (request.getParameter("rate1") != null && request.getParameter("rate1").equals("1") ? "selected" : "") %> >Muito abaixo da média</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class='divider' ></div>
                                                                    <h5>2. Adapt. para deficientes físicos e idosos</h5>
                                                                    <div>
                                                                        <select name="rate2" id="rate2" class="form-control" style="width:200px">
                                                                            <option value="">Sem filtro</option>
                                                                            <option value=5 <%= (request.getParameter("rate2") != null && request.getParameter("rate2").equals("5") ? "selected" : "") %>  >Muito acima da média</option>
                                                                            <option value=4 <%= (request.getParameter("rate2") != null && request.getParameter("rate2").equals("4") ? "selected" : "") %>  >Acima da média</option>
                                                                            <option value=3 <%= (request.getParameter("rate2") != null && request.getParameter("rate2").equals("3") ? "selected" : "") %> >Mantém a média</option>
                                                                            <option value=2 <%= (request.getParameter("rate2") != null && request.getParameter("rate2").equals("2") ? "selected" : "") %> >Abaixo da média</option>
                                                                            <option value=1 <%= (request.getParameter("rate2") != null && request.getParameter("rate2").equals("1") ? "selected" : "") %> >Muito abaixo da média</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class='divider' ></div>
                                                                    <h5>4. Equipamentos</h5>
                                                                    <div>
                                                                        <select name="rate3" id="rate3" class="form-control" style="width:200px">
                                                                            <option value="">Sem filtro</option>
                                                                            <option value=5 <%= (request.getParameter("rate3") != null && request.getParameter("rate3").equals("5") ? "selected" : "") %>  >Muito acima da média</option>
                                                                            <option value=4 <%= (request.getParameter("rate3") != null && request.getParameter("rate3").equals("4") ? "selected" : "") %>  >Acima da média</option>
                                                                            <option value=3 <%= (request.getParameter("rate3") != null && request.getParameter("rate3").equals("3") ? "selected" : "") %> >Mantém a média</option>
                                                                            <option value=2 <%= (request.getParameter("rate3") != null && request.getParameter("rate3").equals("2") ? "selected" : "") %> >Abaixo da média</option>
                                                                            <option value=1 <%= (request.getParameter("rate3") != null && request.getParameter("rate3").equals("1") ? "selected" : "") %> >Muito abaixo da média</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class='divider' ></div>
                                                                    <h5>5. Medicamentos</h5>
                                                                    <div>
                                                                        <select name="rate4" id="rate4" class="form-control" style="width:200px">
                                                                            <option value="">Sem filtro</option>
                                                                            <option value=5 <%= (request.getParameter("rate4") != null && request.getParameter("rate4").equals("5") ? "selected" : "") %>  >Muito acima da média</option>
                                                                            <option value=4 <%= (request.getParameter("rate4") != null && request.getParameter("rate4").equals("4") ? "selected" : "") %>  >Acima da média</option>
                                                                            <option value=3 <%= (request.getParameter("rate4") != null && request.getParameter("rate4").equals("3") ? "selected" : "") %> >Mantém a média</option>
                                                                            <option value=2 <%= (request.getParameter("rate4") != null && request.getParameter("rate4").equals("2") ? "selected" : "") %> >Abaixo da média</option>
                                                                            <option value=1 <%= (request.getParameter("rate4") != null && request.getParameter("rate4").equals("1") ? "selected" : "") %> >Muito abaixo da média</option>
                                                                        </select>
                                                                    </div>
                                                                    <br>
                                                                </div>
                                                        </section>
                                                    </li>
                                                    
                                                </ul>
                                        </div>  
                                   
                                        
                                        <%//Botão Filtrar%>
                                        <button type="submit" name="btnsearch" id="btn-filter-pending" class="btn btn-default" style="z-index: 1">Filtrar!</button>
                                    </form>
                                </li>
                                <%//Botão Pesqusiar no Mapa%>
                                <li style="padding-top: 7px">
                                    <a class="btn btn-default btn-outline btn-circle collapsed"  data-toggle="collapse" href="#nav-collapse3" aria-expanded="false" aria-controls="nav-collapse3" >Pesquisar local</a>
                                </li>
                            </ul>
                            <%//Pesqusiar no Mapa%>
                            <div class="collapse nav navbar-nav nav-collapse slide-down " id="nav-collapse3" style="width:95%;padding-top: 8px; text-align: right">
                                <form class="navbar-form navbar-right" role="search">
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Pesqusiar no mapa" style="width:300px" />
                                    </div>
                                    <button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                                </form>
                        </div>
                    </div>
                </nav>
            </div>
        </div>

        <!--Mapa-->
        <div class="container-fluid">



            <%//legenda%>
            <div class="collapse navbar-collapse" id="navbar-collapse-3">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <div class="form-group">
                            <li class="dropdown" >
                                <a href="#" data-toggle="dropdown" style="text-decoration:none!important"><span class="glyphicon glyphicon-info-sign" style="padding-top:2px;"></span>&nbsp; Legenda</a>
                                <ul class="dropdown-menu mega-dropdown-menu row panel-footer" >
                                    <li>
                                        <section>
                                            <div class="container-fluid" style="width: 300px">
                                                <div>
                                                    <div ><img src="img/5.png" width="25" height="25" alt="Muito acima da média">Muito acima da média</div>
                                                    <div  ><img src="img/4.png" width="25" height="25" alt="Acima da média">Acima da média</div>
                                                    <div ><img src="img/3.png" width="25" height="25" alt="Mantém a média">Mantém a média</div>
                                                    <div ><img src="img/2.png" width="25" height="25" alt="">Abaixo da média</div>
                                                    <div ><img src="img/1.png" width="25" height="25" alt="Muito abaixo da média">Muito abaixo da média</div>
                                                    <div class='divider' ></div>
                                                    <br>
                                                </div>
                                        </section>
                                    </li>

                                </ul>
                            </li>
                        </div>
                    </li>
                </ul>
            </div>

            
            <div class="jumbotron" id="mapa" style="height: 600px;">
                <!-- Maps API Javascript -->
                <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBIAzX0ibNQJn2XZGX6NhZnk1QDurMnBI4&amp;sensor=false"></script>

                <!-- Arquivo de inicialização do mapa -->
                <script src="js/mapa.js"></script>
                <%
                    //System.out.println("valor combo: "  + request.getParameter("CmbCidade")) ;
                    
                    results = s.getPointsByCity(request.getParameter("CmbRegiao"),
                                                request.getParameter("CmbCidade"),
                                                request.getParameter("CmbEstado"),
                                                request.getParameter("CmbEspecialidade"),
                                                request.getParameter("rate1"),
                                                request.getParameter("rate2"),
                                                request.getParameter("rate3"),
                                                request.getParameter("rate4"),
                                                request.getParameter("CmbTipo")
                                                );
                    ByteArrayOutputStream os = new ByteArrayOutputStream();
                    ResultSetFormatter.outputAsJSON(os, results);
                    String json = new String(os.toByteArray());
                    s.qexec.close();
                %>
                 <%//=json%>
                 <script >initialize();carregarPontos(<%=json%>)</script>
                
            </div>
        </div>

                 

        <!-- Informações Gerais -->
        <div class="container" style="display: normal">
            <!--Informações gerais e outras opções-->
            <div class="row" >

                <div class="col-sm-12 col-md-6 col-lg-3">
                    <h2>Data.gov</h2>
                    <p>Trata-se da plataforma de <b>dados abertos do governo</b>. Permite ter acesso a um amplo conteúdo publicados por diversas esferas governamentais. Os dados apresentados neste sistema são derivados deste mesmo ambiente</p>
                    <p><a href="https://www.tutorialrepublic.com/html-tutorial/" target="_blank" class="btn btn-success">Ver mais...</a></p>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <h2>UBS</h2>
                    <p>As <b>Unidades Básicas de Saúde (UBS)</b> são a porta de entrada preferencial do Sistema Único de Saúde (SUS). O objetivo desses postos é atender até 80% dos problemas de saúde da população, sem que haja a necessidade de encaminhamento para hospitais.</p>
                    <p><a href="https://www.tutorialrepublic.com/css-tutorial/" target="_blank" class="btn btn-success">Ver mais...</a></p>
                </div>
                <div class="clearfix visible-sm-block"></div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <h2>CNES</h2>
                    <p>Localização dos estabelecimentos registrados no <b>Cadastro Nacional de Estabelecimentos de Saúde</b>. Sobre o CNES, ver: http://cnes.datasus.gov.br/</p>
                    <p><a href="https://www.tutorialrepublic.com/html-tutorial/" target="_blank" class="btn btn-success">Ver mais...</a></p>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <h2>CREAS</h2>
                    <p>O <b>Centro de Referência Especializado de Assistência Social (Creas)</b> configura-se como uma unidade pública e estatal, que oferta serviços especializados e continuados a famílias e indivíduos em situação de ameaça ou violação de direitos.</p>
                    <p><a href="https://www.tutorialrepublic.com/css-tutorial/" target="_blank" class="btn btn-success">Ver mais...</a></p>
                </div>



            </div>
            <hr>
            <!--Licença e direitos-->
            <div class="row">
                <div class="col-sm-12">
                    <footer>
                        <p>DCC - UFBA</p>
                    </footer>
                </div>
            </div>
        </div>

        <!-- Área de testes -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Modal Header</h4>
                    </div>
                    <div class="modal-body">
                        <p>Some text in the modal.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>

      
    </body>
</html>     