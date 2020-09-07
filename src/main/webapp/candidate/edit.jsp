<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="ru.job4j.dream.model.Candidate" %>
<%@ page import="ru.job4j.dream.store.PsqlStore" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <title>Test Ajax List of City</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function chooseCity() {
            $.get("ajax", function (responseJson) {
                var $select = $("#Citylist");
                $select.find("option").remove();
                $.each(responseJson, function (index, city) {
                    $("<option>").val(city.id).text(city.name).appendTo($select);
                });

            });
        };
    </script>
</head>
<body>
<%
    String id = request.getParameter("id");
    Candidate can = new Candidate(0, "");
    if (id != null) {
        can = PsqlStore.instOf().findCById(Integer.valueOf(id));
    }
%>
<div align="center">
    <div class="card-header">
        <% if (id == null) { %>
        Новая вакансия.
        <% } else { %>
        Редактирование вакансии.
        <% } %>
    </div>
    <h2>Test Ajax List of City</h2>
    <form action="<%=request.getContextPath()%>/candidates.do?id=<%=can.getId()%>" method="post">
        <td>
            <tr>
                Name: <input id="name" name="name" placeholder="name"/>
            </tr>
        </td>
        <br>
        <br>
   <!-- <button name="cityId" onclick="chooseCity()">Load</button> &nbsp;
        <select id="Citylist"></select> -->
        <select name="cityId">
            <option value="1">Astana</option>
            <option value="2">Minsk</option>
            <option value="3">Moskow</option>
            <option value="4">Kiev</option>
            <option value="5">Tashkent</option>
            <option value="6">Yerevan</option>
            <option value="7">Baku</option>
            <option value="8">Riga</option>
        </select>
        <br/>
        <p>Upload Image:</p>
        <form action="/upload" method="post" enctype="multipart/form-data">
            <div class="check-box" align="center">
                <td>
                    <tr>
                        <input type="file" id="file" name="photoId"/>
                    </tr>
                </td>
            </div>
            </br>
            <button type="submit" id="buttonSubmit">Submit</button>
        </form>
    </form>
</div>
</body>
</html>