<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="emp_model" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">员工添加</h4>
			</div>
			<div class="modal-body">
				<!-- 模态框的内容部分 -->

				<!-- 表单 -->
				<form class="form-horizontal">
					<!-- 员工姓名  -->
					<div class="form-group has-feedback" id="empName_div">
						<label for="empName_input"
							class="col-sm-2 col-sm-offset-1 control-label">Employee</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="empName_input"
								name="empName" placeholder="Employess Name"> <span
								class="glyphicon form-control-feedback" id="empName_span"></span>
							<span class="help-block" id="empName_text"></span>
						</div>
					</div>



					<!-- 邮箱  -->
					<div class="form-group has-feedback" id="email_div">
						<label for="email_input"
							class="col-sm-2 col-sm-offset-1 control-label">Email</label>
						<div class="col-sm-8">
							<input type="email" class="form-control" id="email_input"
								name="email" placeholder="Email@site.com"> <span
								class="glyphicon form-control-feedback" id="email_span"></span>
							<span class="help-block" id="email_text"></span>
						</div>
					</div>

					<!-- 性别 -->
					<div class="form-group">
						<label class="col-sm-2 col-sm-offset-1 control-label">Gender</label>
						<div class="col-sm-8">
							<label class="radio-inline"> <input type="radio"
								name="gender" id="gender1_add_input" value="M" checked="checked">
								男
							</label> <label class="radio-inline"> <input type="radio"
								name="gender" id="gender2_add_input" value="F"> 女
							</label>
						</div>
					</div>

					<!-- 部门 -->
					<div class="form-group">
						<label class="col-sm-2 col-sm-offset-1 control-label">DeptName</label>
						<div class="col-sm-4">
							<select class="form-control" id="depts_select" name="dId"></select>
						</div>
					</div>
				</form>
			</div>
			<!-- 按钮组模块 -->
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="emp_save_btn">Save
					changes</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	//重置添加表单
	

	/* 弹出模态框 */
	$("#emp_add_model").click(function() {
		//重置表单
		reset_form("#emp_model form");
		//获得部门
		getDept("#depts_select");
		//显示模态框
		$("#emp_model").modal({
			backdrop : "static"
		});
	});

	$(function() {
		//验证姓名是否重复
		$("#empName_input").blur(function() {
			var name = $("#empName_input").val();
			var encode = encodeURI(name);
			var encode2 = encodeURI(encode);
			$.ajax({
				url : "${app_path}/checkName",
				type : "GET",
				//将异步请求设置为同步
				async : false,
				data : "empName=" + encode2,

				success : function(result) {
					//将状态码保存
					checkResult = result;
					if (checkResult.stateCode == "SUCCESS") {
						//验证成功给才能点击按钮
						$("#emp_save_btn").attr("checkName", "Success");
					} else {
						//验证失败无法点击按钮
						$("#emp_save_btn").attr("checkName", "Failura");
					}
				}
			});
		});
		//失去焦点验证邮箱是否符合格式
		$("#email_input").blur(function() {
			//验证邮箱
			validate_email(this);
		});
		//失去姓名焦点时验证姓名是否符合格式
		$("#empName_input").blur(function() {
			//验证姓名
			validate_name(this);
		});
		//保存用户信息
		$("#emp_save_btn").click(
				function() {
					//效验用户输入信息是否合法		
					if (!validate_add_form("#empName_input","#email_input")) {
						return false;
					}
					//效验姓名是否重复
					if ($(this).attr("checkName") == "Failura") {
						return false;
					}

					//发送保存的员工数据表单
					$.ajax({
						url : "${app_path}/emp",
						type : "POST",
						//将表单数据序列号发送
						data : $("#emp_model form").serialize(),
						success : function(result) {
							var state = result.stateCode;
							//添加成功时
							if (state == "SUCCESS") {
								//隐藏模态框
								$("#emp_model").modal("hide");
								to_page(totalRecord);
							} else {
								//如果存在邮箱错误信息
								if (undefined != result.mp.Error.email) {
									show_validate_msg("#email_input", "error",
											result.mp.Error.email);
								}
								//如果存在用户名错误信息
								if (undefined != result.mp.Error.empName) {
									show_validate_msg("#empName_input",
											"error", result.mp.Error.empName);
								}
							}
						}
					});
				});
	});
</script>
