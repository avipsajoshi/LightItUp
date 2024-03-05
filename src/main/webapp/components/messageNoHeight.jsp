<%-- 
    Document   : messageNoHeight
    Created on : 9 Feb 2024, 15:53:50
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