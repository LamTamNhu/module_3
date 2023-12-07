package service;

import model.User;

import java.util.List;

public interface IUserService {
    public void insertUser(User user);

    public User selectUser(int id);

    public List<User> selectAllUsers();

    public boolean deleteUser(int id);

    public boolean updateUser(User user);

    List<User> searchUserByName(String name);

    List<User> searchUserByCountry(String country);
}
