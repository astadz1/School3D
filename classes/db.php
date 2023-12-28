<?php
class DB {
    private static $_instance = null;
    private $_pdo, 
    $_query, 
    $_error, 
    $_results, 
    $_count = 0;
    private function __construct(){
        try {
            $this->_pdo = new PDO('mysql:host=' . config::get('mysql/host') .  ';dbname=' . config::get('mysql/db'), config::get('mysql/username'), config::get('mysql/password'));
            // echo 'Connected !';
        }
        catch (PDOException $e) {
            echo 'Connection Failed !';
        }
    }
    public static function getInstance() {
        if(!isset(self::$_instance)){
            self::$_instance = new DB();
        }
        return self::$_instance;
    }
    public function query($sql, $params = array()) {
        $this->_error = false;
        if($this->_query = $this->_pdo->prepare($sql)){
            $x = 1;
            if(count($params)){
                foreach($params as $param){
                    $this->_query->bindValue($x, $param);
                    $x++;
                }
            }

            if($this->_query->execute()){
                $this->_results = $this->_query->fetchAll(PDO::FETCH_OBJ);
                $this->_count = $this->_query->rowCount();
            } else {
                $this->_error = true;
            }
        }
        return $this;
    }

    private function action($action, $table, $where = array()) {
        if(count($where) === 3){
            $operators = array('=', '>', '<', '>=', '<=');
            $field     = $where[0];
            $operator  = $where[1];
            $value     = $where[2];
            if(in_array($operator, $operators)) {
                $sql = "{$action} FROM {$table} WHERE {$field} {$operator} ? ";
                if(!$this->query($sql, array($value))->error()) {
                    return $this;
                }
            }
        }
        return false;
    }
    
    public function get($table, $where){
        $this->action('SELECT *', $table, $where);
        return $this; 
    }
    

    public function delete($table, $where){
        $result = $this->action('DELETE', $table, $where);
    
        if (!$result) {
            $errorCode = $this->_pdo->errorCode();
            if ($errorCode == '23000') {
                $errorMessage = $this->_pdo->errorInfo()[2];
                echo "Cannot delete the user. {$errorMessage}";
            } else {
                echo "Error deleting user";
            }
        }
    
        return $result;
    }
    
    

    public function getUsersByType($userType) {
        return $this->query("SELECT * FROM utilisateur WHERE userType = ?", [$userType])->results();
    }
    
    public function linkUsers($table, $parentField, $studentField, $parentId, $studentId) {
        $sql = "INSERT INTO {$table} ({$parentField}, {$studentField}) VALUES (?, ?)";
        $values = array($parentId, $studentId);

        $stmt = $this->_pdo->prepare($sql);

        try {
            $stmt->execute($values);
            return true;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }


    public function insert($table, $fields = array()){
        if(count ($fields)) {
            $keys = array_keys($fields);
            $values = null;
            $x = 1;
    
            foreach($fields as $field){
                $values .= "?";
                if($x < count($fields)){
                    $values .= ',';
                }
                $x++;
            }
    
            $sql = "INSERT INTO utilisateur (`"  . implode('`, `', $keys) .  "`) VALUES ({$values})";
    
            if(!$this->query($sql, array_values($fields))->error()) {
                return true;
            }
        }
        return false;
    }
    
    public function insertCourse($table, $fields = array()){
        if(count($fields)) {
            $keys = array_keys($fields);
            $values = null;
            $x = 1;
    
            foreach($fields as $field){
                $values .= "?";
                if($x < count($fields)){
                    $values .= ',';
                }
                $x++;
            }
    
            $sql = "INSERT INTO {$table} (`"  . implode('`, `', $keys) .  "`) VALUES ({$values})";
    
            if(!$this->query($sql, array_values($fields))->error()) {
                return true;
            }
        }
        return false;
    }
    
    
    public function update($table, $id, $fields) {
        $set ='';
        $x = 1;

        foreach($fields as $name => $value){
            $set .= "{$name} = ?";
            if($x < count($fields)){
                $set .= ', ';
            }
            $x++;
        }

        $sql = "UPDATE {$table} SET {$set} WHERE id = {$id}";

        if(!$this->query($sql, $fields)->error()){
            return true;
        }
        return false;
    }
    
    public function lastInsertId() {
        return $this->_pdo->lastInsertId();
    }

    public function getAllUsers() {
        return $this->query("SELECT * FROM utilisateur")->results();
    }

    public function results(){
        return $this->_results;
    }

    public function first(){
        return $this->results()[0];
    }

    public function error() {
        return $this->_error;
    }
    public function count() {
        return $this->_count;
    }
}
?>