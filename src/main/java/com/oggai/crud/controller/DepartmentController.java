package com.oggai.crud.controller;

import com.oggai.crud.bean.Department;
import com.oggai.crud.bean.Result;
import com.oggai.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @BelongsProject: ssm_crud_demo
 * @BelongsPackage: com.oggai.crud.controller
 * @Author: oggai
 * @Date: 2021/12/18 16:12
 * @Description: TODO
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/departments")
    @ResponseBody
    public Result getDepartments() {
        List<Department> departmentList = departmentService.getDepartments();
        return Result.success().add("departments", departmentList);
    }

}
