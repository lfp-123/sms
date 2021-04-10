package com.supermarket.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.supermarket.entity.User;

public interface UserService {
    User findByUserName(String userName);

    List<User> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Integer add(User user);

    Integer delete(Integer id);

    Integer update(User user);

    Integer updateReset(Integer id);

    User findRoleId(String userName);

    Set<String> selectRolesByUsername(String username);
}
