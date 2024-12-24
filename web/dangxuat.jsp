<%-- 
    Document   : dangxuat.jsp
    Created on : Dec 13, 2024, 9:00:03?AM
    Author     : Nguyen Duc Len
--%>

<%@page import="javax.servlet.http.HttpSession"%>
<%
    String username = null; // Kh?i t?o bi?n username
    String fullname = null; // Kh?i t?o bi?n fullname

    if (session != null) { // `session` ?� c� s?n, kh�ng c?n khai b�o l?i
        // L?y th�ng tin t? session
        username = (String) session.getAttribute("username");
        fullname = (String) session.getAttribute("fullname");
    }
%>
<%
    if (session != null) {
        session.invalidate(); // H?y session
    }
    response.sendRedirect("dangnhap.jsp"); // Chuy?n v? trang ??ng nh?p
%>

