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
            .edit-link {
                text-decoration: none;
                padding: 5px 10px;
                border: 2px solid blue;
                border-radius: 5px;
                color: blue;
                transition: all 0.3s ease;
            }

            .edit-link:hover {
                background-color: blue;
                color: white;
            }

            .delete-link {
                text-decoration: none;
                padding: 5px 10px;
                border: 2px solid red;
                border-radius: 5px;
                color: red;
                transition: all 0.3s ease;
            }

            .delete-link:hover {
                background-color: red;
                color: white;
            }

            .pagination a, .pagination strong {
                text-decoration: none;
                text-align: center;
                color: #007bff;
                padding: 10px 15px;
                margin: 0 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
                min-width: 40px; /* Đảm bảo các nút có cùng chiều rộng */
                display: inline-block;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background-color: #007bff;
                color: #fff;
            }

            .pagination strong {
                background-color: #007bff;
                color: #fff;
            }

            .back-to-home {
                display: inline-block;
                margin-bottom: 20px;
                padding: 10px 20px;
                font-size: 16px;
                background-color: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .back-to-home:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Quản lý sản phẩm</h1>

            <!-- Tìm kiếm sản phẩm -->
            <form method="get" action="admin.jsp">
                <input type="number" name="MASANPHAM" placeholder="Nhập mã sản phẩm" value="<%= request.getParameter("MASANPHAM")%>" />
                <button type="submit">Tìm kiếm</button>
                <a href="admin.jsp"><button type="button">Xóa tìm kiếm</button></a>
            </form>

            <!-- Bảng danh sách sản phẩm -->
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

                        // Lấy thông tin phân trang từ request
                        int currentPage = 1; // Trang mặc định
                        int productsPerPage = 10; // Số sản phẩm mỗi trang

                        String pageParam = request.getParameter("page");
                        if (pageParam != null && !pageParam.isEmpty()) {
                            currentPage = Integer.parseInt(pageParam);
                        }

                        int offset = (currentPage - 1) * productsPerPage;

                        // Lấy giá trị MASANPHAM từ request
                        String searchMASANPHAM = request.getParameter("MASANPHAM");
                        String sql = "SELECT * FROM tbSANPHAM";
                        if (searchMASANPHAM != null && !searchMASANPHAM.trim().isEmpty()) {
                            sql += " WHERE MASANPHAM = ? ORDER BY MASANPHAM OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                        } else {
                            sql += " ORDER BY MASANPHAM OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                        }

                        // Chuẩn bị câu lệnh truy vấn
                        PreparedStatement ps = xuly.getPreparedStatement(sql);
                        if (searchMASANPHAM != null && !searchMASANPHAM.trim().isEmpty()) {
                            ps.setInt(1, Integer.parseInt(searchMASANPHAM));
                            ps.setInt(2, offset);
                            ps.setInt(3, productsPerPage);
                        } else {
                            ps.setInt(1, offset);
                            ps.setInt(2, productsPerPage);
                        }
                        ResultSet rs = ps.executeQuery();

                        // Hiển thị danh sách sản phẩm
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("MASANPHAM")%></td>
                        <td><%= rs.getString("TENSANPHAM")%></td>
                        <td><%= rs.getInt("DONGIA")%> VNĐ</td>
                        <td><%= rs.getInt("SOLUONG")%></td>
                        <td><img src="images/<%= rs.getString("HINHANH")%>" alt="Ảnh sản phẩm" width="50" /></td>
                        <td>
                            <a href="AdminServlet?action=edit&id=<%= rs.getInt("MASANPHAM")%>" class="edit-link">Sửa</a> |
                            <a href="AdminServlet?action=delete&id=<%= rs.getInt("MASANPHAM")%>" class="delete-link" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <!-- Hiển thị phân trang -->
            <%
                // Tính tổng số trang
                String countSql = "SELECT COUNT(*) AS total FROM tbSANPHAM";
                PreparedStatement countPs = xuly.getPreparedStatement(countSql);
                ResultSet countRs = countPs.executeQuery();
                countRs.next();
                int totalProducts = countRs.getInt("total");
                int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
            %>

            <div class="pagination">
                <p>Trang <%= currentPage%> / <%= totalPages%></p>
                <%
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                %>
                <strong><%= i%></strong>
                <%
                } else {
                %>
                <a href="admin.jsp?page=<%= i%>"><%= i%></a>
                <%
                        }
                    }
                %>
            </div>

            <!-- Form thêm sản phẩm -->
            <h2>Thêm sản phẩm mới</h2>
            <form action="AdminServlet" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
                <input type="hidden" name="action" value="add" />
                <input type="text" name="TENSANPHAM" placeholder="Tên sản phẩm" required />
                <input type="number" name="DONGIA" placeholder="Giá sản phẩm" required />
                <input type="number" name="SOLUONG" placeholder="Số lượng" required />
                <input type="file" name="HINHANH" required />
                <button type="submit">Thêm</button>
            </form>
            <a href="HOME.jsp" class="back-to-home">Quay Về Trang Chủ</a>
        </div>
    </body>
</html>
