
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // Import HttpSession

@WebServlet(urlPatterns = {"/DANGKY", "/DANGNHAP"})
public class DANGKY extends HttpServlet {

    PROCESSDATA.XULYDULIEU xuly;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            xuly = new PROCESSDATA.XULYDULIEU();

            String action = request.getServletPath();

            if (action.equals("/DANGKY")) {
                // Xử lý đăng ký
                String HOTEN = request.getParameter("txtHOTEN");
                String NGAYSINH = request.getParameter("txtNGAYSINH");
                String GIOITINH = request.getParameter("txtGIOITINH");
                String EMAIL = request.getParameter("txtEMAIL");
                String TAIKHOAN = request.getParameter("txtTAIKHOAN");
                String MATKHAU = request.getParameter("txtMATKHAU");

                String checkSQL = "SELECT COUNT(*) FROM tbKHACHHANG WHERE TAIKHOAN = ?";
                Object[] params = {TAIKHOAN};
                int count = xuly.getCount(checkSQL, params);
                if (count > 0) {
                    request.setAttribute("errorMessageRegister", "Tài khoản đã tồn tại. Vui lòng chọn tài khoản khác.");
                    request.getRequestDispatcher("dangky.jsp").forward(request, response);
                    return;
                }

                String SQL = "INSERT INTO tbKHACHHANG(HOTEN, NGAYSINH, GIOITINH, EMAIL, TAIKHOAN, MATKHAU)"
                        + " VALUES(?, ?, ?, ?, ?, ?)";
                Object[] insertParams = {HOTEN, NGAYSINH, GIOITINH, EMAIL, TAIKHOAN, MATKHAU};
                int result = xuly.ExecuteSQL(SQL, insertParams);

                if (result > 0) {
                    request.setAttribute("successMessageRegister", "Đăng ký thành công! Bạn có thể đăng nhập ngay bây giờ.");
                    request.getRequestDispatcher("dangky.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessageRegister", "Đăng ký thất bại. Vui lòng thử lại.");
                    request.getRequestDispatcher("dangky.jsp").forward(request, response);
                }
            } else if (action.equals("/DANGNHAP")) {
                // Xử lý đăng nhập
                String TAIKHOAN = request.getParameter("txtTAIKHOAN_LOGIN");
                String MATKHAU = request.getParameter("txtMATKHAU_LOGIN");

                String loginSQL = "SELECT * FROM tbKHACHHANG WHERE TAIKHOAN = ? AND MATKHAU = ?";
                Object[] loginParams = {TAIKHOAN, MATKHAU};
                ResultSet rs = xuly.getResultSet(loginSQL, loginParams);

                if (rs != null && rs.next()) {
                    // Lưu thông tin người dùng vào session
                    HttpSession session = request.getSession();
                    session.setAttribute("username", rs.getString("TAIKHOAN")); // Lưu tên tài khoản
                    session.setAttribute("fullname", rs.getString("HOTEN")); // Lưu tên đầy đủ
                    session.setAttribute("ROLE", rs.getString("ROLE"));
                    // Chuyển hướng đến trang chủ
                    response.sendRedirect("HOME.jsp");
                } else {
                    // Sai tài khoản hoặc mật khẩu
                    request.setAttribute("errorMessageLogin", "Sai tên tài khoản hoặc mật khẩu. Vui lòng thử lại.");
                    request.getRequestDispatcher("dangnhap.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (request.getServletPath().equals("/DANGNHAP")) {
                request.setAttribute("errorMessageLogin", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
                request.getRequestDispatcher("dangnhap.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessageRegister", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
                request.getRequestDispatcher("dangky.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng ký và đăng nhập";
    }
}
