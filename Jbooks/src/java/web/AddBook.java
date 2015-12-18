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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nick
 */
public class AddBook extends HttpServlet {

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
        
        String bookId = request.getParameter("bookid");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        
        if (bookId.trim().length() == 0) {
            response.sendError(401, "The book ID cannot be empty. Please enter a book ID.");  
        } else if (title.trim().length() == 0) {
            response.sendError(401, "The book title cannot be empty. Please enter a book title."); 
        } else if (author.trim().length() == 0) {
            response.sendError(401, "The book author cannot be empty. Please enter a book author."); 
        } else {  
            try {
                Book book = new Book(Integer.parseInt(bookId), title, author);
                int inserted = BookDB.insert(book);

                //if successfully inserted, forward the book object
                if (inserted == 1) {
                    //forward the book object to jspAddBook.jsp
                    request.setAttribute("book", book);
                    RequestDispatcher rd = request.getRequestDispatcher("/jspAddBook.jsp");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("badBookId", "Insert failed. Book ID " + bookId + " already exists.");
                    RequestDispatcher rd = request.getRequestDispatcher("/bookForm.jsp");
                    rd.include(request, response);                
                }
            } catch (NumberFormatException nfe) {
                request.setAttribute("badBookId", "Insert failed. Book ID \"" + bookId + "\" is not a valid integer.");
                RequestDispatcher rd = request.getRequestDispatcher("/bookForm.jsp");
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
