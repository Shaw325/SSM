<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="edit_modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">更新数据</h4>
			</div>
			<div class="modal-body">

				<form class="form-horizontal">
					<!-- 员工姓名  -->
					<div class="form-group has-feedback" id="edit_name_div">
						<label for="empName_input"
							class="col-sm-2 col-sm-offset-1 control-label">Employee</label>
						<div class="col-sm-1">
							<p class="form-control-static col-sm-1 col-sm-offset-1" id="edit_name"></p>
						</div>
					</div>

					<!-- 邮箱  -->
					<div class="form-group has-feedback" id="edit_email_div">
						<label for="email_input"
							class="col-sm-2 col-sm-offset-1 control-label">Email</label>
						<div class="col-sm-8">
							<input type="email" class="form-control" id="edit_email"
								name="email" placeholder="Email@site.com"> <span
								class="glyphicon form-control-feedback" id="edit_email_span"></span>
							<span class="help-block" id="edit_email_text"></span>
						</div>
					</div>

					<!-- 性别 -->
					<div class="form-group">
						<label class="col-sm-2 col-sm-offset-1 control-label">Gender</label>
						<div class="col-sm-8">
							<label class="radio-inline"> <input type="radio"
								name="gender" value="M" checked="checked"> 男
							</label> <label class="radio-inline"> <input type="radio"
								name="gender" value="F"> 女
							</label>
						</div>
					</div>

					<!-- 部门 -->
					<div class="form-group">
						<label class="col-sm-2 col-sm-offset-1 control-label">DeptName</label>
						<div class="col-sm-4">
							<select class="form-control" id="edit_select" name="dId"></select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="edit_btn">Save
					changes</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	//我们在按钮创立之前就绑定了Click，所以绑定不上
	//可以在创建按钮的时候绑定，我们使用on，参数分别为事件，数据对象，和方法体
	//显示修改的模态框
	$(document).on("click", ".update_btn", function() {
		//重置表单
		reset_form("#edit_modal form");
		//获得部门
		getDept("#edit_select");
		//获取员工
		getEmployee($(this).attr("edit_id"));

		//显示模态框
		$("#edit_modal").modal({
			backdrop : "static"
		});
	});

	//获取要修改的员工信息回显
	function getEmployee(empId) {
		$.ajax({
			url : "${app_path}/emp/" + empId,
			type : "GET",
			success : function(result) {
				//回显数据
				Backshow_data(result);
			}
		});
	}

	//回显查询到的数据
	function Backshow_data(result) {
		//回显查询到的员工姓名
		$("#edit_name").text(result.mp.Emp.empName);
		//回显查询到的员工邮箱
		$("#edit_email").val(result.mp.Emp.email);
		//回显查询到的性别
		$(":radio").val([ result.mp.Emp.gender ]);
		//回显查询到的部门
		$("#edit_select").val([ result.mp.Emp.dId ]);
		//给按钮一个ID值
		$("#edit_btn").attr("edit_id",result.mp.Emp.empId);
	}

	//失去焦点验证邮箱是否符合格式
	$("#edit_email").blur(function() {
		//验证邮箱
		validate_email(this);
	});
	//发送一个PUT请求修改员工信息
	$("#edit_btn").click(function() {
		validate_email("#edit_email");
		$.ajax({
			url : "${app_path}/emp/"+$(this).attr("edit_id"),
			type: "PUT",
			//将表单序列化成员工对象
			data: $("#edit_modal form").serialize(),
			success: function (result) {
				if(result.stateCode=="SUCCESS"){
					//关闭模态框，回到主页面
					$("#edit_modal").modal("hide");
					//跳转到当前修改页
					to_page(currentPage);
				}
			}

		});
	});
</script>