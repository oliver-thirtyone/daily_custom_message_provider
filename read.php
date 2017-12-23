<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json; charset=UTF-8");

$instance = isset($_GET['instance']) ? $_GET['instance'] : die('Missing parameter: instance');
$date = isset($_GET['date']) ? $_GET['date'] : die('Missing parameter: date');

include_once 'config/configuration.php';
include_once 'inc/Database.php';
include_once 'inc/Message.php';

$database = new Database();
$message = new Message($database);

$entities = $message->getEntries($instance, $date);

if (!empty($entities)) {
    echo json_encode($entities);
} else {
    $nextDate= $message->getNextDate($instance, $date);

    $result = array(
        'error' => "No entries found.",
        'next_date' => $nextDate,
    );
    echo json_encode($result);
}
