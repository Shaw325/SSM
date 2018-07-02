<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	System.out.println(path);
	request.setAttribute("app_path", request.getContextPath());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
</head>
<script type="text/javascript" src="<%=path%>/js/jquery-3.3.1.js"></script>
<script type="text/javascript"
	src="<%=path%>/static/js/bootstrap.min.js"></script>
<link href="<%=path%>/static/css/bootstrap.min.css" rel="stylesheet">

<body>
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
				<button type="button" class="btn btn-success" id="emp_add_model">
					<span class="glyphicon glyphicon-plus"></span> 新增
				</button>
				<button type="button" class="btn btn-danger" id="emp_del_modal">
					<span class="glyphicon glyphicon-remove" ></span> 删除
				</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>全选<input type="checkbox" id="all_del"/></th>
							<th>#</th>
							<th>Employee Name</th>
							<th>Gender</th>
							<th>Email</th>
							<th>Department Name</th>
							<th>Operation</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页 -->
		<div class="row">
			<div class="col-md-6 col-md-offset-4" id="page_area"></div>
		</div>

		<!-- 封装显示员工信息 -->
		<script type="text/javascript" src="<%=path%>/js/employees.js"></script>
		<!-- 封装分页信息 -->
		<script type="text/javascript" src="<%=path%>/js/page.js"></script>
		<!-- 显示部门 -->
		<script type="text/javascript" src="<%=path%>/js/departments.js"></script>
		<!-- 验证输入格式 -->
		<script type="text/javascript" src="<%=path%>/js/Validate.js"></script>
		<!-- ajax请求 -->
		<script type="text/javascript">
			//用户验证结果
			var checkResult;
			var totalRecord,currentPage;

			//页面加载跳转第一页
			$(document).ready(function() {
				to_page(1);

			});

			function to_page(pn) {
				$.ajax({
					url : "${app_path}/emps",
					data : "pn=" + pn,
					type : "get",
					success : function(result) {
						//1.解析并显示员工数据
						build_emps_table(result);
						//2.解析并显示分页信息
						build_page_nav(result);
						totalRecord = result.mp.page.total;
						currentPage=result.mp.page.pageNum;
					}

				});
			}
			
			/* 获取部门信息 */
			//Add_Modal.jsp
			//Update_Modal.jsp
			function getDept(ele) {
				//每次获取清空之前的数据
				$(ele).empty();
				$.ajax({
					url : "${app_path}/depts",
					type : "GET",
					success : function(result) {
						//将部门设置到下拉框中
						build_depts(result, ele);
					}
				});
			}
			
			//重置表单
			//Add_Modal.jsp
			//Update_Modal.jsp
			function reset_form(ele) {
				//将表单数据清空
				$(ele)[0].reset();
				//将提示成功失败状态清空
				$(ele).find("*").removeClass("has-success has-error");
				//将失败图片和成功图片清除
				$(ele).find(".glyphicon").removeClass("glyphicon-remove glyphicon-ok");
				//将提示文字清除
				$(ele).find(".help-block").text("");
			}
		</script>
</body>
<!-- 添加用户的模态框 -->
<jsp:include page="Add_Modal.jsp" flush="true"></jsp:include>

<!-- 修改用户的模态框 -->
<jsp:include page="Update_Modal.jsp" flush="true"></jsp:include>

<!-- 删除用户弹出的提示框 -->
<jsp:include page="Del_Modal.jsp" flush="true"></jsp:include>
</html>