package classes;

import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

public class AdminMessage {
    private String message;
    private Date date;

    public AdminMessage(String message, Date date) {
        this.message = message;
        this.date = date;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public static void DBInsert(AdminMessage message, PrintWriter out) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("insert into adminmessages values(default,?,?)");
            ps.setString(1, message.getMessage());
            ps.setDate(2, message.getDate() == null ? null : new java.sql.Date(message.getDate().getTime()));

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Admin message successfully posted.");
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
