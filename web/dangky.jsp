<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký</title>
        <style>
            /* Reset CSS */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(to bottom, #6a11cb, #2575fc);
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
                text-align: center;
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
            input[type="email"],
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
            input[type="email"]:focus,
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
            <h1>Đăng Ký</h1>
            <p>Hãy điền thông tin của bạn để tạo tài khoản mới.</p>

            <!-- Hiển thị thông báo lỗi hoặc thành công -->
            <% if (request.getAttribute("errorMessageRegister") != null) {%>
            <p class="error"><%= request.getAttribute("errorMessageRegister") %></p>
            <% } %>
            <% if (request.getAttribute("successMessageRegister") != null) {%>
            <p class="success"><%= request.getAttribute("successMessageRegister") %></p>
            <% } %>

            <form action="DANGKY" method="post">
                <input type="text" name="txtHOTEN" placeholder="Họ tên" required />
                <input type="text" name="txtNGAYSINH" placeholder="Ngày sinh" required />
                <input type="text" name="txtGIOITINH" placeholder="Giới tính" required />
                <input type="email" name="txtEMAIL" placeholder="Email" required />
                <input type="text" name="txtTAIKHOAN" placeholder="Tên tài khoản" required />
                <input type="password" name="txtMATKHAU" placeholder="Mật khẩu" required />
                <button type="submit">Đăng ký</button>
            </form>

            <div class="form-footer">
                <p>Đã có tài khoản? <a href="dangnhap.jsp">Đăng nhập ngay</a></p>
            </div>
        </div>
    </body>
</html>
