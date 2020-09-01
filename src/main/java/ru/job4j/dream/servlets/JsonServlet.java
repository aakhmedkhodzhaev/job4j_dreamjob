package ru.job4j.dream.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import ru.job4j.dream.model.City;
import ru.job4j.dream.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;


public class JsonServlet extends HttpServlet {

    private Gson gson = new Gson();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        Collection<City> citys = PsqlStore.instOf().findAllCity();

        gson = new GsonBuilder().setPrettyPrinting().create();
        String json = gson.toJson(citys);
        resp.getWriter().write(json);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        PsqlStore.instOf().save(
                new City(Integer.valueOf(req.getParameter("id")),
                        req.getParameter("name")));

        resp.sendRedirect(req.getContextPath() + "/json");
    }
}