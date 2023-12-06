package service.implement;

import model.User;
import repository.IUserRepository;
import repository.implement.UserRepository;
import service.IUserService;

import java.util.List;

public class UserService implements IUserService {
    IUserRepository repository = new UserRepository();
    @Override
    public void insertUser(User user) {
        repository.insertUser(user);
    }

    @Override
    public User selectUser(int id) {
        return repository.selectUser(id);
    }

    @Override
    public List<User> selectAllUsers() {
        return repository.selectAllUsers();
    }

    @Override
    public boolean deleteUser(int id) {
        return repository.deleteUser(id);
    }

    @Override
    public boolean updateUser(User user) {
        return repository.updateUser(user);
    }

    @Override
    public List<User> searchUserByName(String name) {
        return repository.searchUserByName(name);
    }

    @Override
    public List<User> searchUserByCountry(String country) {
        return repository.searchUserByCountry(country);
    }
}
