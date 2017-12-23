<?php

class Database {

    private $host;
    private $name;
    private $user;
    private $password;

    private $connection;

    public function __construct() {
        $this->host = $GLOBALS['config']['database']['host'];
        $this->name = $GLOBALS['config']['database']['name'];
        $this->user = $GLOBALS['config']['database']['user'];
        $this->password = $GLOBALS['config']['database']['password'];
    }

    public function getConnection() {
        if (!isset($this->connection)) {
            try {
                $this->connection = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->name, $this->user, $this->password);
                $this->connection->exec("set names utf8");
            } catch (PDOException $exception) {
                echo "Connection error: " . $exception->getMessage();
            }
        }
        return $this->connection;
    }

    public function prepare($statement, $parameter, $value) {
        $value = htmlspecialchars(strip_tags($value));
        $statement->bindParam($parameter, $value);
    }

}