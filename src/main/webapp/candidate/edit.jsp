<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="ru.job4j.dream.model.Candidate" %>
<%@ page import="ru.job4j.dream.store.PsqlStore" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <title>Работа мечты</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function validate() {
            let name = $('#name').val(),
                cityId = $('#cityId').val(),
                photoId = $('#photoId').val(),
                result = false;
            if (name == '') {
                alert('Заполните поле Имя');
            } else if (cityId == '') {
                alert('Выберите город');
            } else if (photoId == '') {
                alert('Загрузите фотографию')
            } else {
                result = true;
            }
            return result;
        }


        $(document).ready(function () {

            $("#but_upload").click(function () {

                var fd = new FormData();
                var files = $('#photoId')[0].files[0];
                fd.append('file', files);

                $.ajax({
                    url: '/dreamjob/upload',
                    type: 'post',
                    data: fd,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response != 0) {
                            $("#img").attr("src", response);
                            $(".preview img").show(); // Display image element
                        } else {
                            alert('file not uploaded');
                        }
                    },
                });
            });
        });
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
    <br/>
    <form method="post" action="" enctype="multipart/form-data">
        <div>
            <label for="photoId"> Выберите фотографию: </label>
            <br/>
            <input type="file" id="photoId" name="photoId" placeholder="photoId"/>
        </div>
            <br/>
        <input type="button" class="button" value="Upload" id="but_upload">
    </form>

    <form action="<%=request.getContextPath()%>/candidates.do?id=<%=can.getId()%>" method="post">
        <td>
            <tr>
                Name: <input id="name" name="name" placeholder="name"/>
            </tr>
        </td>
        <br>
        <br>
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
        <br/>
        <button type="submit" id="buttonSubmit" onclick="validate()">Submit</button>
    </form>
</div>
</body>
</html>