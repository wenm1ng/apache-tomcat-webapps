<%@page import="org.jasig.cas.authentication.principal.WebApplicationService" %>
<%@page import="org.jasig.cas.web.support.WebUtils" %>
<%@page import="java.net.URL" %>
<%
WebApplicationService service = (WebApplicationService) request.getAttribute("service");
String ticket  = (String) request.getAttribute("serviceTicketId");
String redirectURL = service.getResponse(ticket).getUrl();
boolean serverSideRedirect = false;
// if redirect is for an image, js or css file
URL url = new URL(redirectURL);
String path = url.getPath();
int dotPos = path.lastIndexOf("."); // returns -1 if not found
if( dotPos != -1 )
{
    String ext = path.substring(dotPos).toLowerCase();
    serverSideRedirect = ".gif".equals(ext) || ".jpg".equals(ext) || ".png".equals(ext) || ".js".equals(ext) || ".css".equals(ext);
}
if( serverSideRedirect )
{
    // Serverside redirect using HTTP 302
    response.sendRedirect("https://www.baidu.com");
}
else
{
    // Client side redirect using javascript
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
  <head>
    <script type="text/javascript" language="javascript">
      // <%=redirectURL%>
        window.location.replace ("https://www.baidu.com");

    </script>
    <title>Redirect</title>
  </head>
  <body></body>
</html>
<%
}
%>