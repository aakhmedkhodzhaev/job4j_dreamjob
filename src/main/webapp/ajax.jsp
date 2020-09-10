<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="ISO-8859-1" %>
<html>
<head>
    <title>Ajax List of City</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        $(document).on("click", "#buttonLoad", function () {
            $.get("ajax", function (responseJson) {
                var $select = $("#Citylist");
                $select.find("option").remove();
                $.each(responseJson, function (index, city) {
                    $("<option>").val(city.id).text(city.name).appendTo($select);
                });

            });
        });
    </script>
</head>
<body>
<div align="center">
    <h2>Test Ajax List of City</h2>
    <td>
        <tr>
            Name: <input id="candidate" name="candidate" placeholder="name"/>
        </tr>
    </td>
    <br>
    <br>
    <td>
        <tr>
            Email: <input id="email" name="email" placeholder="email"/>
        </tr>
    </td>
    <br>
    <br>
    <button id="buttonLoad">Load</button> &nbsp;
    <select id="Citylist"></select>
    <br/>
    <p>Upload Image:</p>
    <form action="/items/ajax" method="post" enctype="multipart/form-data">
        <div class="check-box" align="center">
            <td>
                <tr>
                    <input type="file" id="file" name="file"/>
                </tr>
            </td>
        </div>
        </br>
        <button type="submit" id="buttonSubmit">Submit</button>
    </form>
</div>
</body>
</html>