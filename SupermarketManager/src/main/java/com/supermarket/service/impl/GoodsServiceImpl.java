package com.supermarket.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.GoodsDao;
import com.supermarket.entity.Goods;
import com.supermarket.service.GoodsService;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {
    @Resource
    private GoodsDao goodsDao;

    @Override
    public Goods findByTypeId(Integer id) {
        return goodsDao.findByTypeId(id);
    }

    @Override
    public List<Goods> findAll(Map<String, Object> map) {
        return goodsDao.findAll(map);
    }

    @Override
    public Long count(Map<String, Object> map) {
        return goodsDao.count(map);
    }

    @Override
    public Goods findCode(Integer id) {
        return goodsDao.findCode(id);
    }

    @Override
    public Goods isEchoe(String name) {
        return goodsDao.isEchoe(name);
    }

    @Override
    public Integer add(Goods goods) {
        return goodsDao.add(goods);
    }

    @Override
    public Integer update(Goods goods) {
        return goodsDao.update(goods);
    }

    @Override
    public Goods finddel(Integer id) {
        return goodsDao.finddel(id);
    }

    @Override
    public Goods findById(Integer id) {
        return goodsDao.findById(id);
    }
}
