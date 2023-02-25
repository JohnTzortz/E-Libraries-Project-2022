package classes;

import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

public class Borrowing {

    private Integer bookcopy_id;
    private Integer user_id;
    private Date fromdate;
    private Date todate;
    private String status;

    public Borrowing(Integer bookcopy_id, Integer user_id, Date fromdate, Date todate, String status) {
        this.bookcopy_id = bookcopy_id;
        this.user_id = user_id;
        this.fromdate = fromdate;
        this.todate = todate;
        this.status = status;
    }

    public Integer getBookcopy_id() {
        return bookcopy_id;
    }

    public void setBookcopy_id(Integer bookcopy_id) {
        this.bookcopy_id = bookcopy_id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Date getFromdate() {
        return fromdate;
    }

    public void setFromdate(Date fromdate) {
        this.fromdate = fromdate;
    }

    public Date getTodate() {
        return todate;
    }

    public void setTodate(Date todate) {
        this.todate = todate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public static void DBUpdate(Integer user_id, PrintWriter out, Integer bookcopy_id, String status) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("update borrowing set status=? where user_id=? and bookcopy_id=?");
            ps.setString(1, status);
            ps.setInt(2, user_id);
            ps.setInt(3, bookcopy_id);

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: User " + user_id + " and book " + bookcopy_id + " successfully updated.");
            } else {
                out.println("Status code 400 - Bad request - Message: Specified user or book don't exist.");
                throw new SQLException();
            }
            ps.close();
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
    }

    public static void DBInsert(Borrowing borrowing, PrintWriter out) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("insert into borrowing values(default,?,?,?,?,?)");
            ps.setInt(1, borrowing.getBookcopy_id());
            ps.setInt(2, borrowing.getUser_id());
            ps.setDate(3, borrowing.getFromdate() == null ? null : new java.sql.Date(borrowing.getFromdate().getTime()));
            ps.setDate(4, borrowing.getTodate() == null ? null : new java.sql.Date(borrowing.getTodate().getTime()));

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: User " + borrowing.getUser_id() + " and book "
                        + borrowing.getBookcopy_id() + " successfully updated.");
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
