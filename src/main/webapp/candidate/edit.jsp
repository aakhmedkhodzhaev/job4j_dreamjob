<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="ru.job4j.dream.store.PsqlStore" %>
<%@ page import="ru.job4j.dream.model.Candidate" %>
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
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
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
                var cityName = [
                    {"label": "Astana", "value": "Astana", "id": 1},
                    {"label": "Minsk", "value": "Minsk", "id": 2},
                    {"label": "Moskow", "value": "Moskow", "id": 3},
                    {"label": "Kiev", "value": "Kiev", "id": 4},
                    {"label": "Tashkent", "value": "Tashkent", "id": 5},
                    {"label": "Yerevan", "value": "Yerevan", "id": 6},
                    {"label": "Baku", "value": "Baku", "id": 7},
                    {"label": "Riga", "value": "Riga", "id": 8}
                ];
                $("#cityName").autocomplete(
                    {
                        source: cityName,
                        change: function (event, ui) {
                            $("#cityId").val(ui.item.id)
                        }
                    });
            }
        );

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
    Candidate can = new Candidate(0, "", 0, "");
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
            <div class="card-body">
                <form method="post" action="" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="photoId"> Выберите фотографию: </label>
                        <br/>
                        <input type="file" id="photoId" name="photoId" placeholder="photoId"/>
                    </div>
                    <br/>
                    <input type="button" class="button" value="Upload" id="but_upload">
                </form>
                <form action="<%=request.getContextPath()%>/candidates.do?id=<%=can.getId()%>" method="post">
                    <div class="form-group">
                        <label>Имя</label>
                        <input type="text" id="name" class="form-control" name="name" value="<%=can.getName()%>"
                               placeholder="name"/>
                        <br>
                        <label>Наименование города</label>
                        <input type="text" id="cityName" class="form-control" name="cityName"
                               placeholder="city Name"/>
                    </div>
                    <!--
                    <select name="cityId">
                        <option value="1">Astana</option>
                        <option value="2">Minsk</option>
                        <option value="3">Moskow</option>
                        <option value="4">Kiev</option>
                        <option value="5">Tashkent</option>
                        <option value="6">Yerevan</option>
                        <option value="7">Baku</option>
                        <option value="8">Riga</option>
                    </select>-->
                    <input type="hidden" class="form-control" id="cityId" name="cityId" value="<%=can.getCityId()%>">
                    <br/>
                    <br/>
                    <button type="submit" class="btn btn-primary"
                            id="buttonSubmit" onclick="validate()">Сохранить</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>