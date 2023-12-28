<?php

require_once '../../core/init.php';

if (!Session::exists(Config::get('session/session_name'))) {
    Redirect::to('../LoginOut/login_page.php');
}

$user = null;

if (Input::exists()) {
    if (Token::check(Input::get('token'))) {
        if (isset($_GET['id'])) {
            $userId = $_GET['id'];
            $db = DB::getInstance();
            $user = $db->get('utilisateur', array('id', '=', $userId))->first();

            $newPassword = Input::get('password') ? Hash::make(Input::get('password')) : $user->password;

            $updateFields = array(
                'firstName' => Input::get('firstName') ?: $user->firstName,
                'lastName' => Input::get('lastName') ?: $user->lastName,
                'birthDate' => Input::get('birthDate') ?: $user->birthDate,
                'birthPlace' => Input::get('birthPlace') ?: $user->birthPlace,
                'email' => Input::get('email') ?: $user->email,
                'PhoneNumber' => Input::get('PhoneNumber') ?: $user->PhoneNumber,
                'userType' => Input::get('userType') ?: $user->userType,
                'password' => $newPassword,
            );


            $result = $db->update('utilisateur', $userId, $updateFields);

            if ($result) {
                echo 'User updated successfully';
            } else {
                echo 'Error updating user';
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User</title>
    <link rel="stylesheet" href="styles/edit.css?v=<?php echo time(); ?>">
</head>
<body>
    <div class="signup-container">
        <div class="left-container">
            <h1>
                <i class="fas fa-paw"></i>
                NAWAT
            </h1>
            <div class="puppy">
                <img src="pics/11.png">
            </div>
        </div>
        <div class="right-container">
            <header>
                <h1>Edit User</h1>
                <div class="set">
                <form action="" method="post">
                    <!-- Add hidden input for token -->
                    <input type="hidden" name="token" value="<?php echo Token::generate(); ?>">

                    <!-- Display existing user information in the form -->
                    <div class="pets-name">
                        <label for="firstName">First Name</label>
                        <input id="firstName" type="text" name="firstName" value="<?php echo $user ? $user->firstName : ''; ?>">
                    </div>

                    <div class="pets-name">
                        <label for="lastName">Last Name</label>
                        <input id="lastName" type="text" name="lastName" value="<?php echo $user ? $user->lastName : ''; ?>">
                    </div>
                </div>

                <div class="set">
                    <div class="pets-breed">
                        <label for="birthDate">Birth Date</label>
                        <input id="birthDate" type="date" name="birthDate" value="<?php echo $user ? $user->birthDate : ''; ?>">
                    </div>

                    <div class="pets-birthday">
                        <label for="birthPlace">Birth Place : </label>
                        <input type="text" name="birthPlace" value="<?php echo $user ? $user->birthPlace : ''; ?>"><br>
                    </div>
                    
                </div>

                <div class="set">
                    <div class="pets-breed">
                        <label for="email">Email : </label>
                        <input type="email" name="email" value="<?php echo $user ? $user->email : ''; ?>"><br>
                    </div>

                    <div class="pets-birthday">
                        <label for="PhoneNumber">Phone Number : </label>
                        <input type="text" name="PhoneNumber" value="<?php echo $user ? $user->PhoneNumber : ''; ?>"><br>

                    </div>
                    
                </div>

                <div class="set">
                    <div class="pets-breed">
                        <label for="password">Password : </label>
                        <input type="password" name="password"><br>
                    </div>

                    <div class="pets-birthday">
                        <label for="userType">User Type</label>
                            <select name="userType" id="userType">
                                <option value="" <?php echo (!$user || empty($user->userType)) ? 'selected' : ''; ?> disabled>Select User Type</option>
                                <option value="Direction" <?php echo ($user && $user->userType === 'Direction') ? 'selected' : ''; ?>>Direction</option>
                                <option value="ProfesseurP" <?php echo ($user && $user->userType === 'ProfesseurP') ? 'selected' : ''; ?>>Professeur Principale</option>
                                <option value="Professeur" <?php echo ($user && $user->userType === 'Professeur') ? 'selected' : ''; ?>>Professeur</option>
                                <option value="Parent" <?php echo ($user && $user->userType === 'Parent') ? 'selected' : ''; ?>>Parent</option>
                                <option value="Élève" <?php echo ($user && $user->userType === 'Élève') ? 'selected' : ''; ?>>Élève</option>
                            </select>
                    </div>
                    
                </div>
                
            <footer>
                <div class="set">
                    <a id='back' href="../Admin/admin_page.php">Back</a>
                    <input type="submit" value="Update" id="next">
                </div>
                </form>
            </footer>
        </div>
    </div>
</body>
</html>

