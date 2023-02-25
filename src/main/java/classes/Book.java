package classes; 

import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Book {

    private String isbn;
    private String title;
    private String authors;
    private String genre;
    private Integer publicationyear;
    private Integer pages;
    private String photo;
    private String url;

    public Book(String isbn, String title, String authors, String genre, Integer publicationyear, Integer pages, String photo, String url) {
        this.isbn = isbn;
        this.title = title;
        this.authors = authors;
        this.genre = genre;
        this.publicationyear = publicationyear;
        this.pages = pages;
        this.photo = photo;
        this.url = url;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthors() {
        return authors;
    }

    public void setAuthors(String authors) {
        this.authors = authors;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public Integer getPublicationyear() {
        return publicationyear;
    }

    public void setPublicationyear(Integer publicationyear) {
        this.publicationyear = publicationyear;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhot(String phot) {
        this.photo = phot;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public static void DBInsert(Book book, PrintWriter out, Integer library_id) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("insert into books values(?,?,?,?,?,?,?,?)");
            ps.setString(1, book.getIsbn());
            ps.setString(2, book.getTitle());
            ps.setString(3, book.getAuthors());
            ps.setString(4, book.getGenre());
            ps.setInt(5, book.getPages());
            ps.setInt(6, book.getPublicationyear());
            ps.setString(7, book.getUrl());
            ps.setString(8, book.getPhoto());

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Book with isbn " + book.getIsbn() + " successfully added.");
            } else {
                out.println("Status code 400 - Bad request - Message: Rules breached.");
                throw new SQLException();
            }
            ps.close();
            database.close();

            BookInLibrary.DBInsert(new BookInLibrary(book.isbn, library_id, "false"), out);
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
    }
}
