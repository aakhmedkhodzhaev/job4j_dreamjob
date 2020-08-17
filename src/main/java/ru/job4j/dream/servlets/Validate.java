package ru.job4j.dream.servlets;

import ru.job4j.dream.model.User;

import java.util.List;

public interface Validate {

    User add(User user);

    List<User> getAll();

}