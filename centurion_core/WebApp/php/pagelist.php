<?php
$sessid = $_COOKIE["sessionid"];
$sessions = file_get_contents("/etc/auth/sessions.json");
$sess_json = json_decode($sessions,true);
$valid = "false";
foreach($sess_json as $key => $value){
	if($value==$sessid && $sessid!="-1"){
	$valid = "true";
	}
}
if($valid == "true"){
exec("ls ../ | grep .html | sed -e 's/.html//g' | grep -v index ",$output);
echo json_encode($output);
}
?>
