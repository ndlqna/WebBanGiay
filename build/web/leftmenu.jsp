<%-- 
    Document   : leftmenu
    Created on : Dec 12, 2024, 10:52:37 PM
    Author     : Nguyen Duc Len
--%>
<%@ page import="PROCESSDATA.XULYDULIEU" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<ul class="left_menu">
                        <%
                            XULYDULIEU xuly = new XULYDULIEU();
                            String selectedCategory = request.getParameter("category");
                            try {
                                String sql = "SELECT * FROM tbDANHMUC";
                                ResultSet rs = xuly.getResultSet(sql);
                                while (rs.next()) {
                                    String maDanhMuc = rs.getString("MADANHMUC");
                                    String tenDanhMuc = rs.getString("TENDANHMUC");
                        %>
                        <li class="even">
                            <a href="HOME.jsp?category=<%= maDanhMuc%>" class="<%= (selectedCategory != null && selectedCategory.equals(maDanhMuc)) ? "active" : ""%>">
                                <%= tenDanhMuc%>
                            </a>
                        </li>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </ul>

