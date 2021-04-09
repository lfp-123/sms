package com.supermarket.dao;


import com.supermarket.entity.UserRole;

public interface UserRoleDao {
    Integer add(UserRole userRole);

    UserRole findAll(String userName);

    Integer delete(Integer id);
}
