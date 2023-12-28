<?php
class LinkUser {
    private $_db;

    public function __construct() {
        $this->_db = DB::getInstance();
    }

    public function linkUsers($parentId, $studentId) {
        $fields = array('parent_id  ', 'eleve_id  ');
        $values = array($parentId, $studentId);

        return $this->_db->linkUsers('enfant_parent', 'parent_id  ', 'eleve_id  ', $parentId, $studentId);
    }
}
?>
