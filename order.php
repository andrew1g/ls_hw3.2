<?php

// **Задача #3.2**

// 1. **[Скачайте]** верстку сайта **“Бургерная”**
// 2. Внизу вы найдете форму заказа, напишите **скрипт**, обрабатывающий эту форму. 
// **Скрипт должен:**
// - Проверить, существует ли уже пользователь с таким email, 
//     если нет - создать его, если да - увеличить число заказов по этому email. 
//     Двух пользователей с одинаковым email быть не может.
// - Сохранить данные заказа - id пользователя, сделавшего заказ, 
// дату заказа, полный адрес клиента.
// - Скрипт должен вывести пользователю:

// ```jsx
// Спасибо, ваш заказ будет доставлен по адресу: “тут адрес клиента”
// Номер вашего заказа: #ID
// Это ваш n-й заказ!
// ```

// Где **ID** - уникальный идентификатор только что созданного заказа 
// **n** - общий кол-во заказов, который сделал пользователь с этим email 
// включая текущий

//var_dump($_POST);

//проверка пользователя в таблице clients в БД  с таким email
$id_client_order = 0;
$email = htmlspecialchars($_POST['email']);
$name = htmlspecialchars($_POST['email']);
$fulladdress =  htmlspecialchars('Санкт-Петербург, улица '. $_POST['street']) . ", дом " .  htmlspecialchars($_POST['home']);
$corpus = htmlspecialchars($_POST['part']);
if (!empty($corpus)) {
    $fulladdress = $fulladdress . ", корпус " .  $corpus;
}
$fulladdress = $fulladdress.  ", квартира " .htmlspecialchars($_POST['appt']). ", этаж " .  htmlspecialchars($_POST['floor']);

$connection = new PDO("mysql:host=localhost;dbname=ls_ordersdb", "root", "");
$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$exec = $connection->prepare("SELECT * FROM clients WHERE email = ?");
$exec->execute([$email]);
if ($exec->rowCount() > 0) {
    while($row = $exec->fetch()){
        $id_client_order = $row["id"];              
    } 
}
    else {
        //создаем нового клиента в таблице clients в БД                
        $id__client_order = 0;
        $sql = "INSERT INTO clients (email, name) VALUES (?,?)";        
        $exec= $connection->prepare($sql);
        $exec->execute([$email, $name]);     
        $id_client_order = $connection->lastInsertId();            


}

    //добавляем новый заказ в таблицу orders в БД
    $sql = "INSERT INTO orders (client_id, date, address) VALUES (?,?,?)";
    $exec= $connection->prepare($sql);
    $curdate=date("Y-m-d H:i:s");
    $exec->execute([$id_client_order, $curdate, $fulladdress]);                 
    $lastId = $connection->lastInsertId();


    //Выводим сообщение о создании нового заказа
    Echo "Спасибо, ваш заказ будет доставлен по адресу: $fulladdress".'<br>';
    Echo "Номер вашего заказа: # $lastId".'<br>';
    
    //Выбираем количество заказов и выводим
    $exec = $connection->prepare("SELECT count(*) FROM orders WHERE client_id = ?");    
    $exec->execute([$id_client_order]);
    $count_orders = $exec->fetchColumn();        
    Echo "Это ваш $count_orders заказ!".'<br>';
?>