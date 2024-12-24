<%@page import="java.util.Map"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sửa sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                color: #333;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background-color: #fff;
                padding: 20px 30px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                width: 100%;
            }

            h1 {
                text-align: center;
                font-size: 24px;
                color: #444;
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-size: 14px;
                font-weight: bold;
                margin-bottom: 5px;
                color: #555;
            }

            input[type="text"],
            input[type="number"],
            input[type="file"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                background-color: #f9f9f9;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            input[type="file"]:focus {
                border-color: #007bff;
                outline: none;
                background-color: #fff;
            }

            button {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                color: #fff;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #0056b3;
            }

            .error {
                color: #e74c3c;
                font-weight: bold;
                margin-bottom: 15px;
                text-align: center;
            }

            .success {
                color: #2ecc71;
                font-weight: bold;
                margin-bottom: 15px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <%
            // Kiểm tra phiên làm việc (session) và quyền truy cập
            if (session == null || !"admin".equals(session.getAttribute("ROLE"))) {
                // Nếu không có quyền admin, chuyển hướng về trang đăng nhập
                response.sendRedirect("dangnhap.jsp");
                return;
            }

            // Lấy đối tượng product từ request
            Map<String, Object> product = (Map<String, Object>) request.getAttribute("product");
            if (product == null) {
        %>
            <div class="container">
                <div class="error">Không tìm thấy sản phẩm để chỉnh sửa.</div>
            </div>
        <%
                return;
            }
        %>

        <div class="container">
            <h1>Sửa thông tin sản phẩm</h1>
            <form action="AdminServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="id" value="<%= product.get("MASANPHAM") %>" />

                <label for="TENSANPHAM">Tên sản phẩm:</label>
                <input type="text" id="TENSANPHAM" name="TENSANPHAM" value="<%= product.get("TENSANPHAM") %>" required />

                <label for="DONGIA">Đơn giá:</label>
                <input type="number" id="DONGIA" name="DONGIA" value="<%= product.get("DONGIA") %>" required />

                <label for="SOLUONG">Số lượng:</label>
                <input type="number" id="SOLUONG" name="SOLUONG" value="<%= product.get("SOLUONG") %>" required />

                <label for="HINHANH">Hình ảnh:</label>
                <input type="file" id="HINHANH" name="HINHANH" />

                <button type="submit">Cập nhật</button>
            </form>
        </div>
    </body>
</html>
