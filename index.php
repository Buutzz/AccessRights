<?php

declare(strict_types=1);

//Creating autoload for class
spl_autoload_register(function ($class) {
    require __DIR__ . "/src/$class.php";
});

//Create database connection
$database = new Database("host", "db_name", "db_user", "password");
//Declare object for checking users access rights
$access = new AccessRights($database);

//Check access right on dummy data
$user = 'user3';
$functionName = 'function1';

var_dump($access->checkAccess($user, $functionName));