<?php
require_once '../../core/init.php';

if (!Session::exists(Config::get('session/session_name'))) {
    Redirect::to('../LoginOut/login_page.php');
}

if (isset($_GET['id'])) {
    $userId = $_GET['id'];

    $db = DB::getInstance();

    $db->delete('utilisateur', ['id', '=', $userId]);

    $result = $db->delete('utilisateur', ['id', '=', $userId]);

    if ($result) {
        echo 'User deleted successfully';
    } else {
        echo 'Error deleting user';
    }
}

// Redirect back
Redirect::to('admin_page.php');
?>
