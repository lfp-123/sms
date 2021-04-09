package com.supermarket.service;

import java.util.List;
import java.util.Map;

import com.supermarket.entity.Goods;

public interface GoodsService {
    Goods findByTypeId(Integer id);

    List<Goods> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Goods findCode(Integer id);

    Goods isEchoe(String name);

    Integer add(Goods goods);

    Integer update(Goods goods);

    Goods finddel(Integer id);

    Goods findById(Integer id);
}
