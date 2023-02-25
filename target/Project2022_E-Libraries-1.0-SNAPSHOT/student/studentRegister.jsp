<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta name="desc" content="">
        <meta name="keywords" content="HTML, CSS, JS">
        <link rel="stylesheet" href="studentRegister.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    
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
            
            if(session.getAttribute("type").equals("student"))
                response.sendRedirect("student.jsp");
            else if(session.getAttribute("type").equals("librarian"))
                response.sendRedirect("librarian.jsp");
        %>
        
        <!-- απο εδω και κατω κωδικας html. -->

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <a class="navbar-brand" href="#">HY359</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
              <li class="nav-item active">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">Loggin</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">Logout</a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  Other
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                  <a class="dropdown-item" href="#">Action 1</a>
                  <a class="dropdown-item" href="#">Action 2</a>
                  <a class="dropdown-item" href="#">Action 3</a>
                </div>
              </li>
            </ul>
          </div>
        </nav>




<!---   ../../java/servlets/students/fortest.java   --->

         <form action="../../java/servlets/students/fortest.java" method="POST" class="my-form" onsubmit="return checkSub();">
                <legend>
                    <center>
                        <h2><b>Registration Form </b>(Student)</h2>
                        <h5 id="step">Step 1</h5>
                    </center>
                </legend><br>



                <div class="form-group" id="usernameDivId">
                    <label class="col-md-4 control-label"><p class="red_star">*</p>Username</label>
                    <div class="col-md-6 inputGroupContainer">
                      <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="username_id" name="username" placeholder="e.g. HelloWorld" class="form-control" type="text">
                      </div>
                        <p id="username_error_p" style="color: red;"></p>
                    </div>
                  </div>

                  <div class="form-group" id="emailDivId">
                    <label class="col-md-4 control-label"><p class="red_star">*</p>E-Mail</label>
                    <div class="col-md-6 inputGroupContainer">
                      <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                        <input id="email_id" name="email" placeholder="e.g. csd4448@csd.uoc.gr" class="form-control" type="text">
                      </div>
                      <p id="email_p" style="color: red;"></p>
                    </div>
                  </div>

                  <div class="form-group" id="passwordDivId">
                    <label class="col-md-8 control-label"><p class="red_star">*</p>Password <small>(button: strength calculation)</small></label>
                    <div class="col-md-6 inputGroupContainer">
                      <div class="input-group mb-3">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input name="password" id="user_pass" type="password" class="form-control" placeholder="Password">
                        <button class="btn btn-danger" type="button" id="strength-button1">None</button>
                        <i id="visibilityButton1"><span id="icon_visibility1" class="material-symbols-outlined">visibility_off</span></i>
                      </div>
                      <p id="notMatching" style="color: red;"></p>
                    </div>
                  </div>

                  <div class="form-group" id="passwordConfirmDivId">
                    <label class="col-md-4 control-label"><p class="red_star">*</p>Confirm Password</label>
                    <div class="col-md-6 inputGroupContainer">
                      <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input name="confirm_password" id="confirm_pass" placeholder="Confirm Password" class="form-control" type="password">
                        <button class="btn btn-danger" type="button" id="strength-button2">None</button>
                        <i id="visibilityButton2"><span class="material-symbols-outlined" id="icon_visibility2">visibility_off</span></i>
                      </div>
                    </div>
                  </div>





                  <div class="form-group" id="firstNameDivId" >
                    <label class="col-md-6 control-label"><p class="red_star">*</p>First Name</label>
                    <div class="col-md-6 inputGroupContainer">
                      <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="first_name" name="firstname" placeholder="e.g. Giannis" class="form-control" type="text" pattern="[A-Za-z]{3,30}" required>
                      </div>
                    </div>
                  </div>

                  <div class="form-group" id="lastNameDivId" >
                    <label class="col-md-6 control-label"><p class="red_star">*</p>Last Name</label>
                    <div class="col-md-6 inputGroupContainer">
                      <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="last_name" name="lastname" placeholder="e.g. Tzortzakis" class="form-control" type="text" pattern="[A-Za-z]{3,30}" required>
                      </div>
                    </div>
                  </div>

                <div class="form-group" id="birthdayDivId" >
                    <label for="date_birth" class="col-md-6 control-label"><p class="red_star">*</p>Date of Birth</label>
                    <input type="date" name="birthdate" id="date_birth_id" value="1980-01-01" min="1920-01-01" max="2006-12-31" required>
                </div>

                <div id="genderDivId" >
                    <label for="gender" class="control-label col-md-6"><p class="red_star">*</p>Gender</label>
                    <label class="radio-inline">
                      <input type="radio" name="gender" id="gender_male" value="male" required>Male
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="gender" id="gender_female" value="female">Female
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="gender" id="gender_other" value="other">Other
                    </label>
                </div>





                
                <div class="form-group" id="studentTypeDivId">
                  <label class="col-md-6 control-label"><p class="red_star">*</p>Student Type</label>
                  <div class="col-md-6 selectContainer">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
                      <select name="student_type" class="form-control selectpicker" id="typeSt">
                        <option value="ugrad">Undergraduate Student</option>
                        <option value="pgrad">Postgraduate Student</option>
                        <option value="phd">PHD Student</option>
                      </select>
                    </div>
                  </div>
                </div>

                <div class="form-group" id="academic_id">
                    <label class="col-md-8 control-label"><p class="red_star">*</p>Academic ID redistration number</label>
                    <div class="col-md-6 inputGroupContainer">
                      <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                        <input name="student_id" id="academicID_id" placeholder="e.g. 210425880809" class="form-control" type="text" pattern="^\d{12}$">
                      </div>
                    </div>
                </div>

                <div class="form-group" id="ID_reg">
                    <label for="academic_start" class="col-md-6 control-label" style="color: black;"><p class="red_star">*</p>Academic ID registered on</label>
                    <input type="date" name="student_id_from_date" min="2006-01-01" id="ID_start">
                    <p id="date_p" style="color: red;"></p>
                </div>
      
              <div class="form-group" id="ID_exp">
                <label for="academic_end" class="col-md-6 control-label"><p class="red_star">*</p>Academic ID expires on</label>
                <input type="date" name="student_id_to_date" min="2023-01-01" id="ID_end">
              </div>

              <div class="form-group" id="sxolh">
                <label class="col-md-8 control-label"><p class="red_star">*</p>Higher Education College (In Crete)</label>
                <div class="col-md-6 selectContainer">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
                    <select name="university" class="form-control selectpicker" id="uni_id">
                      <option value="uoc">UoC</option>
                      <option value="helmepa">HELMEPA</option>
                      <option value="tuc">TUC</option>
                    </select>
                  </div>
                </div>
              </div>

              <div class="form-group col-md-6" id="dep">
                <label for="exampleFormControlTextarea1"><p class="red_star">*</p>Name of Department</label>
                <input name="department" id="department_name_id" placeholder="e.g. Computer Science Department" class="form-control" type="text" pattern="[A-Za-z ]{3,50}">
              </div>
            </div>

            <div class="form-group" id="personalSiteDivId">
                <label class="col-md-8 control-label">Personal Site (LinkedIn, Facebook, Instagram)</label>
                <div class="col-md-6 inputGroupContainer">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                    <input name="personalpage" id="personalPage" placeholder="www.linkedin.com/in/john-tzortzakis" class="form-control" type="text" pattern="https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)">
                  </div>
                </div>
              </div>

              <div class="form-group" id="contactDivId">
                <label class="col-md-6 control-label"><p class="red_star">*</p>Contact No.</label>
                <div class="col-md-6 inputGroupContainer">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                    <input name="telephone" id="telephone" placeholder="e.g. 6942858582" class="form-control" type="text"  pattern="[0-9]{10,14}">
                  </div>
                </div>
              </div>




              <input type="hidden" id="lat_id" name="lat" value="">
              <input type="hidden" id="lon_id" name="lon" value="">


              <div class="form-group" id="countryDivId">
                <label class="col-md-6 control-label">Country</label>
                <div class="col-md-6 selectContainer">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
                    <select name="country" class="form-control selectpicker" id="country">
                      <option value="Afghanistan">Afghanistan</option>
                      <option value="Aland Islands">Aland Islands</option>
                      <option value="Albania">Albania</option>
                      <option value="Algeria">Algeria</option>
                      <option value="American Samoa">American Samoa</option>
                      <option value="Andorra">Andorra</option>
                      <option value="Angola">Angola</option>
                      <option value="Anguilla">Anguilla</option>
                      <option value="Antarctica">Antarctica</option>
                      <option value="Antigua and Barbuda">Antigua and Barbuda</option>
                      <option value="Argentina">Argentina</option>
                      <option value="Armenia">Armenia</option>
                      <option value="Aruba">Aruba</option>
                      <option value="Australia">Australia</option>
                      <option value="Austria">Austria</option>
                      <option value="Azerbaijan">Azerbaijan</option>
                      <option value="Bahamas">Bahamas</option>
                      <option value="Bahrain">Bahrain</option>
                      <option value="Bangladesh">Bangladesh</option>
                      <option value="Barbados">Barbados</option>
                      <option value="Belarus">Belarus</option>
                      <option value="Belgium">Belgium</option>
                      <option value="Belize">Belize</option>
                      <option value="Benin">Benin</option>
                      <option value="Bermuda">Bermuda</option>
                      <option value="Bhutan">Bhutan</option>
                      <option value="Bolivia">Bolivia</option>
                      <option value="Bonaire, Sint Eustatius and Saba">Bonaire, Sint Eustatius and Saba</option>
                      <option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
                      <option value="Botswana">Botswana</option>
                      <option value="Bouvet Island">Bouvet Island</option>
                      <option value="Brazil">Brazil</option>
                      <option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
                      <option value="Brunei Darussalam">Brunei Darussalam</option>
                      <option value="Bulgaria">Bulgaria</option>
                      <option value="Burkina Faso">Burkina Faso</option>
                      <option value="Burundi">Burundi</option>
                      <option value="Cambodia">Cambodia</option>
                      <option value="Cameroon">Cameroon</option>
                      <option value="Canada">Canada</option>
                      <option value="Cape Verde">Cape Verde</option>
                      <option value="Cayman Islands">Cayman Islands</option>
                      <option value="Central African Republic">Central African Republic</option>
                      <option value="Chad">Chad</option>
                      <option value="Chile">Chile</option>
                      <option value="China">China</option>
                      <option value="Christmas Island">Christmas Island</option>
                      <option value="Cocos (Keeling) Islands">Cocos (Keeling) Islands</option>
                      <option value="Colombia">Colombia</option>
                      <option value="Comoros">Comoros</option>
                      <option value="Congo">Congo</option>
                      <option value="Congo, Democratic Republic of the Congo">Congo, Democratic Republic of the Congo</option>
                      <option value="Cook Islands">Cook Islands</option>
                      <option value="Costa Rica">Costa Rica</option>
                      <option value="Cote D'Ivoire">Cote D'Ivoire</option>
                      <option value="Croatia">Croatia</option>
                      <option value="Cuba">Cuba</option>
                      <option value="Curacao">Curacao</option>
                      <option value="Cyprus">Cyprus</option>
                      <option value="Czech Republic">Czech Republic</option>
                      <option value="Denmark">Denmark</option>
                      <option value="Djibouti">Djibouti</option>
                      <option value="Dominica">Dominica</option>
                      <option value="Dominican Republic">Dominican Republic</option>
                      <option value="Ecuador">Ecuador</option>
                      <option value="Egypt">Egypt</option>
                      <option value="El Salvador">El Salvador</option>
                      <option value="Equatorial Guinea">Equatorial Guinea</option>
                      <option value="Eritrea">Eritrea</option>
                      <option value="Estonia">Estonia</option>
                      <option value="Ethiopia">Ethiopia</option>
                      <option value="Falkland Islands (Malvinas)">Falkland Islands (Malvinas)</option>
                      <option value="Faroe Islands">Faroe Islands</option>
                      <option value="Fiji">Fiji</option>
                      <option value="Finland">Finland</option>
                      <option value="France">France</option>
                      <option value="French Guiana">French Guiana</option>
                      <option value="French Polynesia">French Polynesia</option>
                      <option value="French Southern Territories">French Southern Territories</option>
                      <option value="Gabon">Gabon</option>
                      <option value="Gambia">Gambia</option>
                      <option value="Georgia">Georgia</option>
                      <option value="Germany">Germany</option>
                      <option value="Ghana">Ghana</option>
                      <option value="Gibraltar">Gibraltar</option>
                      <option value="Greece" selected>Greece</option>
                      <option value="Greenland">Greenland</option>
                      <option value="Grenada">Grenada</option>
                      <option value="Guadeloupe">Guadeloupe</option>
                      <option value="Guam">Guam</option>
                      <option value="Guatemala">Guatemala</option>
                      <option value="Guernsey">Guernsey</option>
                      <option value="Guinea">Guinea</option>
                      <option value="Guinea-Bissau">Guinea-Bissau</option>
                      <option value="Guyana">Guyana</option>
                      <option value="Haiti">Haiti</option>
                      <option value="Heard Island and Mcdonald Islands">Heard Island and Mcdonald Islands</option>
                      <option value="Holy See (Vatican City State)">Holy See (Vatican City State)</option>
                      <option value="Honduras">Honduras</option>
                      <option value="Hong Kong">Hong Kong</option>
                      <option value="Hungary">Hungary</option>
                      <option value="Iceland">Iceland</option>
                      <option value="India">India</option>
                      <option value="Indonesia">Indonesia</option>
                      <option value="Iran, Islamic Republic of">Iran, Islamic Republic of</option>
                      <option value="Iraq">Iraq</option>
                      <option value="Ireland">Ireland</option>
                      <option value="Isle of Man">Isle of Man</option>
                      <option value="Israel">Israel</option>
                      <option value="Italy">Italy</option>
                      <option value="Jamaica">Jamaica</option>
                      <option value="Japan">Japan</option>
                      <option value="Jersey">Jersey</option>
                      <option value="Jordan">Jordan</option>
                      <option value="Kazakhstan">Kazakhstan</option>
                      <option value="Kenya">Kenya</option>
                      <option value="Kiribati">Kiribati</option>
                      <option value="Korea, Democratic People's Republic of">Korea, Democratic People's Republic of</option>
                      <option value="Korea, Republic of">Korea, Republic of</option>
                      <option value="Kosovo">Kosovo</option>
                      <option value="Kuwait">Kuwait</option>
                      <option value="Kyrgyzstan">Kyrgyzstan</option>
                      <option value="Lao People's Democratic Republic">Lao People's Democratic Republic</option>
                      <option value="Latvia">Latvia</option>
                      <option value="Lebanon">Lebanon</option>
                      <option value="Lesotho">Lesotho</option>
                      <option value="Liberia">Liberia</option>
                      <option value="Libyan Arab Jamahiriya">Libyan Arab Jamahiriya</option>
                      <option value="Liechtenstein">Liechtenstein</option>
                      <option value="Lithuania">Lithuania</option>
                      <option value="Luxembourg">Luxembourg</option>
                      <option value="Macao">Macao</option>
                      <option value="Macedonia, the Former Yugoslav Republic of">Macedonia, the Former Yugoslav Republic of</option>
                      <option value="Madagascar">Madagascar</option>
                      <option value="Malawi">Malawi</option>
                      <option value="Malaysia">Malaysia</option>
                      <option value="Maldives">Maldives</option>
                      <option value="Mali">Mali</option>
                      <option value="Malta">Malta</option>
                      <option value="Marshall Islands">Marshall Islands</option>
                      <option value="Martinique">Martinique</option>
                      <option value="Mauritania">Mauritania</option>
                      <option value="Mauritius">Mauritius</option>
                      <option value="Mayotte">Mayotte</option>
                      <option value="Mexico">Mexico</option>
                      <option value="Micronesia, Federated States of">Micronesia, Federated States of</option>
                      <option value="Moldova, Republic of">Moldova, Republic of</option>
                      <option value="Monaco">Monaco</option>
                      <option value="Mongolia">Mongolia</option>
                      <option value="Montenegro">Montenegro</option>
                      <option value="Montserrat">Montserrat</option>
                      <option value="Morocco">Morocco</option>
                      <option value="Mozambique">Mozambique</option>
                      <option value="Myanmar">Myanmar</option>
                      <option value="Namibia">Namibia</option>
                      <option value="Nauru">Nauru</option>
                      <option value="Nepal">Nepal</option>
                      <option value="Netherlands">Netherlands</option>
                      <option value="Netherlands Antilles">Netherlands Antilles</option>
                      <option value="New Caledonia">New Caledonia</option>
                      <option value="New Zealand">New Zealand</option>
                      <option value="Nicaragua">Nicaragua</option>
                      <option value="Niger">Niger</option>
                      <option value="Nigeria">Nigeria</option>
                      <option value="Niue">Niue</option>
                      <option value="Norfolk Island">Norfolk Island</option>
                      <option value="Northern Mariana Islands">Northern Mariana Islands</option>
                      <option value="Norway">Norway</option>
                      <option value="Oman">Oman</option>
                      <option value="Pakistan">Pakistan</option>
                      <option value="Palau">Palau</option>
                      <option value="Palestinian Territory, Occupied">Palestinian Territory, Occupied</option>
                      <option value="Panama">Panama</option>
                      <option value="Papua New Guinea">Papua New Guinea</option>
                      <option value="Paraguay">Paraguay</option>
                      <option value="Peru">Peru</option>
                      <option value="Philippines">Philippines</option>
                      <option value="Pitcairn">Pitcairn</option>
                      <option value="Poland">Poland</option>
                      <option value="Portugal">Portugal</option>
                      <option value="Puerto Rico">Puerto Rico</option>
                      <option value="Qatar">Qatar</option>
                      <option value="Reunion">Reunion</option>
                      <option value="Romania">Romania</option>
                      <option value="Russian Federation">Russian Federation</option>
                      <option value="Rwanda">Rwanda</option>
                      <option value="Saint Barthelemy">Saint Barthelemy</option>
                      <option value="Saint Helena">Saint Helena</option>
                      <option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
                      <option value="Saint Lucia">Saint Lucia</option>
                      <option value="Saint Martin">Saint Martin</option>
                      <option value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
                      <option value="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</option>
                      <option value="Samoa">Samoa</option>
                      <option value="San Marino">San Marino</option>
                      <option value="Sao Tome and Principe">Sao Tome and Principe</option>
                      <option value="Saudi Arabia">Saudi Arabia</option>
                      <option value="Senegal">Senegal</option>
                      <option value="Serbia">Serbia</option>
                      <option value="Serbia and Montenegro">Serbia and Montenegro</option>
                      <option value="Seychelles">Seychelles</option>
                      <option value="Sierra Leone">Sierra Leone</option>
                      <option value="Singapore">Singapore</option>
                      <option value="Sint Maarten">Sint Maarten</option>
                      <option value="Slovakia">Slovakia</option>
                      <option value="Slovenia">Slovenia</option>
                      <option value="Solomon Islands">Solomon Islands</option>
                      <option value="Somalia">Somalia</option>
                      <option value="South Africa">South Africa</option>
                      <option value="South Georgia and the South Sandwich Islands">South Georgia and the South Sandwich Islands</option>
                      <option value="South Sudan">South Sudan</option>
                      <option value="Spain">Spain</option>
                      <option value="Sri Lanka">Sri Lanka</option>
                      <option value="Sudan">Sudan</option>
                      <option value="Suriname">Suriname</option>
                      <option value="Svalbard and Jan Mayen">Svalbard and Jan Mayen</option>
                      <option value="Swaziland">Swaziland</option>
                      <option value="Sweden">Sweden</option>
                      <option value="Switzerland">Switzerland</option>
                      <option value="Syrian Arab Republic">Syrian Arab Republic</option>
                      <option value="Taiwan, Province of China">Taiwan, Province of China</option>
                      <option value="Tajikistan">Tajikistan</option>
                      <option value="Tanzania, United Republic of">Tanzania, United Republic of</option>
                      <option value="Thailand">Thailand</option>
                      <option value="Timor-Leste">Timor-Leste</option>
                      <option value="Togo">Togo</option>
                      <option value="Tokelau">Tokelau</option>
                      <option value="Tonga">Tonga</option>
                      <option value="Trinidad and Tobago">Trinidad and Tobago</option>
                      <option value="Tunisia">Tunisia</option>
                      <option value="Turkey">Turkey</option>
                      <option value="Turkmenistan">Turkmenistan</option>
                      <option value="Turks and Caicos Islands">Turks and Caicos Islands</option>
                      <option value="Tuvalu">Tuvalu</option>
                      <option value="Uganda">Uganda</option>
                      <option value="Ukraine">Ukraine</option>
                      <option value="United Arab Emirates">United Arab Emirates</option>
                      <option value="United Kingdom">United Kingdom</option>
                      <option value="United States">United States</option>
                      <option value="United States Minor Outlying Islands">United States Minor Outlying Islands</option>
                      <option value="Uruguay">Uruguay</option>
                      <option value="Uzbekistan">Uzbekistan</option>
                      <option value="Vanuatu">Vanuatu</option>
                      <option value="Venezuela">Venezuela</option>
                      <option value="Viet Nam">Viet Nam</option>
                      <option value="Virgin Islands, British">Virgin Islands, British</option>
                      <option value="Virgin Islands, U.s.">Virgin Islands, U.s.</option>
                      <option value="Wallis and Futuna">Wallis and Futuna</option>
                      <option value="Western Sahara">Western Sahara</option>
                      <option value="Yemen">Yemen</option>
                      <option value="Zambia">Zambia</option>
                      <option value="Zimbabwe">Zimbabwe</option>
                    </select>
                  </div>
                </div>
              </div>


              <div class="form-group col-md-6" id="cityDivId">
                <label for="exampleFormControlTextarea1">City</label>
                <input id="city" name="city" placeholder="e.g. Heraklion" class="form-control" type="text" pattern="[A-Za-z ]{3,30}">
              </div>

              <div class="form-group col-md-6" id="homeAddressDivId">
                <label for="exampleFormControlTextarea1" id="home_add_tittle">Home Address</label>
                  <input id="home_address" name="address" placeholder="e.g. Andrea Papandreou 93" class="form-control" type="text" pattern="[A-Za-z 0-9]{5,50}">
                  <button class="btn btn-info" type="button" id="confirm_location">Confirm</button>
              </div>

              <div id="pinDiv" class="form-group col-md-6"><button class="btn btn-info" type="button" id="pin_location" disabled>Pin my location!</button></div>

              <div id="Map" style="height:600px; width:700px" class="form-group col-md-5"></div>
              <script src="http://www.openlayers.org/api/OpenLayers.js"></script>
  


              
              <div class="col-md-6 form-check" id="checkBoxDivId">
                  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" checked>
                  <label class="form-check-label" for="flexCheckDefault">
                      <p >*I agree to the <a href="https://www.iubenda.com/en/help/2859-terms-and-conditions-when-are-they-needed" target="_blank">Terms and Conditions</a> </p>
                      <br>
                      <p id="check_p" style="color: red;"></p>
                    </label>
                </div>
                
                <p><b>The fields with "<p class="red_star">*</p>" are mandatory</b></p><br>

                  <div id="buttonsToNavigate">
                    <button type="button" id="previousButtonId" disabled>Previous</button>
                    <button type="button" class="" id="nextButtonId">Next</button>
                    <input type="submit" value="Submit" id="sub_id" class="btn btn-success">
                </div>


         </form>   
         


         <div class="container">
          <footer class="py-3 my-4">
            <ul class="nav justify-content-center border-bottom pb-3 mb-3">
              <li class="nav-item"><a href="https://en.uoc.gr/" target="_blank" class="nav-link px-2 text-muted">UOC</a></li>
              <li class="nav-item"><a href="https://www.tuc.gr/" target="_blank" class="nav-link px-2 text-muted">TUC</a></li>
              <li class="nav-item"><a href="https://hmu.gr/" target="_blank" class="nav-link px-2 text-muted">HELMEPA</a></li>
              <li class="nav-item"><a href="https://www.csd.uoc.gr/" target="_blank" class="nav-link px-2 text-muted">CSD</a></li>
              <li class="nav-item"><a href="https://elearn.uoc.gr/course/view.php?id=3757" target="_blank" class="nav-link px-2 text-muted">HY-359</a></li>
              <li class="nav-item"><a href="#" target="_blank" class="nav-link px-2 text-muted">About</a></li>
            </ul>
            <p class="text-center text-muted" style=" text-align: center;">This project was developed by John Tzortzakis (csd4448) and Sotiris Konstantis (csd1111)</p>
          </footer>
        </div>

        
         <script src="/student/studentRegister.js"></script>
    </body>
   
</html>
<script>

    $(document).ready(function(){
        $('#firstNameDivId').hide();
        $('#lastNameDivId').hide();
        $('#birthdayDivId').hide();
        $('#genderDivId').hide();

        $('#studentTypeDivId').hide();
        $('#academic_id').hide();
        $('#ID_reg').hide();
        $('#ID_exp').hide();
        $('#sxolh').hide();
        $('#dep').hide();
        $('#personalSiteDivId').hide();
        $('#contactDivId').hide();

        $('#countryDivId').hide();
        $('#cityDivId').hide();
        $('#homeAddressDivId').hide();
        $('#pinDiv').hide();
        $('#Map').hide();
        $('#checkBoxDivId').hide();
        
        $("#sub_id").hide();

        $("#strength-button1").on("click", changeColorStrength1);
        $("#strength-button2").on("click", changeColorStrength2);

    });


    $('#icon_visibility1').on("click", function(){
        let passType = $("#user_pass").attr('type');
        

        if(passType === 'password'){
            $("#user_pass").attr('type', 'text');
            $('#icon_visibility1').text('visibility');
        }else{
            $("#user_pass").attr('type', 'password');
            $('#icon_visibility1').text('visibility_off');
        }
    });
    
    $('#icon_visibility2').on("click", function(){
        let passType = $("#confirm_pass").attr('type');
        

        if(passType === 'password'){
            $("#confirm_pass").attr('type', 'text');
            $('#icon_visibility2').text('visibility');
        }else{
            $("#confirm_pass").attr('type', 'password');
            $('#icon_visibility2').text('visibility_off');
        }
    });


    $('#previousButtonId').click(function(){
       if($('#step').text() === "Step 2"){
            $('#usernameDivId').show(); //username
            $('#emailDivId').show(); //email
            $('#passwordDivId').show(); //password
            $('#passwordConfirmDivId').show(); //password confirm

            $('#firstNameDivId').hide();
            $('#lastNameDivId').hide();
            $('#birthdayDivId').hide();
            $('#genderDivId').hide();


            $('#step').text('Step 1');


            $('#previousButtonId').attr('disabled', true);
       }else
            if($('#step').text() === "Step 3"){
                $('#firstNameDivId').show();
                $('#lastNameDivId').show();
                $('#birthdayDivId').show();
                $('#genderDivId').show();


                $('#studentTypeDivId').hide();
                $('#academic_id').hide();
                $('#ID_reg').hide();
                $('#ID_exp').hide();
                $('#sxolh').hide();
                $('#dep').hide();
                $('#personalSiteDivId').hide();
                $('#contactDivId').hide();

                $('#step').text('Step 2');
            }else
                if($('#step').text() === "Step 4- Finale Step!"){
                    $('#studentTypeDivId').show();
                    $('#academic_id').show();
                    $('#ID_reg').show();
                    $('#ID_exp').show();
                    $('#sxolh').show();
                    $('#dep').show();
                    $('#personalSiteDivId').show();
                    $('#contactDivId').show();

                    $('#countryDivId').hide();
                    $('#cityDivId').hide();
                    $('#homeAddressDivId').hide();
                    $('#pinDiv').hide();
                    $('#Map').hide();
                    $('#checkBoxDivId').hide();


                  //  $('#nextButtonId').attr('type', 'button');
                  //  $('#nextButtonId').attr('class', '');
                   // $('#nextButtonId').text('Next');

                    $("#nextButtonId").show();
                    $("#sub_id").hide();

                    $('#step').text('Step 3');

                }
    });


    $('#nextButtonId').click(function(){
       if($('#step').text() === "Step 1"){

            if(checkToStep2()){
              $('#firstNameDivId').show();
              $('#lastNameDivId').show();
              $('#birthdayDivId').show();
              $('#genderDivId').show();
  
              $('#usernameDivId').hide();//username
              $('#emailDivId').hide();  //email
              $('#passwordDivId').hide();  //password
              $('#passwordConfirmDivId').hide();  //password confirm
  
  
  
              $('#step').text('Step 2');
  
              $('#previousButtonId').removeAttr('disabled');

            }

       }else
            if($('#step').text() === "Step 2"){


                if(checkToStep3()){
                  $('#firstNameDivId').hide();
                  $('#lastNameDivId').hide();
                  $('#birthdayDivId').hide();
                  $('#genderDivId').hide();


                  $('#studentTypeDivId').show();
                  $('#academic_id').show();
                  $('#ID_reg').show();
                  $('#ID_exp').show();
                  $('#sxolh').show();
                  $('#dep').show();
                  $('#personalSiteDivId').show();
                  $('#contactDivId').show();

                  $('#step').text('Step 3');
                }



            }else
                if($('#step').text() === "Step 3"){


                  if(checkToStep4()){
                    
                      $('#studentTypeDivId').hide();
                      $('#academic_id').hide();
                      $('#ID_reg').hide();
                      $('#ID_exp').hide();
                      $('#sxolh').hide();
                      $('#dep').hide();
                      $('#personalSiteDivId').hide();
                      $('#contactDivId').hide();
                    
                      $('#countryDivId').show();
                      $('#cityDivId').show();
                      $('#homeAddressDivId').show();
                      $('#pinDiv').show();
                      $('#Map').show();
                      $('#checkBoxDivId').show();
                    
                    
                    
                     // $('#nextButtonId').attr('type', 'submit');
                    //  $('#nextButtonId').attr('class', 'btn btn-success');
                     // $('#nextButtonId').text('Register');

                      $("#nextButtonId").hide();
                      $("#sub_id").show();
                    
                      $('#step').text('Step 4- Finale Step!');

                  }
                }
    });


    //checks the inputs for the second step etc
    function checkToStep2(){
      let flag = true;
      
      let original_pass = $('#user_pass').val();
      let confirm_pass = $('#confirm_pass').val();

      if(original_pass !== confirm_pass){
          $("#notMatching").text("The passwords do not match!");
          flag = false;
      }else{
          $("#notMatching").text("");
          if(strength(original_pass)<-1){
            $("#notMatching").text("The password is too weak. Try to add a symbol or uppercase letter");
            flag = false;
          }else
          $("#notMatching").text("");
      }

      return flag;
    }

    function checkToStep3(){

      return true;
    }

    function checkToStep4(){

      
      let email = $("#email_id").val();
      let dep = $("#uni_id").val();
      let flag = true, temp_flag = false;


      if(dep === "uoc"){
        if(email.includes("uoc.gr"))
          temp_flag = true;
      }else
        if(dep === "helmepa"){
          if(email.includes("helmepa.gr"))
            temp_flag = true;
        }else
          if(dep === "tuc")
            if(email.includes("tuc.gr"))
              temp_flag = true;

      if(!temp_flag){
        
        $("#email_p").text("Email have to associated with the Education Institution");
        flag = false;

        $('#studentTypeDivId').hide();
        $('#academic_id').hide();
        $('#ID_reg').hide();
        $('#ID_exp').hide();
        $('#sxolh').hide();
        $('#dep').hide();
        $('#personalSiteDivId').hide();
        $('#contactDivId').hide();
        
        $('#usernameDivId').show();
        $('#emailDivId').show();
        $('#passwordDivId').show();
        $('#passwordConfirmDivId').show();


        $('#step').text('Step 1');
        $('#previousButtonId').attr('disabled', true);

      }else{
        $("#email_p").text("");
      }

      let start = new Date(document.getElementById("ID_start").value);
      let end = new Date(document.getElementById("ID_end").value);

      if(end.getTime() <= start.getTime()){
        $("#date_p").text("Incorrect dates");
        flag = false;
      }else
        $("#date_p").text("");


      temp_flag = false;
      let typeSt = document.getElementById("typeSt").value;
      let res = end.getFullYear() - start.getFullYear();
      let years = -5;
      if(typeSt === "ugrad"){
        if(res < 7){
          temp_flag =true;
          years = 7;
        }
      }else
        if(typeSt === "pgrad"){
          if(res < 3){
            temp_flag = true;
            years = 3;
          }
        }else
          if(typeSt === "phd"){
            if(res < 6){
              temp_flag = true;
              years = 6;
            }
          }

      if(!temp_flag){
        if(years!==-5)
          $("#date_p").text("Incorrect dates! "+typeSt+" students ID expires after "+years+" years.");
        flag = false;
      }else
        $("#date_p").text("");

      return flag;
    }

    
    function checkSub(){
      if($("#flexCheckDefault").is(':checked')){
        $("#check_p").text("");
        return true;
      }else{
        $("#check_p").text("You need to check the box");
        return false; 
      }

    }

    /**
     * returns the stregh of the password + checks for illigal patterns inside password.
     * return 0 -> weak password
     *        1 -> medium password
     *        2 -> strong password
     *        -1 -> illigal password
     *        -2 -> empty password
     */
    function strength(password) {
    const forbiddenWords = ["helmepa", "uoc", "tuc"];
    if(password === "")
      return -2;

    if(!password.includes(forbiddenWords[0]))
      if(!password.includes(forbiddenWords[1]))
        if(!password.includes(forbiddenWords[2])){
          let numberCount=0, symbolsCount=0, lowerCount=0, upperCount=0, firstSymbol=')';

          numberCount = password.replace(/[^0-9]/g, '').length;
          if((numberCount*100)/password.length > 49)
            return 0;

          
          for (let i = 0; i < password.length; i++) {
              
            if(password.charAt(i).match(/[a-z]/))
              lowerCount++;
            
            if(password.charAt(i).match(/[A-Z]/))
              upperCount++;

            if(password.charAt(i).match(/^[!@#\$%\^\&*\)\(+=.,_-]+$/g)) 
              if(firstSymbol===')'){
                firstSymbol = password.charAt(i);
                symbolsCount++; 
              }else
                if(!(password.charAt(i) === firstSymbol))
                  symbolsCount++;
              
          }

          if(symbolsCount>1)
            if(lowerCount>0)
              if(upperCount>0)
                return 2;
          
        return 1;
        }
    
    return -1;
  }


    function changeColorStrength1(){
    
    let button = document.getElementById("strength-button1");
    let password = document.getElementById("user_pass").value;
    let str = strength(password);
    
    if(str === -2){
      button.innerText = "None";
      button.classList = "btn btn-danger"
    }else
      if(str === -1){
        button.innerText = "Illigal";
        button.classList = "btn btn-danger"
      }else
        if(str === 0){
          button.innerText = "Weak";
          button.classList = "btn btn-danger"
        }else
          if(str === 1){
            button.innerText = "Medium";
            button.classList = "btn btn-warning"
          }else{
            button.innerText = "Strong";
            button.classList = "btn btn-success"
          }

    }

    function changeColorStrength2(){
      let button  = document.getElementById("strength-button2")
      let password = document.getElementById("confirm_pass").value;
      let str = strength(password);
      
      if(str === -2){
        button.innerText = "None";
        button.classList = "btn btn-danger"
      }else
        if(str === -1){
          button.innerText = "Illigal";
          button.classList = "btn btn-danger"
        }else
          if(str === 0){
            button.innerText = "Weak";
            button.classList = "btn btn-danger"
          }else
            if(str === 1){
              button.innerText = "Medium";
              button.classList = "btn btn-warning"
            }else{
              button.innerText = "Strong";
              button.classList = "btn btn-success"
            }

    }

</script>

<script>
      map = new OpenLayers.Map("Map");
        var mapnik = new OpenLayers.Layer.OSM();
        map.addLayer(mapnik);



        document.getElementById('pin_location').addEventListener('click', ()=>{addPinOnMap(lat, lon);});
        
        function addPinOnMap(lat, lon){
          var markers = new OpenLayers.Layer.Markers("Markers");
          map.addLayer(markers);
          let name = document.getElementById('first_name').value +" "+document.getElementById('last_name').value;

          //kwdikas gia new location. Prwto->lat, deytero->lon
          var position = setPosition(lat, lon);
          var mar = new OpenLayers.Marker(position);
          markers.addMarker(mar);
          mar.events.register('mousedown', mar, function(evt){handler(position, name);});
        }
        function setPosition(lat, lon){
          var fromProjection = new OpenLayers.Projection("EPSG:4326");
          var toProjection = new OpenLayers.Projection("EPSG:900913");
          var position = new OpenLayers.LonLat(lon, lat).transform(fromProjection, toProjection);
          return position;
        }

        function handler(position, message){
          var popup = new OpenLayers.Popup.FramedCloud("Popup", position, null, message, null, true);
          map.addPopup(popup);
        }



       // const zoom = 11;
       // map.setCenter(position, zoom);
        

        const confirmLocationBtn = document.getElementById("confirm_location");
        confirmLocationBtn.addEventListener('click', checkLocation);


    function checkLocation(){

      var addressName = document.getElementById('home_address').value.replace(/\s/g, '%20');
      var city=document.getElementById('city').value;
      var country=document.getElementById('country').value;
      var address = addressName +"%20"+ city +"%20"+ country;
      const data = null;
      const xhr = new XMLHttpRequest();
      xhr.withCredentials = true;

      xhr.addEventListener("readystatechange", ()=> {
        if (this.readyState === this.DONE) {
          const jsonObj = JSON.parse(xhr.responseText);
          if(Object.entries(jsonObj).length === 0){ //einai keno
            document.getElementById('json_p').innerText = "Couldn't confirm the location!";
            document.getElementById('pin_location').setAttribute('disabled', '');
          }else{
            document.getElementById('json_p').innerText = "";

            if(jsonObj[0].display_name.includes('Crete')){
              document.getElementById('json_p').innerText = "";
              var text = jsonObj[0].display_name;
              lat = jsonObj[0].lat;
              lon = jsonObj[0].lon;
              document.getElementById("lat_id").value = lat;
              document.getElementById("lon_id").value = lon;

              document.getElementById('pin_location').removeAttribute('disabled');
            }else{
              document.getElementById('json_p').innerText = "This service is only available for Cretan addresses";
              document.getElementById('pin_location').setAttribute('disabled', '');

            }
            
          }
          
        }
      });  

      xhr.open("GET", "https://forward-reverse-geocoding.p.rapidapi.com/v1/search?q="+address+"&accept-language=en&polygon_threshold=0.0");
      xhr.setRequestHeader("X-RapidAPI-Key", "f82a4dfdc7msh6fa0538a097932dp1b542ejsn0e0c16ceb9a2");
      xhr.setRequestHeader("X-RapidAPI-Host", "forward-reverse-geocoding.p.rapidapi.com");

      xhr.send(data);
    }


</script>
 <style><%@ include file="studentRegister.css"%></style>