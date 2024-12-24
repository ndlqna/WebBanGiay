
import java.io.IOException;
import java.sql.*;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
@MultipartConfig
public class AdminServlet extends HttpServlet {

    PROCESSDATA.XULYDULIEU xuly = new PROCESSDATA.XULYDULIEU();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("ROLE") : null;

        if (session == null || !"admin".equals(role)) {
            response.sendRedirect("dangnhap.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            switch (action.toLowerCase()) {
                case "add":
                    addProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "edit":
                    editProduct(request, response);
                    break;
                case "update":
                    updateProduct(request, response);
                    break;
                default:
                    response.getWriter().write("Action không hợp lệ.");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Đã xảy ra lỗi: " + e.getMessage());
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("TENSANPHAM");
        int price = Integer.parseInt(request.getParameter("DONGIA"));
        int quantity = Integer.parseInt(request.getParameter("SOLUONG"));
        Part imagePart = request.getPart("HINHANH");
        String imageName = imagePart != null && imagePart.getSize() > 0 ? imagePart.getSubmittedFileName() : "";

        try {
            if (!imageName.isEmpty()) {
                String imagePath = request.getServletContext().getRealPath("/images/") + imageName;
                imagePart.write(imagePath);
            }

            String sql = "INSERT INTO tbSANPHAM (TENSANPHAM, DONGIA, SOLUONG, HINHANH) VALUES (?, ?, ?, ?)";
            Object[] params = {name, price, quantity, imageName};
            xuly.ExecuteSQL(sql, params);

            response.sendRedirect("admin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Lỗi khi thêm sản phẩm: " + e.getMessage());
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            String sql = "DELETE FROM tbSANPHAM WHERE MASANPHAM = ?";
            xuly.ExecuteSQL(sql, new Object[]{id});
            response.sendRedirect("admin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Lỗi khi xóa sản phẩm: " + e.getMessage());
        }
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            String sql = "SELECT * FROM tbSANPHAM WHERE MASANPHAM = ?";
            ResultSet rs = xuly.getResultSet(sql, new Object[]{id});
            if (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("MASANPHAM", rs.getInt("MASANPHAM"));
                product.put("TENSANPHAM", rs.getString("TENSANPHAM"));
                product.put("DONGIA", rs.getInt("DONGIA"));
                product.put("SOLUONG", rs.getInt("SOLUONG"));
                product.put("HINHANH", rs.getString("HINHANH"));

                // Gán đối tượng product vào request
                request.setAttribute("product", product);
                request.getRequestDispatcher("editProduct.jsp").forward(request, response);
            } else {
                response.getWriter().write("Sản phẩm không tồn tại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Lỗi khi chỉnh sửa sản phẩm: " + e.getMessage());
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("TENSANPHAM");
        int price = Integer.parseInt(request.getParameter("DONGIA"));
        int quantity = Integer.parseInt(request.getParameter("SOLUONG"));
        Part imagePart = request.getPart("HINHANH");
        String imageName = imagePart.getSize() > 0 ? imagePart.getSubmittedFileName() : null;

        try {
            if (imageName != null && !imageName.isEmpty()) {
                String imagePath = request.getServletContext().getRealPath("/images/") + imageName;
                imagePart.write(imagePath);
            }

            String sql = "UPDATE tbSANPHAM SET TENSANPHAM = ?, DONGIA = ?, SOLUONG = ?, HINHANH = ? WHERE MASANPHAM = ?";
            Object[] params = {name, price, quantity, imageName != null ? imageName : "", id};
            xuly.ExecuteSQL(sql, params);

            response.sendRedirect("admin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Lỗi khi cập nhật sản phẩm: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet quản lý sản phẩm";
    }
}
