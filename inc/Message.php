<?php

class Message {

    private $database;

    public function __construct($database) {
        $this->database = $database;
    }

    public function readEntries($instance, $date) {
        $query = "SELECT message_entry.pk AS pk, message_entry.entry AS entry, message_entry_type.type AS type, message_entry.sorting AS sorting" .
            " FROM message_entry" .
            " LEFT JOIN message_entry_type ON (message_entry_type.pk=message_entry.fk_message_entry_type)" .
            " LEFT JOIN message ON (message.pk=message_entry.fk_message)" .
            " LEFT JOIN instance ON (instance.pk=message.fk_instance)" .
            " WHERE instance.name = :instance_name AND message.date = :message_date" .
            " ORDER BY message_entry.sorting";

        $statement = $this->database->getConnection()->prepare($query);

        $this->database->prepare($statement, ":instance_name", $instance);
        $this->database->prepare($statement, ":message_date", $date);

        $statement->execute();
        return $statement->fetchAll();
    }

}