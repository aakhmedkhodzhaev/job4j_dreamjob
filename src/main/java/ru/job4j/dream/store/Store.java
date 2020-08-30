package ru.job4j.dream.store;

import ru.job4j.dream.model.Candidate;
import ru.job4j.dream.model.Post;
import ru.job4j.dream.model.User;

import java.util.Collection;
import java.util.Optional;

public interface Store {
    Collection<Post> findAllPosts();

    Collection<Candidate> findAllCandidates();

    Collection<User> findAllUsers();

    void save(Post post);

    Post findById(int id);

    void delete(Post post);

    void save(Candidate can);

    Candidate findCById(int id);

    void delete(Candidate can);

    void save(User user);

    User findUserById(int id);

    void delete(User user);

    User findEmailBy(String email);

    User findByUser(final String email,
                    final String password);

    Optional<User> findUserBy(final String email,
                              final String password);

    Optional<User> findByEmail(String email);
}