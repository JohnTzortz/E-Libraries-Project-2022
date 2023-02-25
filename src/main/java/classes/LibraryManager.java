package classes;

import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;

public class LibraryManager extends User {

    private String libraryname;
    private String libraryinfo;

    public LibraryManager(String username, String email, String password, String firstname, String lastname, Date birthdate,
            String gender, String country, String city, String address, String libraryname, String libraryinfo, Double lat, Double lon,
            String telephone, String personalpage) {
        super(username, email, password, firstname, lastname, gender, birthdate, country, city, address, telephone, personalpage, lat, lon);
        this.libraryname = libraryname;
        this.libraryinfo = libraryinfo;
    }

    public String getLibraryname() {
        return libraryname;
    }

    public void setLibraryname(String libraryname) {
        this.libraryname = libraryname;
    }

    public String getLibraryinfo() {
        return libraryinfo;
    }

    public void setLibraryinfo(String libraryinfo) {
        this.libraryinfo = libraryinfo;
    }

    @Override
    public String toString() {
        return super.toString() + "LibraryManager{" + "libraryname=" + libraryname + ", libraryinfo=" + libraryinfo + '}';
    }

    //Caution: pass new parameters on call, if new parameter = old parameter, pass old parameter
    public static void DBUpdate(String username, PrintWriter out, String password, String firstname, String lastname,
            Date birthdate, String gender, String personalpage, String country, String city, String address, String libraryinfo, String telephone) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("update librarians set password=?, firstname=?, lastname=?, birthdate=?, gender=?,"
                    + "personalpage=?, country=?, city=?, address=?, libraryinfo=?, telephone=? where username=?");
            ps.setString(1, password);
            ps.setString(2, firstname);
            ps.setString(3, lastname);
            ps.setDate(4, birthdate == null ? null : new java.sql.Date(birthdate.getTime()));
            ps.setString(5, gender);
            ps.setString(6, personalpage);
            ps.setString(7, country);
            ps.setString(8, city);
            ps.setString(9, address);
            ps.setString(10, libraryinfo);
            ps.setString(11, telephone);
            ps.setString(12, username);

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Library manager with username " + username + " successfully updated.");
            } else {
                out.println("Status code 400 - Bad request - Message: Specified username doesn't exist.");
                throw new SQLException();
            }
            ps.close();
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
    }

    public static void DBInsert(LibraryManager librarian, PrintWriter out) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("insert into librarians values(default,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, librarian.getUsername());
            ps.setString(2, librarian.getEmail());
            ps.setString(3, librarian.getPassword());
            ps.setString(4, librarian.getFirstname());
            ps.setString(5, librarian.getLastname());
            ps.setDate(6, new java.sql.Date(librarian.getBirthdate().getTime()));
            ps.setString(7, librarian.getGender());
            ps.setString(8, librarian.getCountry());
            ps.setString(9, librarian.getCity());
            ps.setString(10, librarian.getAddress());
            ps.setString(11, librarian.getLibraryname());
            ps.setString(12, librarian.getLibraryinfo());
            if (librarian.getLat() == null) {
                ps.setNull(13, Types.DOUBLE);
            } else {
                ps.setDouble(13, librarian.getLat());
            }
            if (librarian.getLon() == null) {
                ps.setNull(14, Types.DOUBLE);
            } else {
                ps.setDouble(14, librarian.getLon());
            }
            ps.setString(15, librarian.getTelephone());
            ps.setString(16, librarian.getPersonalpage());

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Library manager with username " + librarian.getUsername() + " successfully added.");
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

    public static String DBDelete(String username, PrintWriter out) {
        String res = null;
        try {

            Database database0 = new Database(out);
            Database database1 = new Database(out);
            Database database2 = new Database(out);

            PreparedStatement ps0 = database0.prepareStatement("delete from borrowing where bookcopy_id=?");
            PreparedStatement ps1 = database1.prepareStatement("delete from booksinlibraries where library_id=?");
            PreparedStatement ps2 = database2.prepareStatement("delete from librarians where username=?");

            ResultSet result0 = database0.executeStatement("select library_id as lid from librarians where username='" + username + "'");

            Integer library_id = null;
            while (result0.next()) {
                library_id = result0.getInt("lid");
                ResultSet result1 = database1.executeStatement("select bookcopy_id as bcid from booksinlibraries where library_id='" + library_id + "'");
                while (result1.next()) {
                    ps0.setInt(1, result1.getInt("bcid"));
                    ps0.addBatch();
                }
                ps0.executeBatch();
            }

            ps1.setInt(1, library_id);
            ps2.setString(1, username);

            if (ps1.executeUpdate() >= 0 && ps2.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Library manager with username " + username + " successfully removed.");
                res = "/admin/admin.jsp";
            } else {
                throw new SQLException();
            }
            ps0.close();
            ps1.close();
            ps2.close();
            database0.close();
            database1.close();
            database2.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return res;
    }
}
