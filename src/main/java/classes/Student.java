package classes;

import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;

public class Student extends User {
    private String student_id;
    private Date student_id_from_date;
    private Date student_id_to_date;
    private String university;
    private String department;
    private String student_type;

    public Student(String username, String email, String password, String firstname, String lastname, Date birthdate, String gender,
            String country, String city, String address, String student_type, String student_id, Date student_id_from_date,
            Date student_id_to_date, String university, String department, Double lat, Double lon, String telephone, String personalpage) {
        super(username, email, password, firstname, lastname, gender, birthdate, country, city, address, telephone, personalpage, lat, lon);
        this.student_id = student_id;
        this.student_id_from_date = student_id_from_date;
        this.student_id_to_date = student_id_to_date;
        this.university = university;
        this.department = department;
        this.student_type = student_type;
    }

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public Date getStudent_id_from_date() {
        return student_id_from_date;
    }

    public void setStudent_id_from_date(Date student_id_from_date) {
        this.student_id_from_date = student_id_from_date;
    }

    public Date getStudent_id_to_date() {
        return student_id_to_date;
    }

    public void setStudent_id_to_date(Date student_id_to_date) {
        this.student_id_to_date = student_id_to_date;
    }

    public String getUniversity() {
        return university;
    }

    public void setUniversity(String university) {
        this.university = university;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getStudent_type() {
        return student_type;
    }

    public void setStudent_type(String student_type) {
        this.student_type = student_type;
    }

    @Override
    public String toString() {
        return super.toString() + "Student{" + "student_id=" + student_id + ", student_id_from_date=" + student_id_from_date + ", student_id_to_date=" + student_id_to_date + ", university="
                + university + ", department=" + department + ", student_type=" + student_type + '}';
    }

    //Caution: pass new parameters on call, if new parameter = old parameter, pass old parameter
    public static void DBUpdate(String username, PrintWriter out, String password, String firstname, String lastname,
            Date birthdate, String gender, String personalpage, String country, String city, String address, String telephone) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("update students set password=?, firstname=?, lastname=?, birthdate=?, gender=?,"
                    + "personalpage=?, country=?, city=?, address=?, telephone=? where username=?");
            ps.setString(1, password);
            ps.setString(2, firstname);
            ps.setString(3, lastname);
            ps.setDate(4, birthdate == null ? null : new java.sql.Date(birthdate.getTime()));
            ps.setString(5, gender);
            ps.setString(6, personalpage);
            ps.setString(7, country);
            ps.setString(8, city);
            ps.setString(9, address);
            ps.setString(10, telephone);
            ps.setString(11, username);

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Student with username " + username + " successfully updated.");
            } else {
                out.println("Status code 400 - Bad request - Message: Specified username doesn't exist.");
            }
            ps.close();
            database.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
    }

    public static void DBInsert(Student student, PrintWriter out) {
        try {
            Database database = new Database(out);
            PreparedStatement ps = database.prepareStatement("insert into students values(default,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, student.getUsername());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPassword());
            ps.setString(4, student.getFirstname());
            ps.setString(5, student.getLastname());
            ps.setDate(6, student.getBirthdate() == null ? null : new java.sql.Date(student.getBirthdate().getTime()));
            ps.setString(7, student.getGender());
            ps.setString(8, student.getCountry());
            ps.setString(9, student.getCity());
            ps.setString(10, student.getAddress());
            ps.setString(11, student.getStudent_type());
            ps.setString(12, student.getStudent_id());
            ps.setDate(13, student.getStudent_id_from_date() == null ? null : new java.sql.Date(student.getStudent_id_from_date().getTime()));
            ps.setDate(14, student.getStudent_id_to_date() == null ? null : new java.sql.Date(student.getStudent_id_to_date().getTime()));
            ps.setString(15, ((Student) student).getUniversity());
            ps.setString(16, ((Student) student).getDepartment());
            if (student.getLat() == null) {
                ps.setNull(17, Types.DOUBLE);
            } else {
                ps.setDouble(17, student.getLat());
            }
            if (student.getLon() == null) {
                ps.setNull(18, Types.DOUBLE);
            } else {
                ps.setDouble(18, student.getLon());
            }
            ps.setString(19, student.getTelephone());
            ps.setString(20, student.getPersonalpage());

            if (ps.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Student with username " + student.getUsername() + " successfully added.");
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
        String ret = null;
        try {

            Database database0 = new Database(out);
            Database database1 = new Database(out);

            ResultSet result0 = database0.executeStatement("select user_id as sid from students where username='" + username + "'");
            result0.next();
            Integer user_id = result0.getInt("sid");

            PreparedStatement ps0 = database0.prepareStatement("delete from borrowing where user_id=?");
            ps0.setInt(1, user_id);

            PreparedStatement ps1 = database1.prepareStatement("delete from students where username=?");
            ps1.setString(1, username);

            if (ps0.executeUpdate() >= 0 && ps1.executeUpdate() > 0) {
                out.println("Status code 200 - OK - Message: Student with username " + username + " successfully removed.");
                ret = "/admin/admin.jsp";
            } else {
                throw new SQLException();
            }
            ps0.close();
            ps1.close();
            database0.close();
            database1.close();
        } catch (SQLException ex) {
            out.println("Status code 500 - Internal server error - SQLException");
            ex.printStackTrace();
        }
        return ret;
    }
}
