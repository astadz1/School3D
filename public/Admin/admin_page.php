<?php

require_once '../../core/init.php';

// Check if the user is not logged in
if (!Session::exists(Config::get('session/session_name'))) {
    // Redirect
    Redirect::to('../LoginOut/login_page.php');
}

$user = new User();


if (Input::exists()) {
    if (Token::check(Input::get('token'))) {

        $validate = new Validate();
        $validation = $validate->check($_POST, array(
            'firstName' => array(
                'required' => true,
                'min' => 2,
                'max' => 50,
                'unique' => 'utilisateur'
            ),            
        ));

        if ($validation->passed()) {
            $salt = Hash::salt(32);

            try {
                $hashedPassword = Hash::make(Input::get('password'), $salt);

                $userId = $user->create(array(
                    'firstName' => Input::get('firstName'),
                    'lastName' => Input::get('lastName'),
                    'birthDate' => Input::get('birthDate'),
                    'birthPlace' => Input::get('birthPlace'),
                    'email' => Input::get('email'),
                    'password' => $hashedPassword,
                    'PhoneNumber' => Input::get('PhoneNumber'),
                    'salt' => $salt,
                    'userType' => Input::get('userType'),
                    // 'PhotoProfil' => $userPhotoProfilPath, A refaire avec BLOB et no pas Varchar
                ));

                Session::flash('home', 'User has been registered and can now login!');
                // Redirect::to('index.php');
            } catch (Exception $e) {
                die($e->getMessage());
            }

        } else {
            foreach ($validation->errors() as $error) {
                echo $error, '<br>';
            }
        }
    }
}
?>
<!-- SÉCTION HTML POUR L'ADMIN -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="styles/admincss.css?v=<?php echo time(); ?>">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://cdn.lordicon.com/lordicon-1.1.0.js"></script>
</head>
<body>
    <div class="container1">
        <div class="navigation">
            <ul>
                <li>
                    <a href="">
                        <span class="icon"><lord-icon src="https://cdn.lordicon.com/bgebyztw.json" trigger="loop" colors="primary:#ffffff,secondary:#ffffff" style="width:40px;height:40px; top:0.3vw;"></lord-icon></span>
                        <span class="title" style="color:#fff;">Admin Dashboard</span>
                    </a>
                </li>
                <li>
                    <a  href="../chat/index.html" class="primary">
                        <span class="icon"><ion-icon name="chatbubbles-outline"></ion-icon></span>
                        <span class="title">Inbox</span>
                    </a>
                </li>
                <li>
                    <a class="primary" onclick="window.dialog2.showModal();">
                        <span class="icon"><ion-icon name="person-add-outline"></ion-icon></span>
                        <span class="title">Inscription</span>
                    </a>
                    <div class="cont">
                </li>
                <li>
                    <a href="#" onclick="openLinkPopup()">
                        <span class="icon"><ion-icon name="link-outline"></ion-icon></span>
                        <span class="title">Parrainage</span>
                    </a>
                </li>
                <li class="DOWN">

                </li>
                <li>
                    <a href="../LoginOut/logout.php">
                        <span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>
                        <span  class="title">Sign Out</span>
                    </a>
                </li>
            </ul>
        </div>
        </div>
        <dialog class="dialog" id="dialog2">
    <div class="wrapper1">
        <section class="form signup">
            <a blur-toggle onclick="document.getElementById('dialog2').close();" aria-label="close" class="x close-button">❌</a>
            <header>Inscription</header>
            <form action="" method="post" enctype="multipart/form-data">
                <div class="error-text"></div>
                <div class="name-details">
                    <div class="field input">
                    <label for="firstName">First Name</label>
                    <input type="text" name="firstName" id="firstName" value="<?php echo escape(Input::get('firstName')); ?>" autocomplete="off">
                </div>

                    <div class="field input">
                    <label for="lastName">Last Name</label>
                    <input type="text" name="lastName" id="lastName" value="<?php echo escape(Input::get('lastName')); ?>" autocomplete="off">
                    </div>
                </div>

                <div class="field input">
                    <label for="birthDate">Birthday</label>
                    <input type="date" name="birthDate" id="birthDate">
                </div>


                <div class="field input">
                    <label for="birthPlace">Birth Place</label>
                    <input type="text" name="birthPlace" id="birthPlace" value="" autocomplete="off">
                </div>

                <div class="field input">
                    <label for="email">Email</label>
                    <input type="email" name="email" id="email">
                </div>

                <div class="field input">
                    <label for="password">Choose a Password</label>
                    <input type="password" name="password" id="password">
                </div>

                <div class="field input">
                    <label for="password_again">Enter your Password again</label>
                    <input type="password" name="password_again" id="password_again">
                </div>

                <div class="field input">
                    <label for="PhoneNumber">Phone Number</label>
                    <input type="PhoneNumber" name="PhoneNumber" id="PhoneNumber">
                </div>

                <div class="field">
                    <label for="userType">User Type</label>
                    <select name="userType" id="userType">
                        <option value="" selected disabled>Select User Type</option>
                        <option value="Direction">Direction</option>
                        <option value="ProfesseurP">Professeur Principale</option>
                        <option value="Professeur">Professeur</option>
                        <option value="Parent">Parent</option>
                        <option value="Élève">Élève</option>
                    </select>
                </div>
                
                <div class="field input">
                    <label for="PhotoProfil">Profile Picture</label>
                    <input type="file" name="PhotoProfil" id="PhotoProfil">
                </div>
                <div class="field input">
                    <input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
                    <input type="submit" value="Register">
                </div>
            </form>
        </section>
    </div>
</dialog>


        <!-- main -->
        <div class="main">
        <div class="topbar">
            <div class="toggle">
            <ion-icon name="menu-outline"></ion-icon>
            </div>
            <div class="welcome" style="top: -5vw;">
                <h3 style="font-family: 'Ubuntu', sans-serif; font-size: 14px;">
                    Welcome, <?php echo escape($user->data()->firstName); ?>
                </h3>
            </div>
            <!-- search -->
            <div class="search">
                    <label>
                        <input type="text" placeholder="Search Here">
                        <a href="#">
                            <lord-icon class="lord-icon-s" src="https://cdn.lordicon.com/kkvxgpti.json" trigger="hover"
                                style="width:25px;height:25px">
                            </lord-icon>
                        </a>
                    </label>
                </div>
            <div class="button-drk">
                    <img style="height:3vw;width:auto;position:relative;right:-8vw;" src="pics/moon.png" id="moon">
            </div>
<div class="user">
    <img src="<?php echo $user->getProfilePictureUrl(); ?>" alt="Profile Picture">
</div>




            

        </div>
        <section>
        <h1 class="tbl-h">All Users</h1>
<div class="table-container tbl-header"> 
    <table cellpadding="0" cellspacing="0" border="0">
        <thead>
            <tr>
                <th>Code</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>User Type</th>
                <th>Date de naissance</th>
                <th>Lieu de naissance</th>
                <th>Phone Number</th>
                <th>Email</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $db = DB::getInstance();
            $users = $db->getAllUsers();

            foreach ($users as $user) {
                echo '<tr>';
                echo '<td>' . $user->id . '</td>';
                echo '<td>' . $user->firstName . '</td>';
                echo '<td>' . $user->lastName . '</td>';
                echo '<td>' . $user->userType . '</td>';
                echo '<td>' . $user->birthDate . '</td>';
                echo '<td>' . $user->birthPlace . '</td>';
                echo '<td>' . $user->PhoneNumber . '</td>';
                echo '<td>' . $user->email . '</td>';
                require_once('../../core/init.php');
                echo '<td><div class="container112"><div class="btn"><a href="edit.php?id=' . $user->id . '">Edit</a></div></div></td>';
                // echo '<td><div class="container111"><div class="btn"><a href="delete.php?id=' . $user->id . '">Delete</a></div></div></td>';
                echo '<td><div class="container111"><div class="btn"><a href="#" onclick="confirmDelete(' . $user->id . ')">Delete</a></div></div></td>';
                echo '</tr>';
            }
            
            ?>
        </tbody>
    </table>
</div>
    </section>
            </tbody>
        </table>
</div>
    </div>
</div>   
    </div>


	<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>

    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <script src="../java/navigation.js"></script>

    <script src="../java/dark-theme.js"></script>

    <script src="../java/Valide-userType.js"></script>

    <script src="../java/iframePopup.js"></script>

    <script src="../java/delete.js"></script>
        </body>
</html>
