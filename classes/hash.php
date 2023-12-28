<?php

class Hash {
    public static function make($string) {
        // Use password_hash with the default algo
        return password_hash($string, PASSWORD_DEFAULT);
    }

    public static function salt($length) {
        // Generate a random binary
        $binarySalt = random_bytes($length);
        // Convert the binary salt to a hexadecimal
        return bin2hex($binarySalt);
    }

    public static function unique() {
        return self::make(uniqid());
    }

    public static function verify($string, $hashedString) {
        // Use password_verify to compare a string with its hashed version
        return password_verify($string, $hashedString);
    }
}


?>