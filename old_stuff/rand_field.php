<?php
require_once('sad.inc.php');

$c_col = 64;
$c_row = 64;
$c_br = "\n";
$c_chars = array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'N', 'E', '°', '.');
$c_regex = '/1(.)9.*?N(.)3/si';
srand(666);

$output = '';
$match = array();
$char_count = count($c_chars)-1;

for($r=0; $r<$c_row; $r++){
 for($c=0; $c<$c_col; $c++){
  $output .= $c_chars[rand(0, $char_count)];
 }
 $output .= $c_br;
}

preg_match_all($c_regex, $output, $match);


$output = preg_replace('/0(.)2/is', '0<b>\1</b>2', $output);
$output = preg_replace('/(64)/', '<u>\1</u>', $output);

echo "<pre>".$output."</pre>";
sad($match);
?>