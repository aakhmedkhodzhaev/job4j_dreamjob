package ru.job4j.dream.servlets;

import ru.job4j.dream.model.User;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;


public class ValidateService implements Validate {

    private static AtomicInteger USER_ID = new AtomicInteger(4);

    private List<User> users = new CopyOnWriteArrayList<>();

    private static final ValidateService instance = new ValidateService();

    public static ValidateService getInstance() {
        return instance;
    }

    private ValidateService() {
        this.users.add(new User(1, "Petr", "loocal@lc.lc", "1"));
    }

    @Override
    public User add(User user) {
        if (user.getId() == 0) {
            user.setId(USER_ID.incrementAndGet());
        }
        this.users.add(user.getId(), user);
        return user;
    }

    @Override
    public List<User> getAll() {
        return this.users;
    }
}
