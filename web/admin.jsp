<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="PROCESSDATA.XULYDULIEU" %>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    String role = (session != null) ? (String) session.getAttribute("ROLE") : null;
    if (session == null || !"admin".equals(role)) {
        out.print("ROLE hiện tại: " + role); // Debug giá trị ROLE
        response.sendRedirect("dangnhap.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - Quản lý sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                padding: 20px;
            }
            .container {
                max-width: 900px;
                margin: 0 auto;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            table th, table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            table th {
                background-color: #f4f4f4;
            }
            form input, form button {
                padding: 10px;
                margin: 5px 0;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            button {
                cursor: pointer;
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
            }
            button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Quản lý sản phẩm</h1>
            <table>
                <thead>
                    <tr>
                        <th>Mã sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Hình ảnh</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        PROCESSDATA.XULYDULIEU xuly = new PROCESSDATA.XULYDULIEU();
                        String sql = "SELECT * FROM tbSANPHAM";
                        ResultSet rs = xuly.getResultSet(sql);
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("MASANPHAM") %></td>
                        <td><%= rs.getString("TENSANPHAM") %></td>
                        <td><%= rs.getInt("DONGIA") %> VNĐ</td>
                        <td><%= rs.getInt("SOLUONG") %></td>
                        <td><img src="images/<%= rs.getString("HINHANH") %>" alt="Ảnh sản phẩm" width="50" /></td>
                        <td>
                            <a href="AdminServlet?action=edit&id=<%= rs.getInt("MASANPHAM") %>">Sửa</a> |
                            <a href="AdminServlet?action=delete&id=<%= rs.getInt("MASANPHAM") %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <h2>Thêm sản phẩm mới</h2>
            <form action="AdminServlet" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
                <input type="hidden" name="action" value="add" />
                <input type="text" name="TENSANPHAM" placeholder="Tên sản phẩm" required />
                <input type="number" name="DONGIA" placeholder="Giá sản phẩm" required />
                <input type="number" name="SOLUONG" placeholder="Số lượng" required />
                <input type="file" name="HINHANH" required />
                <button type="submit">Thêm</button>
            </form>
        </div>
    </body>
</html>
