<%-- 
    Document   : dangnhap
    Created on : Dec 13, 2024, 8:18:35 AM
    Author     : Nguyen Duc Len
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng Nhập</title>
        <style>
            /* Reset CSS */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(to right, #2575fc, #6a11cb);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                color: #fff;
            }

            .form-container {
                background: #ffffff;
                color: #333;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                max-width: 400px;
                width: 100%;
                text-align: center;
            }

            .form-container h1 {
                font-size: 28px;
                font-weight: bold;
                text-align: center;
                margin-bottom: 20px;
                color: #444;
            }

            .form-container p {
                margin-bottom: 20px;
                font-size: 14px;
                color: #555;
            }

            .error {
                color: #e74c3c;
                font-weight: bold;
                margin-bottom: 10px;
                padding: 10px;
                background-color: #fce4e4;
                border: 1px solid #f5c6c6;
                border-radius: 5px;
                text-align: center;
            }

            .success {
                color: #2ecc71;
                font-weight: bold;
                margin-bottom: 10px;
                padding: 10px;
                background-color: #eafaf1;
                border: 1px solid #d4f2e0;
                border-radius: 5px;
                text-align: center;
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 12px;
                font-size: 14px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background: #f9f9f9;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                border-color: #2575fc;
                outline: none;
            }

            button {
                padding: 12px;
                background: linear-gradient(to right, #6a11cb, #2575fc);
                color: #fff;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            button:hover {
                background: linear-gradient(to right, #2575fc, #6a11cb);
            }

            .form-footer {
                text-align: center;
                margin-top: 20px;
            }

            .form-footer a {
                text-decoration: none;
                color: #6a11cb;
                font-weight: bold;
            }

            .form-footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h1>Đăng Nhập</h1>
            <p>Nhập thông tin tài khoản của bạn để tiếp tục.</p>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <% if (request.getAttribute("errorMessageLogin") != null) {%>
            <p class="error"><%= request.getAttribute("errorMessageLogin") %></p>
            <% } %>

            <form action="DANGNHAP" method="post">
                <input type="text" name="txtTAIKHOAN_LOGIN" placeholder="Tên tài khoản" required />
                <input type="password" name="txtMATKHAU_LOGIN" placeholder="Mật khẩu" required />
                <button type="submit">Đăng nhập</button>
            </form>
            
            <div class="form-footer">
                <p>Chưa có tài khoản? <a href="dangky.jsp">Đăng ký ngay</a></p>
            </div>
        </div>
    </body>
</html>

