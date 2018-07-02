
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	System.out.println(path);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
</head>
<script type="text/javascript"
	src="<%=path%>/static/js/bootstrap.min.js"></script>
<link href="<%=path%>/static/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="<%=path%>/js/jquery-3.3.1.js"></script>
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
				<button type="button" class="btn btn-success">
					<span class="glyphicon glyphicon-plus"></span> 新增
				</button>
				<button type="button" class="btn btn-danger">
					<span class="glyphicon glyphicon-remove"></span> 删除
				</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>Employee Name</th>
						<th>Gender</th>
						<th>Email</th>
						<th>Department Name</th>
						<th>Operation</th>
					</tr>
					<c:forEach items="${page.list}" var="employee">
						<tr>
							<td>${employee.empId}</td>
							<td>${employee.empName}</td>
							<td>${employee.gender=="M"?"男":"女"}</td>
							<td>${employee.email}</td>
							<td>${employee.department.deptName}</td>
							<td>
								<button type="button" class="btn btn-warning">
									<span class="glyphicon glyphicon-pencil">修改</span>
								</button>
								<button type="button" class="btn btn-danger">
									<span class="glyphicon glyphicon-minus">删除</span>
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 显示分页 -->
		<div class="row">
			<div class="col-md-6 col-md-offset-4">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<!-- 当前页码等于1时，不能点击上一页 -->
					<c:if test="${ page.pageNum==1}">
						<li class="disabled"><a href="<%=path%>/emps">首页</a></li>
						<li class="disabled"><a
							href="<%=path%>/emps?pn=${page.pageNum-1}" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					
					<!-- 当前页码不等于1时，不能点击上一页 -->
					<c:if test="${ page.pageNum!=1}">
						<li><a href="<%=path%>/emps">首页</a></li>
						<li><a href="<%=path%>/emps?pn=${page.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					
					<!-- 迭代获取的页数 -->
					<c:forEach items="${page.navigatepageNums}" var="page_Num">
						<!-- 不能点击当前页码 -->
						<c:if test="${page_Num==page.pageNum}">
							<li class="active"><a href="<%=path%>/emps?pn=${page_Num}">${page_Num}</a></li>
						</c:if>
						
						<!-- 点击页码跳转 -->
						<c:if test="${page_Num!=page.pageNum}">
							<li><a href="<%=path%>/emps?pn=${page_Num}">${page_Num}</a></li>
						</c:if>
					</c:forEach>
					
					<!-- 当前页码等于总页码时，不能点击下一页 -->
					<c:if test="${page.pageNum==page.pages}">
					<li class="disabled"><a href="<%=path%>/emps?pn=${page.pageNum+1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
					<li class="disabled"><a href="<%=path%>/emps?pn=${page.pages}">尾页</a></li>
					</c:if>
					
					<!-- 当前页码等于总页码时，可以点击下一页 -->
					<c:if test="${page.pageNum!=page.pages}">
					<li><a href="<%=path%>/emps?pn=${page.pageNum+1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
					<li><a href="<%=path%>/emps?pn=${page.pages}">尾页</a></li>
					</c:if>
				</ul>
				</nav>
			</div>
		</div>

	</div>
</body>
</html>