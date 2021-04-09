package com.supermarket.dao;

import java.util.List;
import java.util.Map;

import com.supermarket.entity.Order;

public interface OrderDao {
    Order getTodayMaxNumber();

    List<Order> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Integer add(Order order);
}
