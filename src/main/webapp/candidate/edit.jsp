<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="ru.job4j.dream.model.Candidate" %>
<%@ page import="ru.job4j.dream.store.PsqlStore" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous"></script>

    <title>Работа мечты</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        let name = $('#name').val(),
            city = $('#city').val(),
            photo = $('#photo').val(),
            result = false;

        function validate() {
            if (name == '') {
                alert("Укажите данные кандита");
            } else if (city == '') {
                alert("Выберите город");
            } else if (photo == '') {
                alert("Выбеите фотографию");
            } else {
                result = true;
            }
            return result;
        }


        $(document).on("click", "#buttonLoad", function () {
            $.get("ajax", function (responseJson) {
                var $select = $("#listCity");
                $select.find("option").remove();
                $.each(responseJson, function (index, city) {
                    $("<option>").val(city.id).text(city.name).appendTo($select);
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
<div class="container pt-3">
    <div class="row">
        <div class="card" style="width: 100%">
            <div class="card-header">
                <% if (id == null) { %>
                Новая вакансия.
                <% } else { %>
                Редактирование вакансии.
                <% } %>
            </div>
            <div class="form-group">
                <form action="<%=request.getContextPath()%>/candidates.do?id=<%=can.getId()%>" method="post">
                    <div class="form-group">
                        <label>Имя</label>
                        <input type="text" class="form-control" id="name" name="name" value="<%=can.getName()%>">
                    </div>
                    <div class="form-select-button">
                        <label>Выберите Город: </label>
                        <button id="buttonLoad">Список городов</button> &nbsp;
                        <input type="text" class="form-control" id="city" name="city" value="<%=can.getCityId()%>">
                        <select id="listCity"></select>
                    </div>
                    <div class="form-group">
                        <br/><br/>
                        <label>Фотография</label>
                        <input type="text" class="form-control" id="photo" name="photo" value="<%=can.getPhotoId()%>">
                    </div>
                    <button id="buttonSubmit" type="submit" class="btn btn-primary" onclick="validate()">Сохранить
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>