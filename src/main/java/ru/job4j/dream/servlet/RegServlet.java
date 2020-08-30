package ru.job4j.dream.servlet;

import ru.job4j.dream.model.User;
import ru.job4j.dream.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        if (user.getEmail() != null) {
            req.setAttribute("email", PsqlStore.instOf().findByEmail(user.getEmail()));
        }
        req.getRequestDispatcher("reg.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name"),
                email = req.getParameter("email"),
                password = req.getParameter("password");

        req.setCharacterEncoding("UTF-8");
        if (PsqlStore.instOf().findByEmail(email) == null
                && name != "" && email != "" && password != ""
                && name.length() > 5 && email.length() > 5 && password.length() > 0) {
            PsqlStore.instOf().save(
                    new User(
                            name, // req.getParameter("name"),
                            email, // req.getParameter("email"),
                            password // req.getParameter("password")
                    )
            );
            resp.sendRedirect(req.getContextPath() + "/index.do");
        } else {
            resp.sendRedirect(req.getContextPath() + "/reg.do");
        }
    }

}