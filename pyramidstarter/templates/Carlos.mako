<!doctype html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="author" content="Matteo Ferla">
        <meta name="description" content="VCF caller">
        <meta name="keywords" content="">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>VCF caller</title>
        <style>
            body {
                font-family: monospace;
                background-color: black;
                color:#00FF00;
            }
        </style>
    </head>

    <body>
        <p>Hola Carlito!</p>
        <form action="/Carlos_submit" method="post" enctype="multipart/form-data">Genbank file:
            <br>
            <input type="file" name="genbank" id="genbank">
            <br>Variant Call file from CLC:
            <br>
            <input type="file" name="vcf" id="vcf">
            <br>
            <input type="submit" value="Submit">
        </form>
    </body>

</html>