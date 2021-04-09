package com.supermarket.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.supermarket.entity.Order;
import com.supermarket.service.OrderService;
import com.supermarket.util.DateUtil;
import com.supermarket.util.ResponseUtil;

@RestController
@RequestMapping("/orderList")
public class OrderController {
    @Resource
    private OrderService orderService;

    @RequestMapping("/genCode")
    public String genCode() throws Exception {
        StringBuilder code = new StringBuilder("JH");
        code.append(DateUtil.getCurrentDateStr());
        Order order = orderService.getTodayMaxNumber();
        if (order != null) {
            String purchaseNumber = order.getCode();
            code.append(DateUtil.formatCode(purchaseNumber));
        } else {
            code.append("0001");
        }
        return code.toString();
    }

    @ResponseBody
    @RequestMapping("/order")
    public Map<String, Object> goodsList(Order order,
                                         @RequestParam(value = "page", required = false) Integer page,
                                         @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        if (order.getCode() != null) {
            result.put("code", order.getCode());
        }
        List<Order> orderList = orderService.findAll(result);
        Long count = orderService.count(result);
        for (Order value : orderList) {
            String releaseStr = DateUtil.format(value.getCreatedate());
            String releaseStrPay = DateUtil.format(value.getPaydate());
            value.setReleaseStr(releaseStr);
            value.setReleaseStrPay(releaseStrPay);
        }
        return ResponseUtil.result(orderList, count);
    }

    @ResponseBody
    @RequestMapping("/orderSave")
    public Map<String, Object> save(Order order) throws Exception {
        Map<String, Object> result = new HashMap<>(2);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date pay = sdf.parse(order.getReleaseStrPay());
        order.setPaydate(pay);
        orderService.add(order);
        result.put("success", true);
        return result;
    }
}
