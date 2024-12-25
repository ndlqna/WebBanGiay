package PROCESSDATA;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author AD
 */
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author AD
 */
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class XULYDULIEU {

    Connection cnn;
    Statement stm;
    PreparedStatement ps;

    public XULYDULIEU() {
        try {
            cnn = null;
            stm = null;
            String DriverClass, DriverURL;
            String UserName = "sa";
            String PassWord = "1234";
            String DataBaseName = "dbWebBanGiay";
            String ServerName = "DESKTOP-DQE51OG\\SQLEXPRESS";

            String IntegratedSecurity = "IntegratedSecurity=false";
            DriverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
            DriverURL = "jdbc:sqlserver://" + ServerName + ":1433;databaseName=" + DataBaseName + ";user=" + UserName + " ;password=" + PassWord + ";encrypt=false;trustServerCertificate=true";
            Class.forName(DriverClass);
            // cnn=DriverManager.getConnection(DriverURL,UserName,PassWord);
            cnn = DriverManager.getConnection(DriverURL);
            stm = cnn.createStatement();

        } catch (SQLException ex) {
        } catch (Exception e) {
        }
    }

    public ResultSet getResultSet(String SQL) {
        try {
            ResultSet rs;
            rs = this.stm.executeQuery(SQL);
            return rs;
        } catch (Exception ex) {
        }
        return null;
    }
    //SELECT * FROM TBLAOINHANVIEN WHERE  IDLOAINHANVIEN=?

    public ResultSet getResultSet(String SQL, Object[] param) {
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            ps = cnn.prepareStatement(SQL);
            int i = 1;
            for (Object value : param) {
                ps.setObject(i, value);
                i++;
            }
            rs = ps.executeQuery();
            return rs;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

//SQL (DELETE, UPDATE, INSERT)
    //INSERT INTO TBLOAINHANVIEN(IDLOAINHANVIEN,TENLOAINHANVIEN) VALUES(1,'NHAN VIEN BIEN CHE')
    public int ExecuteSQL(String SQL) {
        try {
            int k = 0;
            k = this.stm.executeUpdate(SQL);
            return k;
        } catch (SQLException e) {
        }
        return 0;
    }

    //INSERT INTO TBLOAINHANVIEN(IDLOAINHANVIEN,TENLOAINHANVIEN) VALUES(?,?)
    public int ExecuteSQL(String SQL, Object[] param) {
        try {
            int k = 0;
            PreparedStatement ps = this.cnn.prepareStatement(SQL);
            int i = 1;
            for (Object value : param) {
                ps.setObject(i, value);
                i++;
            }
            k = ps.executeUpdate();
            ps.close();
            return k;
        } catch (SQLException e) {
        }
        return 0;
    }

    public ResultSet searchProductsByName(String searchText) {
        String sql = "SELECT * FROM tbSANPHAM WHERE TENSANPHAM LIKE ?";
        Object[] params = {"%" + searchText + "%"};
        return getResultSet(sql, params);
    }

    public int Execute_StoredProcedures(String NameStoredProcedures, Object[] param) {
        try {
            int k = 0;
            CallableStatement ps = this.cnn.prepareCall("{call " + NameStoredProcedures + "}");
            int i = 1;
            for (Object value : param) {

                ps.setObject(i, value);
                i++;
            }
            k = ps.executeUpdate();
            ps.close();
            return k;
        } catch (SQLException e) {
        }
        return 0;
    }

    public ResultSet getResultSet_StoredProcedures(String NameStoredProcedures, Object[] param) {
        ResultSet rs = null;
        CallableStatement ps = null;

        try {
            ps = cnn.prepareCall("{call " + NameStoredProcedures + "}");
            if (param != null) {
                int i = 1;
                for (Object value : param) {
                    ps.setObject(i, value);
                    i++;
                }
            }
            rs = ps.executeQuery();
            ps.close();
            return rs;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    //tự thêm
    public PreparedStatement getPreparedStatement(String sql) {
        try {
            return cnn.prepareStatement(sql); // `cnn` là đối tượng Connection trong lớp của bạn
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public int getCount(String sql, Object[] param) {
        int count = 0;
        ResultSet rs = null;
        try {
            ps = cnn.prepareStatement(sql);
            int i = 1;
            for (Object value : param) {
                ps.setObject(i, value);
                i++;
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1); // Lấy giá trị từ cột đầu tiên (COUNT(*))
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
    }

    public int getTotalRecords(String tableName) throws SQLException {
        String sql = "SELECT COUNT(*) FROM " + tableName;
        PreparedStatement ps = cnn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }
}
