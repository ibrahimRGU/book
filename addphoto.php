<?php
session_start();
//include ("secureSessionID.php");//verify user session
//include ("inactiveTimeOut.php");//check user idle time
?>
<?php
$name = $_SESSION["username"];
$userID=$_SESSION["userid"];
$ip=$_SESSION["ip"];

?>
<?php
include("connection.php"); //Establishing connection with our database


//check session highjacking
if (!($ip==$_SERVER['REMOTE_ADDR'])){
    header("location: logout.php"); // Redirecting To Other Page
}

//check logut/idle time
if($_SESSION ["timeout"]+60 < time()){

    //session timed out
    header("location: logout.php"); // Redirecting To Other Page
}else{
    //reset session time
    $_SESSION['timeout']=time();
}
$msg = ""; //Variable for storing our errors.

if(isset($_POST["submit"]))
{

    $title = $_POST["title"];
    $desc = $_POST["desc"];
    $url = "test";
    //clean input title
    $title = stripslashes( $title );
    $title=mysqli_real_escape_string($db,$title);
    $title = htmlspecialchars( $title );


    //clean input description
    $desc = stripslashes( $desc );
    $desc=mysqli_real_escape_string($db,$desc);
    $desc = htmlspecialchars( $desc );


    //check for file upload error
    if($_FILES['fileToUpload']['error'] == 0) {

        // Where are we going to be writing to?
        $target_dir = "uploads/";
        $target_file = basename($_FILES['fileToUpload']['name']);

        // File information
        $uploaded_name = $_FILES['fileToUpload']['name'];
        $uploaded_ext = substr($uploaded_name, strrpos($uploaded_name, '.') + 1);
        $uploaded_size = $_FILES['fileToUpload']['size'];
        $uploaded_tmp = $_FILES['fileToUpload']['tmp_name'];
        $uploadOk = 1;
    }

    if($userID >0) {

        //restrict file type and size
        if( ( strtolower( $uploaded_ext ) == "jpg" || strtolower( $uploaded_ext ) == "jpeg" || strtolower( $uploaded_ext ) == "png" ) &&
            ( $uploaded_size < 600000 ) &&
            getimagesize( $uploaded_tmp ) ) {

            // Can we move the file to the upload folder?
            if (move_uploaded_file($uploaded_tmp, $target_file)) {
                //connect to db
                $mysqli = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
                //if(!$mysqli) die('Could not connect$: ' . mysqli_error());

                //test connection
                if ($mysqli->connect_errno) {
                    echo "Connection Fail:Check network connection";//: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
                }

                //call procedure
                if (!$mysqli->query("CALL sp_photos('$title','$desc','$target_file','$userID')")) {

                } else {

                    $msg = "Thank You! The file " . basename($_FILES["fileToUpload"]["name"]) . " has been uploaded. click <a href='photos.php'>here</a> to go back";

                }
            }
            else{
                $msg = "Your image was not uploaded";
            }
        }else{
            $msg = "Your image was not uploaded. We can only accept JPEG , PNG or  a maximum size of 600kb.";
        }

    }
    else{
        $msg = "You need to login first";
    }
}

?>
