package com.oggai.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.oggai.crud.bean.Employee;
import com.oggai.crud.bean.Result;
import com.oggai.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @BelongsProject: ssm_crud_demo
 * @BelongsPackage: com.oggai.crud.controller
 * @Author: oggai
 * @Date: 2021/12/17 9:30
 * @Description: TODO
 */
@Controller
public class EmployeeController {

    private final int PAGE_SIZE = 10;
    private final int NAVIGATOR_PAGES = 7;

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/getEmployees")
    @ResponseBody
    public Result getEmpWithJson(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {

        PageHelper.startPage(pageNum, PAGE_SIZE);

        List<Employee> employeeList = employeeService.getAll();

        PageInfo<Employee> pageInfo = new PageInfo<Employee>(employeeList, NAVIGATOR_PAGES);

        return Result.success().add("pageInfo", pageInfo);
    }

    @RequestMapping("/checkEmployeeName")
    @ResponseBody
    public Result checkEmployeeName(@RequestParam("empName") String employeeName) {
        // 正则表达式验证
        String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";

        if (!employeeName.matches(regex)) {
            return Result.fail().add("errorMsg", "用户名必须是6-16位数字和字母的组合或者2-5位中文！");
        }

        // 搜索数据库是否存在该用户名，存在返回 false，否则返回 true
        boolean isNotExist = employeeService.checkEmployee(employeeName);

        if (isNotExist) {
            return Result.success();
        } else {
            return Result.fail().add("errorMsg", "用户名不可用");
        }

    }

    /**
     * @param employee
     * @param result
     * @return com.oggai.crud.bean.Result
     * @author oggai
     * @date 2021/12/22 11:34
     * @description @Valid 和 BindingResult 通常联合使用
     * Valid 用来验证对象是否符合要求，通常在对象属性上有限制，见 Employee 对象
     * BindingResult 用来返回结果信息
     */
    @RequestMapping(value = "/saveEmployee", method = RequestMethod.POST)
    @ResponseBody
    public Result saveEmployee(@Valid Employee employee, BindingResult result) {

        if (result.hasErrors()) {

            HashMap<String, Object> hashMap = new HashMap<String, Object>();

            for (FieldError fieldError : result.getFieldErrors()) {
                hashMap.put(fieldError.getField(), fieldError.getDefaultMessage());
            }

            Result returnResult = new Result();
            returnResult.setCode(200);
            returnResult.setMsg("处理失败！");
            // 将结果带回客户端
            returnResult.setResultMap(hashMap);

            return returnResult;

        } else {
            employeeService.saveEmployee(employee);
            return Result.success();
        }
    }

    @RequestMapping(value = "/getEmployee/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Result getEmployeeById(@PathVariable("id") Integer id) {

        Employee employee = employeeService.getEmployeeById(id);
        return Result.success().add("emp", employee);
    }

    /**
     * @author oggai
     * @date 2021/12/23 13:48
     * @description 这里有个大坑！
     * PUT 请求传来的参数会接收不到。需要配置插件解决该问题。
     *
     *  Tomcat 处理参数的问题：
     *  1.将请求体中的数据，封装成一个 map
     *  2.request.getParameter("id")就会从这个 map 中取值
     *  3.SpringMvc 封装 POJO 对象的时候， 会把 POJO 中每个属性的值进行 request.getParameter();
     *  4.AJAX 发送 PUT，DELETE 请求，请求体中的数据，request.getParameter()拿不到
     *  因为 Tomcat 一看是 PUT, DELETE 就不会封装请求体中的数据为 map，只有 POST 形式的请求才封装请求为 map。
     *
     * @param employee
     * @return com.oggai.crud.bean.Result
     */
    @RequestMapping(value = "/updateEmployee/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Result updateEmployee(Employee employee) {

        employeeService.updateEmployee(employee);
        return Result.success();
    }

    @RequestMapping(value = "/deleteEmployee/{idStr}", method = RequestMethod.DELETE)
    @ResponseBody
    public Result deleteEmployee(@PathVariable("idStr") String idStr) {

        if (idStr.contains("-")) {

            List<Integer> integerList = new ArrayList<Integer>();
            // 拆解字符串
            for (String s : idStr.split("-")) {
                integerList.add(Integer.valueOf(s));
            }

            employeeService.deleteEmployeeBatch(integerList);

        } else {
            employeeService.deleteEmployee(Integer.valueOf(idStr));
        }
        return Result.success();
    }
}
