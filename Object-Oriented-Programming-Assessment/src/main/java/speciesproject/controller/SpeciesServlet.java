package speciesproject.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import speciesproject.model.bean.Species;
import speciesproject.model.dao.SpeciesDAO;

@WebServlet("/SpeciesServlet")
public class SpeciesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SpeciesDAO SpeDAO;

    public SpeciesServlet() {
        super();
    }
    
    @Override
    public void init() {
        SpeDAO = new SpeciesDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }
        try {
            switch (action) {
            case "toggleHide":
                toggleHideSpecies(request, response);
                break;
            case "search":
                searchSpecies(request, response);
                break;
            case "new":
                showNewSpecies(request, response);
                break;
            case "insert":
                insertSpecies(request, response);
                break;
            case "delete":
                deleteSpecies(request, response);
                break;
            case "edit":
                showEditSpecies(request, response);
                break;
            case "update":
                updateSpecies(request, response);
                break;
            default:
                listSpecies(request, response);
                break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
    private void toggleHideSpecies(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Species species = SpeDAO.selectSpecies(id);
        if (species != null) {
            SpeDAO.toggleHideSpecies(id, species.isHidden());
        }
        response.sendRedirect(request.getContextPath() + "/SpeciesServlet?action=list");
    }
    
    private void searchSpecies(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String searchQuery = request.getParameter("search");
        List<Species> filteredSpecies = SpeDAO.searchSpecies(searchQuery);
        request.setAttribute("listSpecies", filteredSpecies);
        RequestDispatcher dispatcher = request.getRequestDispatcher("SpeciesList.jsp");
        dispatcher.forward(request, response);
    }

    private void listSpecies(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Species> allSpecies = SpeDAO.selectAllSpecies();
        request.setAttribute("listSpecies", allSpecies);
        RequestDispatcher dispatcher = request.getRequestDispatcher("SpeciesList.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewSpecies(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("Speciesform.jsp");
        dispatcher.forward(request, response);
    }

    private void insertSpecies(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String title = request.getParameter("Title");
        int categoryID = Integer.parseInt(request.getParameter("CategoryID"));
        String dateCreated = request.getParameter("CreatedDate");
        String content = request.getParameter("Content");
        Boolean isHidden = Boolean.parseBoolean(request.getParameter("is_hidden"));
        
        Species spe = new Species(title, categoryID, dateCreated, content, isHidden);
        SpeDAO.insertSpecies(spe);
        response.sendRedirect(request.getContextPath() + "/SpeciesServlet?action=list");
    }

    private void showEditSpecies(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Species existingSpecies = SpeDAO.selectSpecies(id);
        request.setAttribute("species", existingSpecies);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Speciesform.jsp");
        dispatcher.forward(request, response);
    }

    private void updateSpecies(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("Title");
        int categoryID = Integer.parseInt(request.getParameter("CategoryID"));
        String dateCreated = request.getParameter("CreatedDate");
        String content = request.getParameter("Content");
        Boolean isHidden = Boolean.parseBoolean(request.getParameter("is_hidden"));
        
        Species spe = new Species(id, title, categoryID, dateCreated, content, isHidden);
        SpeDAO.updateSpecies(spe);
        response.sendRedirect(request.getContextPath() + "/SpeciesServlet?action=list");
    }

    private void deleteSpecies(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        SpeDAO.deleteSpecies(id);
        response.sendRedirect(request.getContextPath() + "/SpeciesServlet?action=list");
    }
}
