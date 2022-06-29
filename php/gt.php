<?php
$fp = $_GET['fp'];
$file = file_get_contents($fp);
echo "<pre>";
echo $file;
echo "</pre>";
die;
?>
