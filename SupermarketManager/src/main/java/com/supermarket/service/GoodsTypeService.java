package com.supermarket.service;

import java.util.List;
import java.util.Map;

import com.supermarket.entity.GoodsType;

public interface GoodsTypeService {
    List<GoodsType> findByGoodsType(Integer parentId);

    GoodsType findByStateId(Integer id);

    GoodsType findByPid(Integer id);

    List<GoodsType> findAll(Map<String, Object> map);

    Integer delete(Integer id);

    GoodsType isEchoes(String name);

    Integer update(GoodsType goodsType);

    GoodsType findById(Integer id);

    Integer add(GoodsType goodsType);
}
