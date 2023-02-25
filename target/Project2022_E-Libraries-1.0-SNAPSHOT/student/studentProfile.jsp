<%@page import="classes.Student"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="classes.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta name="desc" content="">
        <meta name="keywords" content="HTML, CSS, JS">
        <link rel="stylesheet" href="/Project2022_E-Libraries/student/studentProfile.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body>
        <% 
            if(session.getAttribute("type") == null)
            {
                session.setAttribute("type", "");
            }
            if(session.getAttribute("savedusername") == null)
            {
                session.setAttribute("savedusername", "");
            }
            
            if(!session.getAttribute("type").equals("student"))
                response.sendRedirect("/Project2022_E-Libraries/index.jsp");
        %>
        <%
            Student student = null;       
            PrintWriter pw = response.getWriter();
            Database database = new Database(pw);
            ResultSet result = database.executeStatement("select * from students");
            while (result.next()) {
                    if (session.getAttribute("savedusername").equals(result.getString("username"))) {
                        student = new Student(
                        result.getString("username"), 
                        result.getString("email"), 
                        result.getString("password"),
                        result.getString("firstname"), 
                        result.getString("lastname"), 
                        result.getDate("birthdate"),
                        result.getString("gender"),
                        result.getString("country"), 
                        result.getString("city"), 
                        result.getString("address"),
                        result.getString("student_type"),
                        result.getString("student_id"), 
                        result.getDate("student_id_from_date"), 
                        result.getDate("student_id_to_date"),
                        result.getString("university"), 
                        result.getString("department"), 
                        result.getDouble("lat"), 
                        result.getDouble("lon"),
                        result.getString("telephone"), 
                        result.getString("personalpage")
                        );
                        break;
                    }
                }   
            database.close();
        %>
        
        <!-- απο εδω και κατω κωδικας html. Για να γίνει access στα ήδη υπάρχοντα δεδομένα πρέπει να γίνει μέσω getters 
        με το παρακάτω συντακτικό πχ μεσα σε μια  html form
        
        <input id="email" name="email" type="email" value= <%= student.getEmail() %> readonly><br>
        
        -->
        
        <button id="edit">Edit profile</button><br>
        <form id="studentUpdate" method="post" action="studentUpdate">
            <fieldset id="fields" disabled="disabled">
                <label for="username">Username:</label><br>
                    <input id="username" name="username" type="text" value= <%= student.getUsername() %> readonly><br>
                <label for="email">e-mail:</label><br>
                    <input id="email" name="email" type="email" value= <%= student.getEmail() %> readonly><br>
                <label for="newPassword">New password:</label><br>
                    <input id="newPassword" name="newPassword" type="password" pattern="^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,12}$">
                <label for="showPasswords">Show passwords</label>
                    <input id="showPasswords" name="showPasswords" type="checkbox">
                <label for="showNewPasswordStrength">&nbsp;&nbsp;Show new password strength</label>
                    <input id="showNewPasswordStrength" name="showNewPasswordStrength" type="checkbox"><br>
                <label for="verifyNewPassword">Verify new password:</label><br>
                    <input id="verifyNewPassword" name="verifyNewPassword" type="password"><br>
                <label id="passwordStrength"></label><br>
                <label for="firstname">First Name:</label><br>
                    <input id="firstname" name="firstname" type="text" minlength="3" maxlength="30" required value= <%= student.getFirstname() %>><br>
                <label for="lastname">Last Name:</label><br>
                    <input id="lastname" name="lastname" type="text" minlength="3" maxlength="30" required value= <%= student.getLastname() %>><br>
                <label for="birthdate">Date of Birth:</label><br>
                    <input id="birthdate" name="birthdate" type="date" value=<%= student.getBirthdate() %> min="1920-01-01" max="2006-12-31" required><br>
                <label>Gender:</label>
                <%
                    switch(student.getGender()){
                        case "Male" :
                %>
                    <input id="male" name="gender" value="Male" type="radio" checked>
                <label for="Male">Male</label>
                    <input id="female" name="gender" value="Female" type="radio">
                <label for="Female">Female</label>
                    <input id="other" name="gender" value="Other" type="radio">
                <label for="Other">Other</label><br>
                <%
                            break;
                        case "Female":
                %>
                    <input id="male" name="gender" value="Male" type="radio">
                <label for="Male">Male</label>
                    <input id="female" name="gender" value="Female" type="radio" checked>
                <label for="Female">Female</label>
                    <input id="other" name="gender" value="Other" type="radio">
                <label for="Other">Other</label><br>
                <%
                            break;
                        case "Other":
                %>
                <input id="male" name="gender" value="Male" type="radio">
                    <label for="Male">Male</label>
                <input id="female" name="gender" value="Female" type="radio">
                    <label for="Female">Female</label>
                <input id="other" name="gender" value="Other" type="radio" checked>
                    <label for="Other">Other</label><br>
                <%
                            break;
                   }
                %>
                <label>Student Type:</label>
                <%
                    switch(student.getStudent_type()){
                        case "BSc":
                %>
                    <input id="BSc" name="student_type" value="BSc" type="radio" checked disabled>
                <label for="BSc">BSc</label>
                    <input id="MSc" name="student_type" value="MSc" type="radio" disabled>
                <label for="MSc">MSc</label>
                    <input id="PhD" name="student_type" value="PhD" type="radio" disabled>
                <label for="PhD">PhD</label><br>
                <%
                            break;
                        case "MSc":
                %>
                    <input id="BSc" name="student_type" value="BSc" type="radio" disabled>
                <label for="BSc">BSc</label>
                    <input id="MSc" name="student_type" value="MSc" type="radio" checked disabled>
                <label for="MSc">MSc</label>
                    <input id="PhD" name="student_type" value="PhD" type="radio" disabled>
                <label for="PhD">PhD</label><br>
                <%
                            break;
                        case "PhD":
                %>
                    <input id="BSc" name="student_type" value="BSc" type="radio" disabled>
                <label for="BSc">BSc</label>
                    <input id="MSc" name="student_type" value="MSc" type="radio" readonly>
                <label for="MSc">MSc</label>
                    <input id="PhD" name="student_type" value="PhD" type="radio" checked disabled>
                <label for="PhD">PhD</label><br>
                <%
                            break;
                   }
                %>
                <label for="student_id">Student ID Number:</label><br>
                <input id="student_id" name="student_id" type="number" min="100000000000" max="999999999999" value = <%= student.getStudent_id() %> readonly><br>
                <label for="student_id_from_date">Student card start date:</label><br>
                <input type="date" id="student_id_from_date" name="student_id_from_date" min="2016-01-01" value=<%= student.getStudent_id_from_date() %> readonly><br>
                <label for="student_id_to_date">Student card end date:</label><br>
                <input type="date" id="student_id_to_date" name="student_id_to_date" min="2023-01-01" value=<%= student.getStudent_id_to_date() %> readonly><br>
                <label>University:</label>
                <%
                    switch(student.getUniversity()){
                        case "UOC":
                %>
                    <input type="radio" id="UOC" name="university" value="UOC" disabled checked>
                <label for="UOC">UOC</label>
                    <input type="radio" id="HELMEPA" name="university" value="HELMEPA" disabled>
                <label for="HELMEPA">HELMEPA</label>
                    <input type="radio" id="TUC" name="university" value="TUC" disabled>
                <label for="TUC">TUC</label><br>
                <%
                            break;
                        case "HELMEPA":
                %>
                    <input type="radio" id="UOC" name="university" value="UOC" disabled>
                <label for="UOC">UOC</label>
                    <input type="radio" id="HELMEPA" name="university" value="HELMEPA" checked disabled>
                <label for="HELMEPA">HELMEPA</label>
                    <input type="radio" id="TUC" name="university" value="TUC" disabled>
                <label for="TUC">TUC</label><br>
                <%
                            break;
                        case "TUC":
                %>
                    <input type="radio" id="UOC" name="university" value="UOC" disabled>
                <label for="UOC">UOC</label>
                    <input type="radio" id="HELMEPA" name="university" value="HELMEPA" disabled>
                <label for="HELMEPA">HELMEPA</label>
                    <input type="radio" id="TUC" name="university" value="TUC" disabled checked>
                <label for="TUC">TUC</label><br>
                <%
                            break;
                   }
                %>
                <label for="department">Department:</label><br>
                    <input type="text" id="department" name="department" minlength="3" maxlength="50" readonly value = <%= student.getDepartment() %>><br>
                <label for="personalpage">Personal page:</label><br>
                    <input type="url" id="personalpage" name="personalpage" value = <%= student.getPersonalpage() == null ? "" : student.getPersonalpage() %>><br>
                <label for="country">Country:</label><br> 
                <select id="country" name="country">
                    <option selected value = <%= student.getCountry() %>><%= student.getCountry() %></option>
                    <option value="GR">Greece</option>
                    <option value="AF">Afghanistan</option>
                    <option value="AX">Aland Islands</option>
                    <option value="AL">Albania</option>
                    <option value="DZ">Algeria</option>
                    <option value="AS">American Samoa</option>
                    <option value="AD">Andorra</option>
                    <option value="AO">Angola</option>
                    <option value="AI">Anguilla</option>
                    <option value="AQ">Antarctica</option>
                    <option value="AG">Antigua and Barbuda</option>
                    <option value="AR">Argentina</option>
                    <option value="AM">Armenia</option>
                    <option value="AW">Aruba</option>
                    <option value="AU">Australia</option>
                    <option value="AT">Austria</option>
                    <option value="AZ">Azerbaijan</option>
                    <option value="BS">Bahamas</option>
                    <option value="BH">Bahrain</option>
                    <option value="BD">Bangladesh</option>
                    <option value="BB">Barbados</option>
                    <option value="BY">Belarus</option>
                    <option value="BE">Belgium</option>
                    <option value="BZ">Belize</option>
                    <option value="BJ">Benin</option>
                    <option value="BM">Bermuda</option>
                    <option value="BT">Bhutan</option>
                    <option value="BO">Bolivia</option>
                    <option value="BQ">Bonaire, Sint Eustatius and Saba</option>
                    <option value="BA">Bosnia and Herzegovina</option>
                    <option value="BW">Botswana</option>
                    <option value="BV">Bouvet Island</option>
                    <option value="BR">Brazil</option>
                    <option value="IO">British Indian Ocean Territory</option>
                    <option value="BN">Brunei Darussalam</option>
                    <option value="BG">Bulgaria</option>
                    <option value="BF">Burkina Faso</option>
                    <option value="BI">Burundi</option>
                    <option value="KH">Cambodia</option>
                    <option value="CM">Cameroon</option>
                    <option value="CA">Canada</option>
                    <option value="CV">Cape Verde</option>
                    <option value="KY">Cayman Islands</option>
                    <option value="CF">Central African Republic</option>
                    <option value="TD">Chad</option>
                    <option value="CL">Chile</option>
                    <option value="CN">China</option>
                    <option value="CX">Christmas Island</option>
                    <option value="CC">Cocos (Keeling) Islands</option>
                    <option value="CO">Colombia</option>
                    <option value="KM">Comoros</option>
                    <option value="CG">Congo</option>
                    <option value="CD">Congo, Democratic Republic of the Congo</option>
                    <option value="CK">Cook Islands</option>
                    <option value="CR">Costa Rica</option>
                    <option value="CI">Cote D'Ivoire</option>
                    <option value="HR">Croatia</option>
                    <option value="CU">Cuba</option>
                    <option value="CW">Curacao</option>
                    <option value="CY">Cyprus</option>
                    <option value="CZ">Czech Republic</option>
                    <option value="DK">Denmark</option>
                    <option value="DJ">Djibouti</option>
                    <option value="DM">Dominica</option>
                    <option value="DO">Dominican Republic</option>
                    <option value="EC">Ecuador</option>
                    <option value="EG">Egypt</option>
                    <option value="SV">El Salvador</option>
                    <option value="GQ">Equatorial Guinea</option>
                    <option value="ER">Eritrea</option>
                    <option value="EE">Estonia</option>
                    <option value="ET">Ethiopia</option>
                    <option value="FK">Falkland Islands (Malvinas)</option>
                    <option value="FO">Faroe Islands</option>
                    <option value="FJ">Fiji</option>
                    <option value="FI">Finland</option>
                    <option value="FR">France</option>
                    <option value="GF">French Guiana</option>
                    <option value="PF">French Polynesia</option>
                    <option value="TF">French Southern Territories</option>
                    <option value="GA">Gabon</option>
                    <option value="GM">Gambia</option>
                    <option value="GE">Georgia</option>
                    <option value="DE">Germany</option>
                    <option value="GH">Ghana</option>
                    <option value="GI">Gibraltar</option>
                    <option value="GL">Greenland</option>
                    <option value="GD">Grenada</option>
                    <option value="GP">Guadeloupe</option>
                    <option value="GU">Guam</option>
                    <option value="GT">Guatemala</option>
                    <option value="GG">Guernsey</option>
                    <option value="GN">Guinea</option>
                    <option value="GW">Guinea-Bissau</option>
                    <option value="GY">Guyana</option>
                    <option value="HT">Haiti</option>
                    <option value="HM">Heard Island and Mcdonald Islands</option>
                    <option value="VA">Holy See (Vatican City State)</option>
                    <option value="HN">Honduras</option>
                    <option value="HK">Hong Kong</option>
                    <option value="HU">Hungary</option>
                    <option value="IS">Iceland</option>
                    <option value="IN">India</option>
                    <option value="ID">Indonesia</option>
                    <option value="IR">Iran, Islamic Republic of</option>
                    <option value="IQ">Iraq</option>
                    <option value="IE">Ireland</option>
                    <option value="IM">Isle of Man</option>
                    <option value="IL">Israel</option>
                    <option value="IT">Italy</option>
                    <option value="JM">Jamaica</option>
                    <option value="JP">Japan</option>
                    <option value="JE">Jersey</option>
                    <option value="JO">Jordan</option>
                    <option value="KZ">Kazakhstan</option>
                    <option value="KE">Kenya</option>
                    <option value="KI">Kiribati</option>
                    <option value="KP">Korea, Democratic People's Republic of</option>
                    <option value="KR">Korea, Republic of</option>
                    <option value="XK">Kosovo</option>
                    <option value="KW">Kuwait</option>
                    <option value="KG">Kyrgyzstan</option>
                    <option value="LA">Lao People's Democratic Republic</option>
                    <option value="LV">Latvia</option>
                    <option value="LB">Lebanon</option>
                    <option value="LS">Lesotho</option>
                    <option value="LR">Liberia</option>
                    <option value="LY">Libyan Arab Jamahiriya</option>
                    <option value="LI">Liechtenstein</option>
                    <option value="LT">Lithuania</option>
                    <option value="LU">Luxembourg</option>
                    <option value="MO">Macao</option>
                    <option value="MK">Macedonia, the Former Yugoslav Republic of</option>
                    <option value="MG">Madagascar</option>
                    <option value="MW">Malawi</option>
                    <option value="MY">Malaysia</option>
                    <option value="MV">Maldives</option>
                    <option value="ML">Mali</option>
                    <option value="MT">Malta</option>
                    <option value="MH">Marshall Islands</option>
                    <option value="MQ">Martinique</option>
                    <option value="MR">Mauritania</option>
                    <option value="MU">Mauritius</option>
                    <option value="YT">Mayotte</option>
                    <option value="MX">Mexico</option>
                    <option value="FM">Micronesia, Federated States of</option>
                    <option value="MD">Moldova, Republic of</option>
                    <option value="MC">Monaco</option>
                    <option value="MN">Mongolia</option>
                    <option value="ME">Montenegro</option>
                    <option value="MS">Montserrat</option>
                    <option value="MA">Morocco</option>
                    <option value="MZ">Mozambique</option>
                    <option value="MM">Myanmar</option>
                    <option value="NA">Namibia</option>
                    <option value="NR">Nauru</option>
                    <option value="NP">Nepal</option>
                    <option value="NL">Netherlands</option>
                    <option value="AN">Netherlands Antilles</option>
                    <option value="NC">New Caledonia</option>
                    <option value="NZ">New Zealand</option>
                    <option value="NI">Nicaragua</option>
                    <option value="NE">Niger</option>
                    <option value="NG">Nigeria</option>
                    <option value="NU">Niue</option>
                    <option value="NF">Norfolk Island</option>
                    <option value="MP">Northern Mariana Islands</option>
                    <option value="NO">Norway</option>
                    <option value="OM">Oman</option>
                    <option value="PK">Pakistan</option>
                    <option value="PW">Palau</option>
                    <option value="PS">Palestinian Territory, Occupied</option>
                    <option value="PA">Panama</option>
                    <option value="PG">Papua New Guinea</option>
                    <option value="PY">Paraguay</option>
                    <option value="PE">Peru</option>
                    <option value="PH">Philippines</option>
                    <option value="PN">Pitcairn</option>
                    <option value="PL">Poland</option>
                    <option value="PT">Portugal</option>
                    <option value="PR">Puerto Rico</option>
                    <option value="QA">Qatar</option>
                    <option value="RE">Reunion</option>
                    <option value="RO">Romania</option>
                    <option value="RU">Russian Federation</option>
                    <option value="RW">Rwanda</option>
                    <option value="BL">Saint Barthelemy</option>
                    <option value="SH">Saint Helena</option>
                    <option value="KN">Saint Kitts and Nevis</option>
                    <option value="LC">Saint Lucia</option>
                    <option value="MF">Saint Martin</option>
                    <option value="PM">Saint Pierre and Miquelon</option>
                    <option value="VC">Saint Vincent and the Grenadines</option>
                    <option value="WS">Samoa</option>
                    <option value="SM">San Marino</option>
                    <option value="ST">Sao Tome and Principe</option>
                    <option value="SA">Saudi Arabia</option>
                    <option value="SN">Senegal</option>
                    <option value="RS">Serbia</option>
                    <option value="CS">Serbia and Montenegro</option>
                    <option value="SC">Seychelles</option>
                    <option value="SL">Sierra Leone</option>
                    <option value="SG">Singapore</option>
                    <option value="SX">Sint Maarten</option>
                    <option value="SK">Slovakia</option>
                    <option value="SI">Slovenia</option>
                    <option value="SB">Solomon Islands</option>
                    <option value="SO">Somalia</option>
                    <option value="ZA">South Africa</option>
                    <option value="GS">South Georgia and the South Sandwich Islands</option>
                    <option value="SS">South Sudan</option>
                    <option value="ES">Spain</option>
                    <option value="LK">Sri Lanka</option>
                    <option value="SD">Sudan</option>
                    <option value="SR">Suriname</option>
                    <option value="SJ">Svalbard and Jan Mayen</option>
                    <option value="SZ">Swaziland</option>
                    <option value="SE">Sweden</option>
                    <option value="CH">Switzerland</option>
                    <option value="SY">Syrian Arab Republic</option>
                    <option value="TW">Taiwan, Province of China</option>
                    <option value="TJ">Tajikistan</option>
                    <option value="TZ">Tanzania, United Republic of</option>
                    <option value="TH">Thailand</option>
                    <option value="TL">Timor-Leste</option>
                    <option value="TG">Togo</option>
                    <option value="TK">Tokelau</option>
                    <option value="TO">Tonga</option>
                    <option value="TT">Trinidad and Tobago</option>
                    <option value="TN">Tunisia</option>
                    <option value="TR">Turkey</option>
                    <option value="TM">Turkmenistan</option>
                    <option value="TC">Turks and Caicos Islands</option>
                    <option value="TV">Tuvalu</option>
                    <option value="UG">Uganda</option>
                    <option value="UA">Ukraine</option>
                    <option value="AE">United Arab Emirates</option>
                    <option value="GB">United Kingdom</option>
                    <option value="US">United States</option>
                    <option value="UM">United States Minor Outlying Islands</option>
                    <option value="UY">Uruguay</option>
                    <option value="UZ">Uzbekistan</option>
                    <option value="VU">Vanuatu</option>
                    <option value="VE">Venezuela</option>
                    <option value="VN">Viet Nam</option>
                    <option value="VG">Virgin Islands, British</option>
                    <option value="VI">Virgin Islands, U.s.</option>
                    <option value="WF">Wallis and Futuna</option>
                    <option value="EH">Western Sahara</option>
                    <option value="YE">Yemen</option>
                    <option value="ZM">Zambia</option>
                    <option value="ZW">Zimbabwe</option>
                </select><br>  
                <label for="city">City:</label><br>
                    <input type="text" id="city" name="city" minlength="3" maxlength="50" required value = <%= student.getCity() %>><br>
                <label for="address">Address:</label><br>
                    <input type="text" id="address" name="address" minlength="3" maxlength="50" required value = <%= student.getAddress() %>><br>
                <label for="telephone">Telephone Number:</label><br>
                    <input type="tel" id="telephone" name="telephone" minlength="10" maxlength="14" value = <%= student.getTelephone() %>><br>
                <label for="oldPassword">Current password:</label><br>
                    <input id="oldPassword" name="oldPassword" type="password" required><br>
                <br>
                    <input class="coords" id="lat" name="lat" type="text">
                    <input class="coords" id="lon" name="lon" type="text">
                    <input type ="submit" value="Update Info">
            </fieldset>
        </form>
        
        <script src="/Project2022_E-Libraries/functions.js"></script>
        <script src="/Project2022_E-Libraries/student/studentProfile.js"></script>
    </body>
</html>
