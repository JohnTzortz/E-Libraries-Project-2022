package classes;

import java.util.Date;

public class User {
    protected String username;
    protected String email;
    protected String password;
    protected String firstname;
    protected String lastname;
    protected String gender;
    protected Date birthdate;
    protected String country;
    protected String city;
    protected String address;
    protected String telephone;
    protected String personalpage;
    protected Double lat;
    protected Double lon;

    public User(String username, String email, String password, String firstname, String lastname, String gender, Date birthdate, String country,
            String city, String address, String telephone, String personalpage, Double lat, Double lon) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.firstname = firstname;
        this.lastname = lastname;
        this.gender = gender;
        this.birthdate = birthdate;
        this.country = country;
        this.city = city;
        this.address = address;
        this.telephone = telephone;
        this.personalpage = personalpage;
        this.lat = lat;
        this.lon = lon;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Date birthdate) {
        this.birthdate = birthdate;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getPersonalpage() {
        return personalpage;
    }

    public void setPersonalpage(String personalpage) {
        this.personalpage = personalpage;
    }

    public Double getLat() {
        return lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    public Double getLon() {
        return lon;
    }

    public void setLon(Double lon) {
        this.lon = lon;
    }

    @Override
    public String toString() {
        return "User{" + "username=" + username + ", email=" + email + ", password=" + password + ", firstname=" + firstname + ", lastname=" + lastname
                + ", gender=" + gender + ", birthdate=" + birthdate + ", country=" + country + ", city=" + city + ", address=" + address
                + ", telephone=" + telephone + ", personalpage=" + personalpage + ", latitude=" + lat + ", longitude=" + lon + '}';
    }
}
