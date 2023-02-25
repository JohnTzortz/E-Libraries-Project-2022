package classes;

import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BookInLibrary {

    private String isbn;
    private Integer library_id;
    private String available;

    public BookInLibrary(String isbn, Integer library_id, String available) {
        this.isbn = isbn;
        this.library_id = library_id;
        this.available = available;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public Integer getLibrary_id() {
        return library_id;
    }

    public void setLibrary_id(Integer library_id) {
        this.library_id = library_id;
    }

    public String getAvailable() {
        return available;
    }

    public void setAvailable(String available) {
        this.available = available;
    }

    public static void DBUpdate(String isbn, PrintWriter out, String available) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("update booksinlibraries set available=? where isbn=?");
            ps.setString(1, available);
            ps.setString(2, isbn);

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Book with isbn " + isbn + " successfully updated.");
            } else {
                out.println("Status code 400 - Bad request - Message: Specified isbn doesn't exist.");
                throw new SQLException();
            }
            ps.close();
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
    }

    public static void DBInsert(BookInLibrary book, PrintWriter out) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("insert into booksinlibraries values(default,?,?,?)");
            ps.setString(1, book.getIsbn());
            ps.setInt(2, book.getLibrary_id());
            ps.setString(3, book.getAvailable());

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Book with isbn " + book.getIsbn() + " successfully added to library " + book.getLibrary_id() + ".");
            } else {
                out.println("Status code 400 - Bad request - Message: Rules breached.");
                throw new SQLException();
            }
            ps.close();
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
    }
}
