<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="del_modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<div class="alert alert-danger" role="alert">
					<p class="text-center">
						<br> 
						<span class="glyphicon glyphicon-warning-sign" id="sign"></span>
						您确认删除吗？
						<br>
					</p>

					<p class="text-center">
						<button type="button" class="btn btn-danger btn-primary btn-lg"
							id="del_sure">OK(确定)</button>
						<button type="button" class="btn btn-default btn-primary btn-lg"
							data-dismiss="modal">NO(取消)</button>
					</p>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	//显示模态框
	$("#emp_del_modal").click(function() {
		$("#del_sure").attr("all_or_single", "all");
		if($(".check_item:checked").length==0){
			 alert("请选中需要删除的员工");
		 }else{
		$("#del_modal").modal({
			backdrop : "static"
		});
		}
	});

	var empId;
	var empName="";
	//单个删除
	$(document).on("click", ".del_btn", function() {
		$("#del_sure").attr("all_or_single", "single");
		
		empId = $(this).attr("del_id");
		//显示模态框
		$("#del_modal").modal({
			backdrop : "static"
		});
	});

	$("#del_sure").click(function() {
		 
		$.each($(".check_item:checked"), function(index, item) {
			empName+=$(item).attr("check_name")+",";
		});
		empName=empName.substring(0,empName.length-1);
		//将所有的名字以字符串获得
		
		//如果是单个删除情况下
		if($("#del_sure").attr("all_or_single")=="single"){			
			$.ajax({
				url : "${app_path}/emp/" + empId,
				type : "DELETE",
				success : function(result) {
					if (result.stateCode == "SUCCESS") {
						$("#del_modal").modal("hide");
						to_page(currentPage);
					}
				}
			});
			
		//批量删除
		}else{
			$.ajax({
				url:"${app_path}/bemp/"+empName,
				type : "DELETE",
				success : function(result) {
					if (result.stateCode == "SUCCESS") {
						$("#del_modal").modal("hide");
						to_page(currentPage);
					}
				}
			});
		}
		

	});

	//全选框状态和子选框统一
	$(document).on("click", "#all_del", function() {
		//子框和全选状态同步
		$(".check_item").prop("checked", $(this).prop("checked"));
	});

	//子选框此页选满时，全选框也选中
	$(document).on("click", ".check_item", function() {
		//状态为选中的数量和当页数量子框一样时，判断为全选
		var flag = $(".check_item:checked").length == $(".check_item").length;

		$("#all_del").prop("checked", flag);
	});
</script>