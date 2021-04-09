package com.supermarket.dao;

import java.util.List;
import java.util.Map;

import com.supermarket.entity.Goods;

public interface GoodsDao {

    Goods findByTypeId(Integer id);

    List<Goods> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Goods findCode(Integer id);

    Goods isEchoe(String name);

    Integer add(Goods goods);

    Integer update(Goods goods);

    Goods findById(Integer id);

    Goods finddel(Integer id);
}
