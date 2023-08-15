<?php

/**
   * Access Rights
   * 
   * @author Mateusz Wodjala <wojdala.mateusz@gmail.com>
   */

class AccessRights{


    private PDO $conn;
    
    /**
     * @param object $database object
     * @return PDO object
     */
    public function __construct(Database $database)
    {
        $this->conn = $database->getConnection();
    }

    /**
     * Function checking if user has access to function
     * @param string $username name of the user account
     * @param string functionName name of function reguired to check
     * @return boolean
     */
    public function checkAccess($username, $functionName) {
        
        //Query including checking user rights and user group rights in database
        $query = $this->conn->prepare("
            SELECT COUNT(*) as access_count
            FROM users u
            LEFT JOIN user_group_relations ugr ON u.id = ugr.user_id
            LEFT JOIN function_rights fr ON u.id = fr.user_id OR ugr.group_id = fr.group_id
            LEFT JOIN module_functions mf ON fr.module_id = mf.module_id OR fr.function_id = mf.id
            WHERE u.username = :username AND mf.function_name = :functionName
        ");
        
        $query->execute(['username' => $username, 'functionName' => $functionName]);
        $result = $query->fetch(PDO::FETCH_ASSOC);
        
        return $result['access_count'] > 0;
    }

}