/**
 * 
 */
//添加用户数据
function build_emps_table(result) {
	//将数据清空
	$("#emps_table tbody").empty();
	//获取所有的用户数据
	var emps = result.mp.page.list;
	//遍历出各个用户
	$.each(emps, function(index, item) {
		var checkbox=$("<td></td>").
		append($("<input type='checkbox' class='check_item'/>").attr("check_name", item.empName));
		
		//Id栏
		var empId = $("<td></td>").append(item.empId);
		//用户姓名栏
		var empName = $("<td></td>").append(item.empName);
		//性别栏
		var gender = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
		//邮箱栏
		var email = $("<td></td>").append(item.email);
		//部门栏
		var deptName = $("<td></td>").append(item.department.deptName);
		//操作按钮
		var editbtn = $("<button></button>").addClass("btn btn-warning update_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil"));
		//给按钮添加id属性
		editbtn.attr("edit_id", item.empId);
		var delbtn = $("<button></button>").addClass("btn btn-danger del_btn").append(
				$("<span></span>").addClass("glyphicon glyphicon-minus"));
		//给按钮添加id属性
		delbtn.attr("del_id", item.empId);
		//操作栏
		var operation = $("<td></td>").append(editbtn).append(delbtn);

		//添加进表格
		$("<tr></tr>").append(checkbox).append(empId).append(empName).append(gender).append(
				email).append(deptName).append(operation).appendTo(
				"#emps_table tbody");
	});
}
