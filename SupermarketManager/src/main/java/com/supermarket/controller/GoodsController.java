package com.supermarket.controller;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.supermarket.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.supermarket.entity.Goods;
import com.supermarket.service.GoodsService;
import com.supermarket.util.ResponseUtil;

@Controller
@RequestMapping("/goods")
public class GoodsController {
    @Resource
    public GoodsService goodsService;

    @ResponseBody
    @RequestMapping("/goodsList")
    public Map<String, Object> goodsList(Goods goods,
                                         @RequestParam(value = "page", required = false) Integer page,
                                         @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        List<Goods> goodsList;
        result.put("state", 2);
        System.out.println(goods.getTypeId());
        if (StringUtil.isNotEmpty(goods.getName())) {
            result.put("name", goods.getName());
        }
        if (goods.getTypeId() != null) {
            result.put("typeId", goods.getTypeId());
        }
        goodsList = goodsService.findAll(result);
        Long count = goodsService.count(result);
        return ResponseUtil.result(goodsList, count);
    }

    @ResponseBody
    @RequestMapping("/save")
    public Map<String, Object> save(Goods goods) {
        Map<String, Object> result = new HashMap<>(4);
        if (goodsService.isEchoe(goods.getName()) != null) {
            result.put("success", false);
            result.put("errorInfo", "商品已存在,请检查！");
        } else {
            goodsService.add(goods);
            result.put("success", true);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/update")
    public Map<String, Object> update(Goods goods) {
        Map<String, Object> result = new HashMap<>(4);
        Goods goodsNumber = goodsService.findById(goods.getId());
        if (!goodsNumber.getNumber().equals(goods.getNumbers())) {
            goods.setNumber(goods.getNumbers());
        }
        goodsService.update(goods);
        result.put("success", true);
        return result;
    }

    @ResponseBody
    @RequestMapping("/updateReturn")
    public Map<String, Object> updateReturn(Goods goods) {
        Map<String, Object> result = new HashMap<>(4);
        Goods goodsNumber = goodsService.findById(goods.getId());
        int number = goodsNumber.getNumber() - goods.getReturnNumber();
        if (number > 0) {
            goods.setNumber(number);
        } else {
            result.put("success", false);
            result.put("errorInfo", "退货数量大于库存数量，退货失败");
            return result;
        }
        goodsService.update(goods);
        result.put("success", true);
        return result;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Map<String, Object> delete(@RequestParam(value = "id", required = false) Integer id) {
        Map<String, Object> result = new HashMap<>(4);
        Goods goods = new Goods();
        goods.setState(0);
        goods.setId(id);
        goodsService.update(goods);
        result.put("success", true);
        return result;
    }

    @ResponseBody
    @RequestMapping("/goodsDel")
    public Map<String, Object> goodsDel(Goods goods,
                                        @RequestParam(value = "page", required = false) Integer page,
                                        @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        if (StringUtil.isNotEmpty(goods.getName())) {
            result.put("name", goods.getName());
        }
        result.put("state", 0);
        List<Goods> goodsList = goodsService.findAll(result);
        Long count = goodsService.count(result);
        return ResponseUtil.result(goodsList, count);
    }

    @ResponseBody
    @RequestMapping("/goodsUpdate")
    public Map<String, Object> goodsUpdate(@RequestParam(value = "id", required = false) Integer id) {
        Map<String, Object> result = new HashMap<>(4);
        Goods goods = new Goods();
        goods.setState(2);
        goods.setId(id);
        goodsService.update(goods);
        result.put("success", true);
        return result;
    }


    @ResponseBody
    @RequestMapping("/updatenumber")
    public Map<String, Object> updateNumber(Goods goods) {
        Map<String, Object> result = new HashMap<>(4);
        Goods goodsNumber = goodsService.findById(goods.getId());
        goods.setSaleNumber(goods.getNumber());
        int number = goodsNumber.getNumber() - goods.getNumber();
        if (number > 0) {
            goods.setNumber(number);
        } else {
            result.put("success", false);
            result.put("errorInfo", "出售数量大于实际存货，出售失败");
            return result;
        }
        goodsService.update(goods);
        result.put("success", true);
        return result;
    }
}
