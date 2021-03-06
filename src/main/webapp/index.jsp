<%@ page import="com.github.pagehelper.PageInterceptor" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>

</head>

<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工修改</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      	<p class="form-control-static" id="empName_update_static"></p>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
				  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		      <select class="form-control" name="dId">
		      </select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>



<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      	<label class="radio-inline">
				  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		    	<!-- 部门提交部门id即可 -->
		       <select class="form-control" name="dId">

               </select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>



<!-- 搭建显示页面 -->
<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>

		<!-- 显示分页信息 -->
		<div class="row">
			<!--分页文字信息  -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
		
</div>



<%-- 定义函数和调用函数 --%>
<script type="text/javascript">

		let totalPage, currentPage;

		// 1 显示功能的实现

		// 页面加载完成以后，直接去发送ajax请求,要到分页数据
		$(function () {
			to_page(1);
		});

		// 跳转页面
		function to_page(pageNum){
			$.ajax({
				url: "${APP_PATH}/getEmployees",
				data: "pageNum=" + pageNum,
				type: "GET",
				success: function (result) {

					totalPage = result.resultMap.pageInfo.pages;
					currentPage = result.resultMap.pageInfo.pageNum;

					//console.log(result);
					//1、解析并显示员工数据
					build_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);
				}
			});
		}
		// 导入数据
		function build_emps_table(result){
			//清空table表格
			$("#emps_table tbody").empty();

			let emps = result.resultMap.pageInfo.list;

			$.each(emps,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);

				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义的属性，来表示当前员工id
				editBtn.attr("edit-id", item.empId);

				var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加一个自定义的属性来表示当前删除的员工id
				delBtn.attr("del-id",item.empId);

				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd)
					.appendTo("#emps_table tbody");
			});
		}
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.resultMap.pageInfo.pageNum+"页,总"+
					result.resultMap.pageInfo.pages+"页,总"+
					result.resultMap.pageInfo.total+"条记录");


		}
		//解析显示分页条，点击分页要能去下一页....
		function build_page_nav(result) {

			$("#page_nav_area").empty();

			let ul = $("<ul></ul>").addClass("pagination")

			// 创建分页条元素
			let firstPageList = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"))
			let prePageList = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if (result.resultMap.pageInfo.hasPreviousPage === false) {
				firstPageList.addClass("disabled");
				prePageList.addClass("disabled");
			} else {
				firstPageList.click(function () {
					to_page(1);
				})

				prePageList.click(function () {
					to_page(currentPage - 1);
				})
			}

			let lastPageList = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"))
			let nextPageList = $("<li></li>").append($("<a></a>").append("&raquo;"));
			if (result.resultMap.pageInfo.hasNextPage === false) {
				lastPageList.addClass("disabled");
				nextPageList.addClass("disabled");
			} else {
				lastPageList.click(function () {
					to_page(totalPage);
				})

				nextPageList.click(function () {
					to_page(currentPage + 1);
				})
			}

			// 添加页码元素至 ul 元素
			ul.append(firstPageList).append(prePageList);

			$.each(result.resultMap.pageInfo.navigatepageNums, function (index, item) {
				let pageNumList = $("<li></li>").append($("<a></a>").append(item));

				if (currentPage === item) {
					pageNumList.addClass("active");
				}

				pageNumList.click(function () {
					to_page(item);
				})

				ul.append(pageNumList);
			})

			ul.append(nextPageList).append(lastPageList);

			// 添加 ul 至分页条
			let nav = $("<nav></nav>").append(ul);
			nav.appendTo("#page_nav_area");
		}


		// 2 新增功能的实现

		// 2_1 点击新增按钮弹出模态框并导入部门信息
		$("#emp_add_modal_btn").click(function(){
			//清除表单数据（表单完整重置（表单的数据，表单的样式））
			reset_form("#empAddModal form");

			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");

			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});

		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//查出所有的部门信息并显示在下拉列表中
		function getDepts(ele){
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url: "${APP_PATH}/departments",
				type: "GET",
				success:function (result) {

					$.each(result.resultMap.departments, function(index, item) {

						let option = $("<option></option>").append(item.deptName).attr("value", item.deptId);
						option.appendTo(ele);

					});
				}
			});
			
		}

		// 2_2 校验表单
		// 校验用户名是否可用，因为需要查询数据库，所以用 ajax 请求
		$("#empName_add_input").change(function () {
			//发送ajax请求校验用户名是否可用
			let empName = this.value;

			$.ajax({
				url: "${APP_PATH}/checkEmployeeName",
				data: "empName=" + empName,
				type: "POST",

				success: function (result) {
					if (result.code == 100) {
						show_validate_msg("#empName_add_input", "success", "用户名可用");
						$("#emp_save_btn").attr("ajax-va", "success");
					} else {
						show_validate_msg("#empName_add_input", "error", result.resultMap.errorMsg);
						$("#emp_save_btn").attr("ajax-va", "error");
					}
				}
			});
		});
		// 校验表单邮箱是否可用，正则表达式即可验证
		function validate_email(ele){
			// 校验邮箱信息
			let email = $(ele).val();
			let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

			if (!regEmail.test(email)) {
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}
		//显示校验结果的提示信息
		function show_validate_msg(ele, status, msg) {

			// 清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");

			if ("success" === status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" === status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		// 2_3 保存员工
		// 点击保存
		$("#emp_save_btn").click(function(){

			// 提前判断，可以避免不必要的 ajax 请求
			// 1 判断之前的ajax用户名校验是否成功
			if ($(this).attr("ajax-va") === "error") {
				return false;
			}
			// 2 对新建模态框中的邮箱进行验证
			if (!validate_email("#email_add_input")) {
				return false;
			};
			// 3 检验通过则会发送 ajax 请求保存员工
			$.ajax({
				url: "${APP_PATH}/saveEmployee",
				type: "POST",
				data: $("#empAddModal form").serialize(),

				success: function (result) {
					//alert(result.msg);
					if (result.code === 100) {
						//员工保存成功；
						//1、关闭模态框
						$("#empAddModal").modal('hide');

						//2、来到最后一页，显示刚才保存的数据
						//发送ajax请求显示最后一页数据即可
						to_page(totalPage);
					} else {
						// 显示失败信息，该部分是通过 controller 的注解 @Valid 实现的
						// 但前端已经验证过了，所以这里是重复验证，可以删掉

						// 有哪个字段的错误信息就显示哪个字段的
						if (undefined !== result.resultMap.empName) {
							//显示员工名字的错误信息
							show_validate_msg("#empName_add_input", "error", result.resultMap.empName);
						}

						if (undefined !== result.resultMap.email) {
							//显示邮箱错误信息
							show_validate_msg("#email_add_input", "error", result.resultMap.email);
						}
					}
				}
			});
		});


		// 3 编辑功能的实现

		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			// 1 查出部门信息，并显示部门列表
			getDepts("#empUpdateModal select");
			// 2 查出员工信息，显示员工信息（在页面加载员工数据时，已向标签中添加了 edit-id 属性）
			getEmp($(this).attr("edit-id"));
			// 3 把员工的 id 传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
			// 弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getEmp(id){
			$.ajax({
				url: "${APP_PATH}/getEmployee/" + id,
				type: "GET",
				success: function (result) {
					//console.log(result);
					var empData = result.resultMap.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			//1、校验邮箱信息
			if (!validate_email("#email_update_input")) {
				alert("邮箱错误！")
				return false;
			}

			//2、发送ajax请求保存更新的员工数据
			$.ajax({
				url: "${APP_PATH}/updateEmployee/" + $(this).attr("edit-id"),
				type: "PUT",
				data: $("#empUpdateModal form").serialize(),

				success: function (result) {
					//alert(result.msg);
					//1、关闭对话框
					$("#empUpdateModal").modal("hide");
					//2、回到本页面
					to_page(currentPage);
				}
			});
		});


		// 4 删除功能的实现

		// 4_1 单个删除
		$(document).on("click", ".delete_btn", function () {

			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");

			// 弹出是否确认删除对话框
			if (confirm("确认删除【" + empName + "】吗？")) {
				// 确认，发送ajax请求删除即可
				$.ajax({
					url: "${APP_PATH}/deleteEmployee/" + empId,
					type: "DELETE",
					success: function (result) {
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
		//完成全选/全不选功能
		$("#check_all").click(function () {
			// attr 方法获取用户自定义属性的值；
			// prop 方法修改和读取原生属性的值

			// $(this).prop("checked") 获取属性值，返回 true / false
			// 点击全选按钮时，this checked 的值改为 true，刷新页面，默认为 false
			// $(".check_item").prop("checked", true / false) 设置属性值为全选按钮的属性值，全选为 ture / false
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		
		//check_item
		$(document).on("click", ".check_item", function () {

			// 判断当前选择中的元素是否为每页显示的员工个数
			// 长度不等，则将 $("#check_all") checked 属性值设置为 false，否则为 true
			var flag = $(".check_item:checked").length === $(".check_item").length;
			$("#check_all").prop("checked", flag);
		});
		
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function () {
			//
			var empNames = "";
			var del_idStr = "";

			$.each($(".check_item:checked"), function () {
				// 拼接 empName 属性
				empNames += $(this).parents("tr").find("td:eq(2)").text() + "&";
				// 拼接员工 empId 字符串
				del_idStr += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});

			// 减掉拼接的最后一个 & 符号
			empNames = empNames.substring(0, empNames.length - 1);
			// 减掉拼接的最后一个 - 符号
			del_idStr = del_idStr.substring(0, del_idStr.length - 1);

			if (confirm("确认删除【" + empNames + "】吗？")) {
				//发送ajax请求删除
				$.ajax({
					url: "${APP_PATH}/deleteEmployee/" + del_idStr,
					type: "DELETE",
					success: function (result) {
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>