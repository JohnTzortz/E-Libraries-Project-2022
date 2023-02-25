package classes;

import com.sun.tools.javac.util.Pair;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


public class Database {

    private PrintWriter out = null;
    private Connection connect = null;
    private Statement statement = null;
    private ResultSet result = null;
    private PreparedStatement preparedStatement = null;

    public Database(PrintWriter out) {
        this.out = out;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/hy359_2022", "root", "");
            this.statement = this.connect.createStatement();
        } catch (ClassNotFoundException ex) {
            this.out.println("Status code 500 - Internal server error - ClassNotFoundException");
            ex.printStackTrace();
        } catch (SQLException ex) {
            this.out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
    }

    public void close() {
        try {
            this.connect.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
    }

    public PreparedStatement prepareStatement(String statement) {
        try {
            this.preparedStatement = this.connect.prepareStatement(statement);
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException.");
            ex.printStackTrace();
        }
        return this.preparedStatement;
    }

    public ResultSet executeStatement(String statement) {
        try {
            this.result = this.statement.executeQuery(statement);
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException.");
            ex.printStackTrace();
        }
        return this.result;
    }

    public static ArrayList<Pair<String, Integer>> getNumberOfStudentsByType(PrintWriter out) {
        ArrayList<Pair<String, Integer>> results = new ArrayList<Pair<String, Integer>>();
        try {
            Database database = new Database(out);
            ResultSet result;
            result = database.executeStatement("select count(*) as total from students where student_type='BSc'");
            result.next();
            results.add(new Pair("BSc", result.getInt("total")));
            result = database.executeStatement("select count(*) as total from students where student_type='MSc'");
            result.next();
            results.add(new Pair("MSc", result.getInt("total")));
            result = database.executeStatement("select count(*) as total from students where student_type='PhD'");
            result.next();
            results.add(new Pair("PhD", result.getInt("total")));
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return results;
    }

    public static ArrayList<Integer> getNumberOfBooksByLibrary(PrintWriter out) {
        ArrayList<Integer> results = new ArrayList<Integer>();
        try {
            ArrayList<Integer> numberOfLibraries = new ArrayList<Integer>();
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from librarians");
            while (result.next()) {
                numberOfLibraries.add(result.getInt("library_id"));
            }

            database = new Database(out);
            for (int i = 0; i < numberOfLibraries.size(); i++) {
                result = database.executeStatement("select count(*) as total from booksinlibraries where library_id=" + numberOfLibraries.get(i));
                result.next();
                results.add(result.getInt("total"));
            }

            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return results;
    }

    public static Integer getNumberOf(String of, PrintWriter out) {
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select count(*) as total from " + of);
            result.next();
            int res = result.getInt("total");
            database.close();
            return res;
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return null;
    }

    public static ArrayList<Review> getReviewsByIsbn(String isbn, PrintWriter out) {
        ArrayList<Review> reviews = new ArrayList<Review>();
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from reviews");
            while (result.next()) {
                if (result.getString("isbn").equals(isbn)) {
                    reviews.add(new Review(
                            result.getInt("user_id"),
                            result.getString("isbn"),
                            result.getString("reviewText"),
                            result.getInt("reviewScore")
                    ));
                }
            }
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return reviews.isEmpty() ? null : reviews;
    }

    public static Book getBookByIsbn(String isbn, PrintWriter out) {
        Book book = null;
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from books");
            while (result.next()) {
                if (result.getString("isbn").equals(isbn)) {
                    book = new Book(
                            result.getString("isbn"),
                            result.getString("title"),
                            result.getString("authors"),
                            result.getString("genre"),
                            result.getInt("publicationyear"),
                            result.getInt("pages"),
                            result.getString("photo"),
                            result.getString("url")
                    );
                    break;
                }
            }
            database.close();
            if (book == null) {
                throw new Exception();
            }
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        } catch (Exception ex) {
            out.println("Status code 404 - Not found - Message: This isbn doesn't exist");
            ex.printStackTrace();
        }
        return book;
    }

    public static ArrayList<Pair<String, Integer>> getNumberBooksByAllGenre(PrintWriter out) {
        ArrayList<Pair<String, Integer>> results = new ArrayList<Pair<String, Integer>>();
        try {
            Database database = new Database(out);
            ResultSet result;
            result = database.executeStatement("select distinct genre as gen from books");
            while (result.next()) {
                results.add(new Pair(result.getString("gen"), getNumberOfByGenre(result.getString("gen"), out)));
            }
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return results;
    }

    public static Integer getNumberOfByGenre(String genre, PrintWriter out) {
        return getBooksByGenre(genre, out).size();
    }

    public static ArrayList<Book> getBooksByAuthor(String author, PrintWriter out) {
        ArrayList<Book> books = new ArrayList<Book>();
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from books");
            while (result.next()) {
                if (result.getString("authors").contains(author)) {
                    books.add(new Book(
                            result.getString("isbn"),
                            result.getString("title"),
                            result.getString("authors"),
                            result.getString("genre"),
                            result.getInt("publicationyear"),
                            result.getInt("pages"),
                            result.getString("photo"),
                            result.getString("url")
                    ));
                }
            }
            database.close();
            if (books.isEmpty()) {
                throw new Exception();
            }
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        } catch (Exception ex) {
            out.println("Status code 404 - Not found - Message: No books found by author " + author);
            ex.printStackTrace();
        }
        return books;
    }

    public static ArrayList<Book> getBooksByTitle(String title, PrintWriter out) {
        ArrayList<Book> books = new ArrayList<Book>();
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from books");
            while (result.next()) {
                if (result.getString("title").contains(title)) {
                    books.add(new Book(
                            result.getString("isbn"),
                            result.getString("title"),
                            result.getString("authors"),
                            result.getString("genre"),
                            result.getInt("publicationyear"),
                            result.getInt("pages"),
                            result.getString("photo"),
                            result.getString("url")
                    ));
                }
            }
            database.close();
            if (books.isEmpty()) {
                throw new Exception();
            }
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        } catch (Exception ex) {
            out.println("Status code 404 - Not found - Message: No books found containing substring " + title);
            ex.printStackTrace();
        }
        return books;
    }

    public static ArrayList<Pair<String, ArrayList<Book>>> getBooksByAllGenre(PrintWriter out) {
        ArrayList<Pair<String, ArrayList<Book>>> results = new ArrayList<Pair<String, ArrayList<Book>>>();
        try {
            Database database = new Database(out);
            ResultSet result;
            result = database.executeStatement("select distinct genre as gen from books");
            while (result.next()) {
                results.add(new Pair(result.getString("gen"), getBooksByGenre(result.getString("gen"), out)));
            }
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return results;
    }

    public static ArrayList<Book> getBooksByGenre(String genre, PrintWriter out) {
        ArrayList<Book> books = new ArrayList<Book>();
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from books");
            while (result.next()) {
                if (result.getString("genre").contains(genre))
                books.add(new Book(
                        result.getString("isbn"),
                        result.getString("title"),
                        result.getString("authors"),
                        result.getString("genre"),
                        result.getInt("publicationyear"),
                        result.getInt("pages"),
                        result.getString("photo"),
                        result.getString("url")
                ));
            }
            database.close();
            if (books.isEmpty())
                throw new Exception();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        } catch (Exception ex) {
            out.println("Status code 404 - Not found - Message: " + genre + " genre doesn't include any books");
            ex.printStackTrace();
        }
        return books;
    }

    public static ArrayList<Book> getBooksByYear(Integer fromYear, PrintWriter out, Integer toYear) {
        if (fromYear == null) {
            fromYear = 0;
        }
        if (toYear == null) {
            toYear = Integer.MAX_VALUE;
        }
        ArrayList<Book> books = new ArrayList<Book>();
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from books");
            while (result.next()) {
                if (Integer.parseInt(result.getString("publicationyear")) >= fromYear
                        && Integer.parseInt(result.getString("publicationyear")) <= toYear) {
                    books.add(new Book(
                            result.getString("isbn"),
                            result.getString("title"),
                            result.getString("authors"),
                            result.getString("genre"),
                            result.getInt("publicationyear"),
                            result.getInt("pages"),
                            result.getString("photo"),
                            result.getString("url")
                    ));
                }
            }
            database.close();
            if (books.isEmpty()) {
                throw new Exception();
            }
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        } catch (Exception ex) {
            out.println("Status code 406 - Not acceptable - Message: No books found, check parameters");
            ex.printStackTrace();
        }
        return books;
    }

    public static ArrayList<Book> getBooksByPageNum(Integer fromNPages, PrintWriter out, Integer toNPages) {
        if (fromNPages == null) {
            fromNPages = 0;
        }
        if (toNPages == null) {
            toNPages = Integer.MAX_VALUE;
        }
        ArrayList<Book> books = new ArrayList<Book>();
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from books");
            while (result.next()) {
                if (Integer.parseInt(result.getString("pages")) >= fromNPages && Integer.parseInt(result.getString("pages")) <= toNPages) {
                    books.add(new Book(
                            result.getString("isbn"),
                            result.getString("title"),
                            result.getString("authors"),
                            result.getString("genre"),
                            result.getInt("publicationyear"),
                            result.getInt("pages"),
                            result.getString("photo"),
                            result.getString("url")
                    ));
                }
            }
            database.close();
            if (books.isEmpty()) {
                throw new Exception();
            }
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        } catch (Exception ex) {
            out.println("Status code 406 - Not acceptable - Message: No books found, check parameters");
            ex.printStackTrace();
        }
        return books;
    }

    public static ArrayList<SimpleUser> getUsers(PrintWriter out) {
        ArrayList<SimpleUser> users = new ArrayList<SimpleUser>();
        try {
            Database database = new Database(out);
            ResultSet result = database.executeStatement("select * from students");
            while (result.next()) {
                users.add(new SimpleUser(
                        result.getString("username"),
                        result.getString("email"),
                        result.getString("firstname"),
                        result.getString("lastname"),
                        "student"
                ));
            }

            result = database.executeStatement("select * from librarians");
            while (result.next()) {
                users.add(new SimpleUser(
                        result.getString("username"),
                        result.getString("email"),
                        result.getString("firstname"),
                        result.getString("lastname"),
                        "librarian"
                ));
            }
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return users;
    }
}
