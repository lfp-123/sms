package com.supermarket.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.UserDao;
import com.supermarket.entity.User;
import com.supermarket.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Resource
	private UserDao userDao;

	@Override
	public User findByUserName(String userName) {
		return userDao.findByUserName(userName);
	}

	@Override
	public List<User> findAll(Map<String, Object> map) {
		return userDao.findAll(map);
	}

	@Override
	public Long count(Map<String, Object> map) {
		return userDao.count(map);
	}

	@Override
	public Integer add(User user) {
		return userDao.add(user);
	}

	@Override
	public Integer delete(Integer id) {
		return userDao.delete(id);
	}

	@Override
	public Integer update(User user) {
		return userDao.update(user);
	}

	@Override
	public Integer updateReset(Integer id) {
		return userDao.updateReset(id);
	}

	@Override
	public User findRoleId(String userName) {
		return userDao.findRoleId(userName);
	}

	@Override
	public Set<String> selectRolesByUsername(String username) {
		return userDao.selectRolesByUsername(username);
	}
}
