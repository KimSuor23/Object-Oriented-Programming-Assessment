package speciesproject.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import speciesproject.model.bean.Species;

public class SpeciesDAO {
    private String DBURL = "jdbc:mysql://localhost:3306/assessment2?serverTimezone=Australia/Melbourne";
    private String DBUsername = "root";
    private String DBPassword = "Kimsourl123";

    private String INSERT_SPECIES = "INSERT INTO species (title, category_id, created_date, content, is_hidden) VALUES (?, ?, ?, ?, ?);";
    private String SELECT_SPECIES = "SELECT id, title, category_id, created_date, content, is_hidden FROM species WHERE id = ?";
    private String SELECT_ALL_SPECIES = "SELECT * FROM species";
    private String DELETE_SPECIES = "DELETE FROM species WHERE id = ?;";
    private String UPDATE_SPECIES = "UPDATE species SET title = ?, category_id = ?, content = ?, is_hidden = ? WHERE id = ?;";
    private static final String TOGGLE_HIDE_SPECIES_SQL = "UPDATE species SET is_hidden = ? WHERE id = ?";

    // Constructor
    public SpeciesDAO() {}

    // Get Connection
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DBURL, DBUsername, DBPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
    
    public boolean toggleHideSpecies(int id, boolean currentHiddenStatus) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(TOGGLE_HIDE_SPECIES_SQL)) {
            preparedStatement.setBoolean(1, !currentHiddenStatus);  // Toggle the status
            preparedStatement.setInt(2, id);
            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
    
    public List<Species> searchSpecies(String query) throws SQLException {
        List<Species> speciesList = new ArrayList<>();
        String SEARCH_QUERY = "SELECT * FROM species WHERE title LIKE ? OR content LIKE ?";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_QUERY)) {
            preparedStatement.setString(1, "%" + query + "%");
            preparedStatement.setString(2, "%" + query + "%");
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                int categoryId = rs.getInt("category_id");
                String createdDate = rs.getString("created_date");
                String content = rs.getString("content");
                boolean isHidden = rs.getBoolean("is_hidden");
                speciesList.add(new Species(id, title, categoryId, createdDate, content, isHidden));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return speciesList;
    }


    // Insert species
    public void insertSpecies(Species species) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = getConnection();
            preparedStatement = connection.prepareStatement(INSERT_SPECIES);
            preparedStatement.setString(1, species.getTitle());
            preparedStatement.setInt(2, species.getCategoryId());
            preparedStatement.setString(3, species.getCreatedDate());
            preparedStatement.setString(4, species.getContent());
            preparedStatement.setBoolean(5, species.isHidden());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        } finally {
            finallySQLException(connection, preparedStatement, null);
        }
    }

    // Select a species by id
    public Species selectSpecies(int id) {
        Species species = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            preparedStatement = connection.prepareStatement(SELECT_SPECIES);
            preparedStatement.setInt(1, id);
            rs = preparedStatement.executeQuery();
            if (rs.next()) {
                String title = rs.getString("title");
                int categoryId = rs.getInt("category_id");
                String createdDate = rs.getString("created_date");
                String content = rs.getString("content");
                boolean isHidden = rs.getBoolean("is_hidden");
                species = new Species(id, title, categoryId, createdDate, content, isHidden);
            }
        } catch (SQLException e) {
            printSQLException(e);
        } finally {
            finallySQLException(connection, preparedStatement, rs);
        }
        return species;
    }

    // Select all species
    public List<Species> selectAllSpecies() {
        List<Species> speciesList = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            preparedStatement = connection.prepareStatement(SELECT_ALL_SPECIES);
            rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                int categoryId = rs.getInt("category_id");
                String createdDate = rs.getString("created_date");
                String content = rs.getString("content");
                boolean isHidden = rs.getBoolean("is_hidden");
                Species species = new Species(id, title, categoryId, createdDate, content, isHidden);
                speciesList.add(species);
            }
        } catch (SQLException e) {
            printSQLException(e);
        } finally {
            finallySQLException(connection, preparedStatement, rs);
        }
        return speciesList;
    }

    // Delete species
    public boolean deleteSpecies(int id) throws SQLException {
        boolean rowDeleted = false;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = getConnection();
            preparedStatement = connection.prepareStatement(DELETE_SPECIES);
            preparedStatement.setInt(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } finally {
            finallySQLException(connection, preparedStatement, null);
        }
        return rowDeleted;
    }

    // Update species
    public boolean updateSpecies(Species species) throws SQLException {
        boolean rowUpdated = false;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = getConnection();
            preparedStatement = connection.prepareStatement(UPDATE_SPECIES);
            preparedStatement.setString(1, species.getTitle());
            preparedStatement.setInt(2, species.getCategoryId());
            preparedStatement.setString(3, species.getContent());
            preparedStatement.setBoolean(4, species.isHidden());
            preparedStatement.setInt(5, species.getId());
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } finally {
            finallySQLException(connection, preparedStatement, null);
        }
        return rowUpdated;
    }

    // Handle SQL exceptions
    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }

    // Clean up SQL resources
    private void finallySQLException(Connection c, PreparedStatement p, ResultSet r) {
        try {
            if (r != null) r.close();
            if (p != null) p.close();
            if (c != null) c.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
