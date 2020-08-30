package ru.job4j.dream.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.json.JSONException;
import org.json.JSONObject;
import ru.job4j.dream.model.User;
import ru.job4j.dream.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class JsonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");
        resp.setHeader("Cache-control", "no-cache, no-store");
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Expires", "-1");

        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "POST");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type");
        resp.setHeader("Access-Control-Max-Age", "86400");

        Gson gson = new Gson();
        JsonObject myObj = new JsonObject();

        User userInfo = PsqlStore.instOf().findEmailBy(email);
        JsonElement userObj = gson.toJsonTree(userInfo);
        if (userInfo.getName() == null) {
            myObj.addProperty("success", false);
        } else {
            myObj.addProperty("success", true);
        }
        myObj.add("userInfo", userObj);
        out.println(myObj.toString());

        out.close();

    }

}