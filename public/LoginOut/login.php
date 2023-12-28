<?php 

require_once '../core/init.php';

if(Input::exists()) {
    if(Token::check(Input::get('token'))) {
        $validate = new Validate();
        $validation = $validate->check($_POST, array(
            'email' => array('required' => true),
            'password' => array('required' => true)
        ));
        
        if($validation->passed()) {
            $user = new User();
            $login = $user->login(Input::get('email'), Input::get('password'));

            if($login) {
                // $user->email = Input::get('email');
                echo 'Success';
            } else {
                echo '<p>Sorry, Login Failed</p>';
            }

        } else {
            foreach($validation->errors() as $error) {
                echo $error, '<br>';
            }

        }
    }
}
?>





<form action="" method="post">

    <div class="field">
        <label for="email">Email</label>
        <input type="text" name="email" id="email" autocomplete="off">
    </div>

    <div class="field">
        <label for="password">Password</label>
        <input type="password" name="password" id="password" autocomplete="off">
    </div>

    <input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
    <input type="submit" value="Login">

</form>

