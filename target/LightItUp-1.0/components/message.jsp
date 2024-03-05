<%-- 
    Document   : message
    Created on : 4 Feb 2024, 21:25:00
    Author     : Dell
--%>
<% 
  String message = (String)session.getAttribute("message");
  if(message != null){
    out.print("<style>.message-container{padding-left: 12px;padding-top: 50px;z-index: 1;position:relative;}  .close-message-button {    position: absolute;    top: 50px;    right: 10px;    cursor: pointer;  }  .grid-container-admin {    margin-top: 10px !important;  }  @media (max-width: 800px) {    .message-container{      height: 30px;      width: min-content;    }  }</style>");
    out.print("<script>message_p = 'message-container';function closeMPopup(popup) {document.getElementsByClassName(popup).style.display = 'none';");
    session.removeAttribute("message");
    out.print("}</script>");
    out.print("<div class='message-container'>");
    //print message
    out.println(message);
    out.print("<div class='close-message-button' onclick='closeMPopup(message_p)'>X</div>");
    out.print("</div>");
    //remove the message from session so that it is rendered only once
    session.removeAttribute("message");
  }
%>


