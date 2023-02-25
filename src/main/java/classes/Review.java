package classes;

import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Review {

    private Integer user_id;
    private String isbn;
    private String reviewText;
    private Integer reviewScore;

    public Review(Integer user_id, String isbn, String reviewText, Integer reviewScore) {
        this.user_id = user_id;
        this.isbn = isbn;
        this.reviewText = reviewText;
        this.reviewScore = reviewScore;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public Integer getReviewScore() {
        return reviewScore;
    }

    public void setReviewScore(Integer reviewScore) {
        this.reviewScore = reviewScore;
    }

    public static void DBInsert(Review review, PrintWriter out) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("insert into reviews values(default,?,?,?,?)");
            ps.setInt(1, review.getUser_id());
            ps.setString(2, review.getIsbn());
            ps.setString(3, review.getReviewText());
            ps.setInt(4, review.getReviewScore());

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Review successfully posted.");
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
