<%-- 
    Document   : index
    Created on : 19/07/2017, 09:58:19
    Author     : edson
--%>

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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Unidades Básicas de Saúde</title>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!--
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>-->

    </head>
    <body>

        <%
            sparql s1 = new sparql();
            
            
            %>
        
            <%=
                s1.getComboListEstado1("")
                %>
        <br><br><br><br>
<!--
        <div class="container">    
            <div style="width: 300px"> 
                <div > 
                    <div > 
                        <h3>Unidade de Saúde xxx</h3> 
                    </div> 
                    <div class="row"> 
                        <div >  
                            <table class="table table-user-information"> 
                                <tbody> 
                                    <tr> 
                                        <td><span class="glyphicon glyphicon-earphone"></span> Telefone</td> 
                                        <td>@telefone</td> 
                                    </tr>
                                    <tr> 
                                        <td><span class="glyphicon glyphicon-map-marker"></span> Endereço</td> 
                                        <td>@endereco, @bairro , @cidade - @estado</td> 
                                    </tr>
                                    <tr> 
                                        <td><span class="glyphicon glyphicon-info-sign"></span> Lista de Especialidades</td> 
                                        <td>@especialidades</td> 
                                    </tr> 
                                    <tr> 
                                        <td colspan="2"><span class="glyphicon glyphicon-thumbs-up"></span> Avaliação Governo</td> 
                                    </tr> 
                                    <tr>
                                        <td colspan="2">
                                            <div class="container-fluid">
                                                <table style="width: 100%">
                                                    <tr><td><h5>Estrutura física:</h5></td><td>@rate1</td></tr>
                                                    <tr><td><h5>Adap. p/ idosos:</h5></td><td>@rate2</td></tr>
                                                    <tr><td><h5>Equipamentos:</h5></td><td>@rate3</td></tr>
                                                    <tr><td><h5>Medicamentos</h5></td><td>@rate4</td></tr>
                                                </table>
                                            </div>
                                        </td> 
                                    </tr>
                                </tbody> 
                            </table> 
                        </div> 
                    </div> 
                    <div style="text-align: right;display: none"><a data-original-title="Broadcast Message" data-toggle="tooltip" type="button" class="btn btn-sm btn-primary">Gravar</a></div> 
                    <span class="pull-right"> 
                    </span> 
                </div> 
            </div> 
        </div>
-->




        <!--Barra de navegação-->
        <nav id="myNavbar" class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbarCollapse">
                        <span class="sr-only">Unidades Básicas de Saúde</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">go-to-doc.com</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
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

        <div class="container">

            <!--            Consulta    
                        <div class="row" >
                            <div class="col-md-4 pull-right">
                                <div id="custom-search-input " >
                                    <div class="input-group col-md-12">
                                        <input type="text" class="form-control input-lg" placeholder="Buscar" />
                                        <span class="input-group-btn">
                                            <button class="btn btn-success btn-lg" type="button">
                                                <i class="glyphicon glyphicon-search"></i>
                                            </button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>-->

            <br>

            <!--Apresnetação site-->
            <div class="jumbotron">
                <h1>go-to-doc.com</h1>
                <p>Através deste website é possível localizar as unidades básicas de saúde ativas em sua região realizando consultas baseadas na localização, especialidade ou recomendação. As unidades básicas de saúde podem ser avaliadas permitindo que entidades governamentais tenham conhecimento acerca da opinião da população em relação ao serviço prestado.</p>
                <p><a href="panelsearch.jsp" class="btn btn-success btn-lg">Localizar Unidades!</a></p>
            </div>

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
    </body>
</html>     