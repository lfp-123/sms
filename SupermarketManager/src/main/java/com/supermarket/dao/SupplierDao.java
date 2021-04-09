package com.supermarket.dao;

import java.util.List;
import java.util.Map;

import com.supermarket.entity.Supplier;

public interface SupplierDao {
    List<Supplier> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Integer add(Supplier supplier);

    Supplier findRepeat(String name);

    Integer delete(Integer id);

    Integer update(Supplier supplier);
}
