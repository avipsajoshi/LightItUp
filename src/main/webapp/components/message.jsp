<%-- 
    Document   : message
    Created on : 4 Feb 2024, 21:25:00
    Author     : Dell
--%>
<% 
  String message = (String)session.getAttribute("message");
  if(message != null){
    //print message
    out.println(message);
    //remove the message from session so that it is rendered only once
    session.removeAttribute("message");
  }
  
%>