package com.oggai.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @BelongsProject: ssm_crud_demo
 * @BelongsPackage: com.oggai.crud.bean
 * @Author: oggai
 * @Date: 2021/12/17 9:39
 * @Description: 将 Result 作为服务器统一返回给浏览器的类
 */
public class Result {

    private int code;
    private String msg;
    private Map<String, Object> resultMap = new HashMap<String, Object>();

    public static Result success() {
        Result result = new Result();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    public static Result fail() {
        Result result = new Result();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    /**
     * @author oggai
     * @date 2021/12/17 19:26
     * @description 将查询到的结果添加在属性 resultMap 中，返回给浏览器
     * @param key
     * @param value
     * @return com.oggai.crud.bean.Result
     */
    public Result add(String key, Object value) {
        this.getResultMap().put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getResultMap() {
        return resultMap;
    }

    public void setResultMap(Map<String, Object> resultMap) {
        this.resultMap = resultMap;
    }

}
