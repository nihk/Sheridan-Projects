/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import business.Book;
import data.BookDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nick
 */
public class Search extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchTitle = request.getParameter("title");
        String searchAuthor = request.getParameter("author");
        
        if (searchTitle.trim().length() == 0 && searchAuthor.trim().length() == 0) {
            response.sendError(401, "Please enter valid search parameters.");           
        } else {        
        
            ResultSet rs = BookDB.search(searchTitle, searchAuthor);

            try {
                if (rs.next()) {
                    rs.previous();
                    
                    ResultSetMetaData rsmd = rs.getMetaData();
                    //new static methods I wrote in BookDB.java
                    List<String> columnNames = BookDB.getBookColumnNames(rsmd);
                    List<Book> bookRecords = BookDB.getBookRecords(rs); 

                    //set query results as attributes and forward it to jspShowAll.jsp to be displayed there
                    request.setAttribute("columnNames", columnNames);
                    request.setAttribute("bookRecords", bookRecords);
                    RequestDispatcher rd = request.getRequestDispatcher("/jspSearch.jsp");
                    rd.forward(request, response);                     
                } else {
                    request.setAttribute("noResults", "No results found.");
                    RequestDispatcher rd = request.getRequestDispatcher("/jspSearch.jsp");
                    rd.forward(request, response); 
                }
            } catch (SQLException e) {
                request.setAttribute("errorMsg", e.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("/errorPage.jsp");
                rd.include(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
