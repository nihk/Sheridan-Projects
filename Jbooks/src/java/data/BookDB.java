package data;

import business.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDB {   
    public static int insert(Book b) {
        //these can't be class variables because this method is static       
        Connection conn = null;
        PreparedStatement ps = null;
        ConnControl cc = new ConnControl();
        
        String prepSql = "INSERT INTO books(bookId, title, author) VALUES(?, ?, ?);";
        
        try {
            conn = cc.connect();
            
            ps = conn.prepareStatement(prepSql);
            ps.setInt(1, b.getBookId());
            ps.setString(2, b.getTitle());
            ps.setString(3, b.getAuthor());
            
            return ps.executeUpdate();
        } catch (SQLException ex) {
            return 0;
        } catch (ClassNotFoundException ex) {
            return 0;
        } finally {
            //close statements and connection
            DBUtil.closePreparedStatement(ps);
            cc.freeConnection(conn);
        }    
    }
    
    public static ResultSet showAll() {
        Statement statement = null;
        Connection conn = null;
        ResultSet rs = null;
        ConnControl cc = new ConnControl();
        
        String sqlStm = "SELECT * FROM books;";
        
        try {
            conn = cc.connect();
            statement = conn.createStatement();
            rs = statement.executeQuery(sqlStm);
            
            return rs;
        } catch (ClassNotFoundException ex) {
            return null;
        } catch (SQLException ex) {
            return null;
        } finally {
            //close statements and connection..if these were uncommented then
            //the ResultSet object returned couldn't be used in the servlet
            //DBUtil.closeStatement(statement);
            //cc.freeConnection(conn);
        }
    }
    
    public static ResultSet search(String title, String author) {       
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ConnControl cc = new ConnControl();
        
        //Can search with title only or author only or both, but not neither
        String prepSql = null;
        if (title.length() == 0 || author.length() == 0) {
            prepSql = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ?;";
        } else {
            prepSql = "SELECT * FROM books WHERE title LIKE ? AND author LIKE ?;";
        }
        try {            
            conn = cc.connect();
            
            ps = conn.prepareStatement(prepSql);            
            ps.setString(1, title);
            ps.setString(2, author);
            
            rs = ps.executeQuery();
            
            return rs;
        } catch (SQLException ex) {
            return null;
        } catch (ClassNotFoundException ex) {
            return null;
        } finally {
            //close statements and connection..if these were uncommented then
            //the ResultSet object returned couldn't be used in the servlet
            //DBUtil.closeStatement(statement);
            //cc.freeConnection(conn);
        }
    }
    
    public static List<Book> getBookRecords(ResultSet rs) throws SQLException {
        List<Book> bookRecords = new ArrayList<>();
          
        //get all the books
        while (rs.next()) {
            Integer bookId = Integer.parseInt(rs.getString(1));
            String title = rs.getString(2);
            String author = rs.getString(3);
            bookRecords.add(new Book(bookId, title, author));           
        }

        return bookRecords; 
    }
    
    public static List<String> getBookColumnNames(ResultSetMetaData rsmd) throws SQLException {
        List<String> columnNames = new ArrayList<>();
        
        columnNames.add(rsmd.getColumnName(1));
        columnNames.add(rsmd.getColumnName(2));
        columnNames.add(rsmd.getColumnName(3)); 
        
        return columnNames;
    }
}