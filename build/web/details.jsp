<%-- 
    Document   : details
    Created on : Nov 5, 2024, 7:55:03 PM
    Author     : AD
--%>
<%@ page import="PROCESSDATA.XULYDULIEU" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>GiayTot Store</title>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
        <link rel="stylesheet" type="text/css" href="style.css" />
        <!--[if IE 6]>
        <link rel="stylesheet" type="text/css" href="iecss.css" />
        <![endif]-->
        <script type="text/javascript" src="js/boxOver.js"></script>
    </head>
    <body>
        <div id="main_container">
            <div class="top_bar">
                <div class="top_search">
                    <div class="search_text"><a href="#">Tìm Kiếm Nâng Cao</a></div>
                    <form method="get" action="HOME.jsp">
                        <input type="text" class="search_input" name="search" placeholder="Tìm kiếm sản phẩm" />
                        <input type="image" src="images/search.gif" class="search_bt" />
                    </form>
                </div>
            </div>
            <%@ include file="header.jsp" %>
            <div id="main_content">
                <div id="menu_tab">
                    <div class="left_menu_corner"></div>
                    <ul class="menu">
                        <li><a href="#" class="nav1">Trang Chủ</a></li>
                        <li class="divider"></li>
                        <li><a href="#" class="nav2">Sản Phẩm</a></li>
                        <li class="divider"></li>
                        <li><a href="#" class="nav3">Tài Khoản</a></li>
                        <li class="divider"></li>
                        <li><a href="#" class="nav3">Đăng Ký</a></li>
                        <li class="divider"></li>
                        <li><a href="#" class="nav4">Đơn Hàng</a></li>
                        <li class="divider"></li>
                        <li><a href="contact.html" class="nav5">Liên Hệ</a></li>
                        <li class="divider"></li>
                    </ul>
                    <div class="right_menu_corner"></div>
                </div>
                <!-- end of menu tab -->
                <!--<div class="crumb_navigation"> Navigation: <span class="current">Home</span> </div>-->
                <div class="left_content">
                    <div class="title_box">Categories</div>
                    <%@ include file="leftmenu.jsp" %>
                    <div class="title_box">Sản phẩm Hot</div>

                    <%
                        // Khai báo các biến
                        String tenSanPhamSpecial = null;
                        String maSanPhamSpecial = null;
                        String hinhAnhSpecial = null;
                        int giaSpecial = 0;
                        int soLuongSpecial = 0;

                        XULYDULIEU xulyhot = new XULYDULIEU();
                        try {
                            // Truy vấn sản phẩm có số lượng lớn nhất
                            String sqlSpecialProduct = "SELECT TOP 1 * FROM tbSANPHAM ORDER BY MASANPHAM ASC";
                            ResultSet rsSpecialProduct = xulyhot.getResultSet(sqlSpecialProduct);

                            // Kiểm tra nếu có dữ liệu trả về từ cơ sở dữ liệu
                            if (rsSpecialProduct.next()) {
                                tenSanPhamSpecial = rsSpecialProduct.getString("TENSANPHAM");
                                maSanPhamSpecial = rsSpecialProduct.getString("MASANPHAM");
                                hinhAnhSpecial = rsSpecialProduct.getString("HINHANH");  // Giả sử bạn có cột HINHANH chứa tên file ảnh
                                giaSpecial = rsSpecialProduct.getInt("DONGIA");
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
            </div>
            <!-- end of left content -->
            <%
                String masanpham = request.getParameter("MSP");
                String sql = "select * from tbSANPHAM where MASANPHAM=" + masanpham;
                ResultSet rsSANPHAM = xuly.getResultSet(sql);
                rsSANPHAM.next();
            %>           
            <div class="center_content">

                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">
                        <div class="product_img_big"> 
                            <img src="images/<%= rsSANPHAM.getString("HINHANH")%>" alt="ảnh sản phẩm" />
                        </div>
                        <div class="details_big_box">
                            <div class="product_title_big"><%=rsSANPHAM.getString("TENSANPHAM")%></div>
                            <div class="specifications" style="margin-bottom: 10px;">
                                Số lượng còn lại: <span class="blue"><%= rsSANPHAM.getInt("SOLUONG")%></span><br />
                                Mô tả: <span class="blue"><%= rsSANPHAM.getString("MOTA")%></span><br />
                                <!--Giá gốc: <span class="blue"><%= rsSANPHAM.getInt("DONGIA") + 80%> VNĐ</span><br />-->
                                Giá : <span class="blue"><%= rsSANPHAM.getString("DONGIA")%> VNĐ</span><br />
                            </div>
                            <!--<div class="prod_price_big"><span class="reduce">350$</span> <span class="price">270$</span></div>-->
                            <a href="#" class="addtocart">add to cart</a> <a href="#" class="compare">compare</a> </div>
                    </div>
                    <div class="bottom_prod_box_big"></div>
                </div>
            </div>
            <!-- end of center content -->


            <div class="right_content">
                <div class="shopping_cart">
                    <div class="cart_title">Shopping cart</div>
                    <div class="cart_details"> 3 items <br />
                        <span class="border_cart"></span> Total: <span class="price">350$</span> </div>
                    <div class="cart_icon"><a href="#" title="header=[Checkout] body=[&nbsp;] fade=[on]"><img src="images/shoppingcart.png" alt="" width="48" height="48" border="0" /></a></div>
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
            </div>
            <!-- end of right content -->
        </div>
        <!-- end of main content -->
        <div class="footer">
            <div class="left_footer" style="margin-left: 100px;"> <img src="images/logo2.png" alt="" width="70" height="60"/> </div>
            <div class="center_footer"> Chỉnh sửa bởi DUC LEN<br />
                <img src="images/csscreme.jpg" alt="csscreme" border="0" /><br />
                <img src="images/payment.gif" alt="" /> </div>
            <!--<div class="right_footer"> <a href="#">home</a> <a href="#">about</a> <a href="#">sitemap</a> <a href="#">rss</a> <a href="contact.html">contact us</a> </div>-->
        </div>
        </div>
        <!-- end of main_container -->
    </body>
</html>
