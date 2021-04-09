package com.supermarket.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.GoodsTypeDao;
import com.supermarket.entity.GoodsType;
import com.supermarket.service.GoodsTypeService;

@Service("goodsTypeService")
public class GoodsTypeServiceImpl implements GoodsTypeService {
    @Resource
    private GoodsTypeDao goodsTypeDao;

    @Override
    public List<GoodsType> findByGoodsType(Integer parentId) {
        return goodsTypeDao.findByGoodsType(parentId);
    }

    @Override
    public GoodsType findByStateId(Integer id) {
        return goodsTypeDao.findByStateId(id);
    }

    @Override
    public GoodsType findByPid(Integer id) {
        return goodsTypeDao.findByPid(id);
    }

    @Override
    public List<GoodsType> findAll(Map<String, Object> map) {
        return goodsTypeDao.findAll(map);
    }

    @Override
    public Integer delete(Integer id) {
        return goodsTypeDao.delete(id);
    }

    @Override
    public GoodsType isEchoes(String name) {
        return goodsTypeDao.isEchoes(name);
    }

    @Override
    public Integer update(GoodsType goodsType) {
        return goodsTypeDao.update(goodsType);
    }

    @Override
    public GoodsType findById(Integer id) {
        return goodsTypeDao.findById(id);
    }

    @Override
    public Integer add(GoodsType goodsType) {
        return goodsTypeDao.add(goodsType);
    }
}
