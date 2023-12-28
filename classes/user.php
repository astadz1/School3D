<?php
class User {
    private $_db,
            $_data,
            $_sessionName,
            $_isLoggedIn;

    public function __construct($user = null){
        $this->_db = DB::getInstance();
        $this->_sessionName = Config::get('session/session_name');

        if(!$user){
            if(Session::exists($this->_sessionName)){
                $user = Session::get($this->_sessionName);

                if($this->find($user)){
                    $this->_isLoggedIn = true;
                } else {

                }
            }
        } else {
            $this->find($user);
        }
    }
        // BACKUP
    // public function create($fields = array()) {
    //     if (!$this->_db->insert('utilisateur', $fields)) {
    //         throw new Exception('There was a problem creating an account');
    //     }
    
    //     // Get the user ID of the newly created user
    //     $userID = $this->_db->lastInsertId();
    //     return $userID;
    // }

        public function create($fields = array()) {
        if (!$this->_db->insert('utilisateur', $fields)) {
            throw new Exception('There was a problem creating an account');
        }
    
        // Get the user ID of the newly created user
        $userID = $this->_db->lastInsertId();
        return $userID;
    }
 
    public function find($user = null) {
        if ($user) {
            $field = (is_numeric($user)) ? 'id' : 'email';
            $data = $this->_db->get('utilisateur', array($field, '=', $user));
    
            if ($data->count()) {
                $this->_data = $data->first();
                return $this;
            } else {
                echo "User doesn't exist"; 
            }
        }
        return null; 
    }

    public function login($email = null, $password = null) {
        $user = $this->find($email);
    
        if ($user) {
            // Use the stored salt for hashing during login
            $hashedPassword = Hash::make($password, $user->data()->salt);
    
            // Use password_verify to compare hashed passwords
            if (password_verify($password, $user->data()->password)) {
                Session::put($this->_sessionName, $user->data()->id);
    
                // Redirect based on user type
                switch ($user->data()->userType) {
                    case 'Admin':
                        Redirect::to('../Admin/admin_page.php');
                        break;
                    case 'ProfesseurP':
                        Redirect::to('professeurp_page.php');
                        break;
                    case 'Professeur':
                        Redirect::to('prof_page.php');
                        break;
                    case 'Parent':
                        Redirect::to('parent_page.php');
                        break;
                    case 'Élève':
                        Redirect::to('eleve_page.php');
                        break;
                    default:
                        // Redirect::to('default_page.php');
                        // break;
                }
    
                return true;
            }
        }
    
        // Debugging Statements
        // echo 'Entered Email: ' . Input::get('email') . '<br>';
        // echo 'Entered Password: ' . Hash::make(Input::get('password'), $user->data()->salt) . '<br>';
        // echo 'Stored Password: ' . $user->data()->password . '<br>';
    
        return false;
    }
    public function getProfilePictureUrl()
    {
        if (!empty($this->_data->PhotoProfil)) {
            // Convert the binary image data to a base64-encoded string
            $base64Image = base64_encode($this->_data->PhotoProfil);
            $imageMimeType = 'image/png';  //('image/jpeg', 'image/png')

            return 'data:' . $imageMimeType . ';base64,' . $base64Image;
        }

        return 'path/to/placeholder-image.jpg';
    }

    public function logout() {
        Session::delete($this->_sessionName);
    }

    public function data() {
        return $this->_data;
    }

    public function isLoggedIn() {
        return $this->_isLoggedIn;
    }
}
?>
