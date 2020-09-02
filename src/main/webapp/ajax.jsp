<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="ISO-8859-1"%>
<html>
<head>
    <title>Test Ajax List of City</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        $(document).on("click", "#buttonLoad", function() {
            $.get("ajax", function(responseJson) {
                var $select = $("#Citylist");
                $select.find("option").remove();
                $.each(responseJson, function(index, city) {
                    $("<option>").val(city.id).text(city.name).appendTo($select);
                });

            });
        });

        $(document).on("click", "#buttonSubmit", function() {
            var params = {city : $("#Citylist option:selected").text()};
            $.post("ajax", $.param(params), function(responseText) {
                alert(responseText);
            });
        });
    </script>
</head>
<body>
<div align="center">
    <h2>Test Ajax List of City</h2>
    <button id="buttonLoad">Load</button> &nbsp;
    <select id="Citylist"></select>
    <br/><br/>
    <button id="buttonSubmit">Submit</button>
</div>
</body>
</html>