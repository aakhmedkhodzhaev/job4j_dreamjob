package ru.job4j.dream.servlets;

import org.junit.Test;
import ru.job4j.dream.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

public class UserServletTest {

    @Test
    public void whenAddUserThenStoreIt() throws ServletException, IOException {
        UserServlet validate = new UserServlet();

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        when(req.getParameter("name")).thenReturn("Petr");
        validate.doPost(req, resp);

        List<User> users = ValidateService.getInstance().getAll();

        assertThat(users.get(1).getName(), is("Petr"));
    }
}