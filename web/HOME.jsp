<%@ page import="PROCESSDATA.XULYDULIEU" %>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Giày Tốt Store</title>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
        <link rel="stylesheet" type="text/css" href="style.css" />
        <!-- For Internet Explorer 6-->
        <!--[if IE 6]>
        <link rel="stylesheet" type="text/css" href="iecss.css" />
        <![endif]-->
        <script type="text/javascript" src="js/boxOver.js"></script>
        <style>
            .prod_box {
                position: relative;
                transition: transform 0.3s ease-in-out; /* Thêm hiệu ứng chuyển động */
            }

            .prod_box:hover {
                transform: scale(1.05); /* Phóng to sản phẩm lên 10% */
            }

            .product_img img {
                transition: transform 0.3s ease-in-out; /* Thêm hiệu ứng phóng to cho hình ảnh */
            }

            .prod_box:hover .product_img img {
                transform: scale(1.05); /* Phóng to hình ảnh lên 10% */
            }
            .left_menu li a.active {
                font-weight: bold; /* Tô đậm */
                color: white; /* Màu chữ trắng */
                background-color: #49bcd7 !important; /* Màu nền xanh, thêm !important để ưu tiên */
                border-radius: 5px; /* Bo góc */
                padding: 5px; /* Khoảng cách bên trong */
                display: block; /* Chiếm toàn bộ chiều rộng */
                text-decoration: none; /* Bỏ gạch chân */
            }
            #user_section {
                display: flex;
                justify-content: flex-end;
                align-items: center; /* Căn chỉnh theo chiều dọc */
                margin-right: 20px; /* Cách mép phải */
            }

            .user_menu {
                list-style: none;
                display: flex;
                gap: 20px; /* Khoảng cách giữa các mục */
                padding: 0;
                margin: 0;
                align-items: center; /* Căn chỉnh giữa các mục */
            }

            .user_menu li a {
                text-decoration: none;
                font-weight: bold;
                color: #333; /* Màu chữ đồng nhất với menu */
                padding: 10px 15px; /* Kích thước padding tương tự menu */
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }

            .user_menu li a:hover {
                background-color: #2575fc; /* Hiệu ứng hover */
                color: #fff;
            }

            .user_menu li span {
                font-weight: bold;
                color: #444; /* Màu chữ giống phần nội dung chính */
            }
            .pagination {
                margin: 20px auto; /* Căn giữa và thêm khoảng cách trên dưới */
                display: flex;
                justify-content: center; /* Căn giữa các phần tử */
                align-items: center; /* Căn chỉnh theo chiều dọc */
                clear: both; /* Loại bỏ ảnh hưởng của các phần tử trước đó */
            }

            .pagination ul {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
            }

            .pagination li {
                margin: 0 5px;
            }

            .pagination li a {
                display: inline-block;
                padding: 8px 16px;
                text-decoration: none;
                color: #333;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: all 0.3s ease;
            }

            .pagination li a:hover {
                background-color: #2575fc;
                color: #fff;
            }

            .pagination li.active a {
                background-color: #2575fc;
                color: #fff;
                pointer-events: none; /* Vô hiệu hóa click */
            }

            .pagination li.disabled a {
                color: #ccc;
                border-color: #ccc;
                pointer-events: none; /* Vô hiệu hóa click */
            }

        </style>
    </head>
    <body>
        <div id="main_container">
            <!-- Top Bar Section -->
            <div class="top_bar">
                <div class="top_search">
                    <div class="search_text"><a href="#">Tìm Kiếm Nâng Cao</a></div>
                    <form method="get" action="HOME.jsp">
                        <input type="text" class="search_input" name="search" placeholder="Tìm kiếm sản phẩm" />
                        <input type="image" src="images/search.gif" class="search_bt" />
                    </form>
                </div>
            </div>

            <!-- Header Section -->
            <%@ include file="header.jsp" %>

            <!-- Main Content Section -->
            <div id="main_content">
                <!-- Navigation Menu -->
                <div id="menu_tab">
                    <div class="left_menu_corner"></div>
                    <ul class="menu">
                        <li><a href="HOME.jsp" class="nav1">Trang Chủ</a></li>
                        <li class="divider"></li>
                        <li><a href="HOME.jsp" class="nav2">Sản Phẩm</a></li>
                        <li class="divider"></li>
                        <li><a href="" class="nav3">Tài Khoản</a></li>
                        <!--<li class="divider"></li>-->
                        <!--<li><a href="dangky.jsp" class="nav3">Đăng Ký</a></li>-->
                        <li class="divider"></li>
                        <li><a href="" class="nav4">Đơn Hàng</a></li>
                        <li class="divider"></li>
                        <li><a href="contact.html" class="nav5">Liên Hệ</a></li>
                        <li class="divider"></li>
                            <%
                                String username = null; // Khởi tạo biến username
                                String fullname = null; // Khởi tạo biến fullname

                                if (session != null) {
                                    // Lấy thông tin từ session
                                    username = (String) session.getAttribute("username");
                                    fullname = (String) session.getAttribute("fullname");
                                }
                            %>
                        <div id="user_section">
                            <ul class="user_menu">
                                <% if (username != null) {%>
                                <li><span>Xin chào, <strong><%= fullname != null ? fullname : username%></strong></span></li>
                                <li><a href="dangxuat.jsp">Đăng xuất</a></li>
                                    <% } else { %>
                                <li><a href="dangnhap.jsp">Đăng nhập</a></li>
                                <li><a href="dangky.jsp">Đăng ký</a></li>
                                    <% } %>
                            </ul>
                        </div>
                    </ul>
                    <div class="right_menu_corner"></div>
                </div>

                <!-- Content and Categories -->
                <!--<div class="crumb_navigation"> Navigation: <span class="current">Home</span> </div>-->

                <div class="left_content">
                    <div class="title_box">Categories</div>
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

                    <div class="title_box">Sản phẩm Hot</div>

                    <%                        // Khai báo các biến
                        String tenSanPhamSpecial = null;
                        String maSanPhamSpecial = null;
                        String hinhAnhSpecial = null;
                        String giaSpecial = null;
                        int soLuongSpecial = 0;

                        XULYDULIEU xulyhot = new XULYDULIEU();
                        try {
                            // Truy vấn sản phẩm có số lượng lớn nhất
                            String sqlSpecialProduct = "SELECT TOP 1 * FROM tbSANPHAM ORDER BY SOLUONG ASC";
                            ResultSet rsSpecialProduct = xulyhot.getResultSet(sqlSpecialProduct);

                            // Kiểm tra nếu có dữ liệu trả về từ cơ sở dữ liệu
                            if (rsSpecialProduct.next()) {
                                tenSanPhamSpecial = rsSpecialProduct.getString("TENSANPHAM");
                                maSanPhamSpecial = rsSpecialProduct.getString("MASANPHAM");
                                hinhAnhSpecial = rsSpecialProduct.getString("HINHANH");  // Giả sử bạn có cột HINHANH chứa tên file ảnh
                                giaSpecial = rsSpecialProduct.getString("DONGIA");
                                soLuongSpecial = rsSpecialProduct.getInt("SOLUONG");
                            }
                        } catch (Exception e) {
                            e.printStackTrace(); // Log lỗi để debug
                        }
                    %>
                    <div class="border_box">
                        <div class="product_title">
                            <!-- Sử dụng các biến đã khai báo để hiển thị thông tin sản phẩm đặc biệt -->
                            <a href="details.jsp?MSP=<%= maSanPhamSpecial%>"><%= tenSanPhamSpecial%></a>
                        </div>
                        <div class="product_img">
                            <a href="details.jsp?MSP=<%= maSanPhamSpecial%>">
                                <img src="images/<%= hinhAnhSpecial%>" alt="<%= tenSanPhamSpecial%>" />
                            </a>
                        </div>
                        <div class="prod_price">
                            <span class="price"><%= giaSpecial%> VNĐ</span>
                        </div>
                        <div class="prod_quantity" style="margin-bottom: 10px;">
                            Số lượng chỉ còn: <%= soLuongSpecial%>
                        </div>
                    </div>

                    <div class="title_box">Nhận thông tin sản phẩm mới</div>
                    <div class="border_box">
                        <input type="text" name="newsletter" class="newsletter_input" value="your email"/>
                        <a href="#" class="join">Xác Nhận</a>
                    </div>
                </div>

                <!-- Center Content for Products -->
                <div class="center_content">
                    <%
                        // Lấy giá trị từ URL (search và category)
                        String search = request.getParameter("search");
//                        String selectedCategory = request.getParameter("category");
                        int currentPage = 1; // Trang hiện tại
                        int pageSize = 9; // Số sản phẩm trên mỗi trang

                        // Lấy trang hiện tại từ URL
                        if (request.getParameter("page") != null) {
                            currentPage = Integer.parseInt(request.getParameter("page"));
                        }

                        // Xây dựng câu lệnh SQL động
                        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM tbSANPHAM");
                        StringBuilder countSqlBuilder = new StringBuilder("SELECT COUNT(*) AS totalProducts FROM tbSANPHAM");

                        // Thêm điều kiện WHERE nếu cần
                        boolean hasCondition = false;
                        if ((search != null && !search.trim().isEmpty()) || (selectedCategory != null && !selectedCategory.trim().isEmpty())) {
                            sqlBuilder.append(" WHERE");
                            countSqlBuilder.append(" WHERE");

                            if (search != null && !search.trim().isEmpty()) {
                                sqlBuilder.append(" TENSANPHAM LIKE ?");
                                countSqlBuilder.append(" TENSANPHAM LIKE ?");
                                hasCondition = true;
                            }

                            if (selectedCategory != null && !selectedCategory.trim().isEmpty()) {
                                if (hasCondition) {
                                    sqlBuilder.append(" AND");
                                    countSqlBuilder.append(" AND");
                                }
                                sqlBuilder.append(" MADANHMUC = ?");
                                countSqlBuilder.append(" MADANHMUC = ?");
                            }
                        }

                        // Thêm phần phân trang
                        sqlBuilder.append(" ORDER BY MASANPHAM ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

                        // Kết nối cơ sở dữ liệu và chuẩn bị câu lệnh
                        try {
                            PreparedStatement countStatement = xuly.getPreparedStatement(countSqlBuilder.toString());
                            PreparedStatement ps = xuly.getPreparedStatement(sqlBuilder.toString());

                            // Gán tham số cho câu lệnh SQL
                            int paramIndex = 1;
                            if (search != null && !search.trim().isEmpty()) {
                                countStatement.setString(paramIndex, "%" + search + "%");
                                ps.setString(paramIndex++, "%" + search + "%");
                            }
                            if (selectedCategory != null && !selectedCategory.trim().isEmpty()) {
                                countStatement.setString(paramIndex, selectedCategory);
                                ps.setString(paramIndex++, selectedCategory);
                            }

                            // Gán tham số cho phân trang
                            ps.setInt(paramIndex++, (currentPage - 1) * pageSize);
                            ps.setInt(paramIndex, pageSize);

                            // Tính tổng số sản phẩm
                            ResultSet rsCount = countStatement.executeQuery();
                            int totalProducts = rsCount.next() ? rsCount.getInt("totalProducts") : 0;
                            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

                            // Lấy sản phẩm
                            ResultSet rsSANPHAM = ps.executeQuery();
                            while (rsSANPHAM.next()) {
                                String tenSanPham = rsSANPHAM.getString("TENSANPHAM");
                                String maSanPham = rsSANPHAM.getString("MASANPHAM");
                                String hinhAnh = rsSANPHAM.getString("HINHANH");
                                int gia = rsSANPHAM.getInt("DONGIA");
                    %>
                    <div class="prod_box">
                        <div class="top_prod_box"></div>
                        <div class="center_prod_box">
                            <div class="product_title">
                                <a href="details.jsp?MSP=<%= maSanPham%>"><%= tenSanPham%></a>
                            </div>
                            <div class="product_img">
                                <a href="details.jsp?MSP=<%= maSanPham%>">
                                    <img src="images/<%= hinhAnh%>" alt="<%= tenSanPham%>" />
                                </a>
                            </div>
                            <div class="prod_price">
                                <span class="price"><%= gia%> VNĐ</span>
                            </div>
                        </div>
                        <div class="bottom_prod_box"></div>
                    </div>
                    <%
                        }
                    %>
                    <!-- Pagination -->
                    <div class="pagination">
                        <ul>
                            <!-- Nút Trước -->
                            <li class="<%= (currentPage == 1) ? "disabled" : ""%>">
                                <a href="HOME.jsp?page=<%= currentPage - 1%>
                                   <%= (search != null) ? "&search=" + search : ""%>
                                   <%= (selectedCategory != null) ? "&category=" + selectedCategory : ""%>">Trước</a>
                            </li>

                            <!-- Các trang -->
                            <% for (int i = 1; i <= totalPages; i++) {%>
                            <li class="<%= (i == currentPage) ? "active" : ""%>">
                                <a href="HOME.jsp?page=<%= i%>
                                   <%= (search != null) ? "&search=" + search : ""%>
                                   <%= (selectedCategory != null) ? "&category=" + selectedCategory : ""%>"><%= i%></a>
                            </li>
                            <% }%>

                            <!-- Nút Tiếp -->
                            <li class="<%= (currentPage == totalPages) ? "disabled" : ""%>">
                                <a href="HOME.jsp?page=<%= currentPage + 1%>
                                   <%= (search != null) ? "&search=" + search : ""%>
                                   <%= (selectedCategory != null) ? "&category=" + selectedCategory : ""%>">Tiếp</a>
                            </li>
                        </ul>
                    </div>
                    <%
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </div>


                <!-- Right Content for Cart and New Products -->
                <div class="right_content">
                    <div class="shopping_cart">
                        <div class="cart_title">Shopping cart</div>
                        <div class="cart_details"> 3 items <br />
                            <span class="border_cart"></span> Total: <span class="price">350 VNĐ</span> 
                        </div>
                        <div class="cart_icon"><a href="#"><img src="images/shoppingcart.png" alt="" width="48" height="48" /></a></div>
                    </div>
                    <%
                        // Khai báo các biến
                        String tenSanPhamNew = null;
                        String maSanPhamNew = null;
                        String hinhAnhNew = null;
                        String giaNew = null;

                        XULYDULIEU xuly2 = new XULYDULIEU();
                        try {
                            // Truy vấn sản phẩm mới nhất (MASANPHAM lớn nhất)
                            String sqlNewProduct = "SELECT TOP 1 * FROM tbSANPHAM ORDER BY MASANPHAM DESC";
                            ResultSet rsNewProduct = xuly2.getResultSet(sqlNewProduct);

                            // Kiểm tra nếu có dữ liệu trả về từ cơ sở dữ liệu
                            if (rsNewProduct.next()) {
                                tenSanPhamNew = rsNewProduct.getString("TENSANPHAM");
                                maSanPhamNew = rsNewProduct.getString("MASANPHAM");
                                hinhAnhNew = rsNewProduct.getString("HINHANH");  // Giả sử bạn có cột HINHANH chứa tên file ảnh
                                giaNew = rsNewProduct.getString("DONGIA");
                            }
                        } catch (Exception e) {
                            e.printStackTrace(); // Log lỗi để debug
                        }
                    %>

                    <div class="title_box">Sản phẩm mới nhất</div>
                    <div class="border_box">
                        <div class="product_title">
                            <a href="details.jsp?MSP=<%= maSanPhamNew%>"><%= tenSanPhamNew%></a>
                        </div>
                        <div class="product_img">
                            <a href="details.jsp?MSP=<%= maSanPhamNew%>">
                                <img src="images/<%= hinhAnhNew%>" alt="<%= tenSanPhamNew%>" />
                            </a>
                        </div>
                        <div class="prod_price">
                            <!--<span class="reduce"><%= giaNew + 80%> VNĐ</span>-->
                            <span class="price"><%= giaNew%> VNĐ</span>
                        </div>
                    </div>
                    <!--<div class="banner_adds"><a href="#"><img src="images/bann1.jpg" alt="" /></a></div>-->
                </div>
            </div>

            <!-- Footer Section -->
            <%@ include file="footer.jsp" %>
        </div>
    </body>
</html>
