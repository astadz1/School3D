<?php
require_once '../../core/init.php';

// Check if the user is not logged in
if (!Session::exists(Config::get('session/session_name'))) {
    // Redirect
    Redirect::to('login_page.php');
}

$linkUser = new LinkUser();

if (Input::exists()) {
    if (Token::check(Input::get('token'))) {

        // Get the ID of the Parent user from the form
        $parentId = Input::get('parent');
        
        // Get the ID of the Élève user from the form
        $studentId = Input::get('eleve');

        if ($linkUser->linkUsers($parentId, $studentId)) {
            // The users are linked successfully
            echo 'Users linked successfully!';
        } else {
            // Failed to link users
            echo 'Failed to link users.';
        }
    }
}

$db = DB::getInstance();
$parents = $db->getUsersByType('Parent');
$eleves = $db->getUsersByType('Élève');
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Link Users</title>

    <style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Roboto', sans-serif;
        background: linear-gradient(to right, #7f428b, #270d2c);
        color: #fff;
    }

    h1 {
        font-size: 30px;
        color: #fff;
        text-transform: uppercase;
        font-weight: 300;
        text-align: center;
    }

    .form-container {
        margin: 50px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    form {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    label {
        color: #fff;
        margin-bottom: 10px;
    }

    select,
    input {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: none;
        border-radius: 5px;
        background-color: rgba(255, 255, 255, 0.1);
        color: #fff;
        box-sizing: border-box; 
    }

    input[type="submit"] {
        cursor: pointer;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px;
        box-sizing: border-box;
    }

    input[type="submit"]:hover {
        background-color: #45a049;
    }

    /* for custom scrollbar for webkit browser
    ::-webkit-scrollbar {
        width: 10px;
    }

    ::-webkit-scrollbar-track {
        background: rgba(0, 0, 0, 0.1);
    }

    ::-webkit-scrollbar-thumb {
        background: #888;
        border-radius: 5px;
    }

    ::-webkit-scrollbar-thumb:hover {
        background: #555;
    } */
    .container111 {
	width: 100%;
	display: flex;
	/* flex-wrap: wrap; */
	justify-content: space-around;
    }
    .container111 .btn {
        position: relative;
        top: 0;
        left: 30%;
        width: 250px;
        height: 50px;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .container111 .btn a {
        position: absolute;
        top: 0;
        left: -30%;
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        background: rgba(255, 255, 255, 0.05);
        box-shadow: 0 15px 15px rgba(0, 0, 0, 0.3);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 30px;
        padding: 0;
        letter-spacing: 1px;
        text-decoration: none;
        overflow: hidden;
        color: #fff;
        font-weight: 400px;
        z-index: 1;
        transition: 0.5s;
        backdrop-filter: blur(15px);
    }
    .container111 .btn:hover a {
        letter-spacing: 3px;
    }
    .container111 .btn a::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 40%;
        height: 100%;
        background: linear-gradient(to left, rgba(255, 255, 255, 0.15), transparent);
        transform: skewX(45deg) translate(0);
        transition: 0.5s;
        filter: blur(0px);
    }
    .container111 .btn:hover a::before {
        transform: skewX(45deg) translate(200px);
    }
    .container111 .btn::before {
        content: "";
        position: absolute;
        left: 20%;
        transform: translatex(-50%);
        bottom: -5px;
        width: 30px;
        height: 10px;
        background: #f00;
        border-radius: 10px;
        transition: 0.5s;
        transition-delay: 0.5;
    }
    .container111 .btn:hover::before {
        bottom: 0;
        height: 50%;
        width: 20%;
        border-radius: 30px;
    }

    .container111 .btn::after {
        content: "";
        position: absolute;
        left: 20%;
        transform: translatex(-50%);
        top: -5px;
        width: 30px;
        height: 10px;
        background: #f00;
        border-radius: 10px;
        transition: 0.5s;
        transition-delay: 0.5;
    }
    .container111 .btn:hover::after {
        top: 0;
        height: 50%;
        width: 20%;
        border-radius: 30px;
    }
    .container111 .btn:nth-child(1)::before, 
    .container111 .btn:nth-child(1)::after {
        background: #1eff45;
        box-shadow: 0 0 5px #1eff45, 0 0 15px #1eff45, 0 0 30px #1eff45,
            0 0 60px #1eff45;
    }
</style>

</head>
<body>

<h1>Parrainage Parent & Élève</h1>

<div class="form-container">
    <form action="" method="post">
        <label for="parent">Selectionner un Parent:</label>
        <select name="parent" id="parent">
            <?php foreach ($parents as $parent) : ?>
                <option value="<?php echo $parent->id; ?>"><?php echo $parent->firstName . ' ' . $parent->lastName; ?></option>
            <?php endforeach; ?>
        </select>

        <label for="eleve">Selectionner un Élève:</label>
        <select name="eleve" id="eleve">
            <?php foreach ($eleves as $eleve) : ?>
                <option value="<?php echo $eleve->id; ?>"><?php echo $eleve->firstName . ' ' . $eleve->lastName; ?></option>
            <?php endforeach; ?>
        </select>

        <div class="container111">
            <div class="btn">
                <a href="#" onclick="submitForm()">Link Users</a>
            </div>
        </div>

        <script>
            function submitForm() {
                document.querySelector('form').submit();
            }
        </script>

        <input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
    </form>
</div>

</body>
</html>
