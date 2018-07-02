/**
 * 验证输入的内容
 */
function validate_add_form(name,email) {

	if (validate_name(name) && validate_email(email)) {
		return true;
	} else {
		return false;
	}
}

// 验证姓名
function validate_name(name) {
	var regName = /(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
	var empName = $(name).val();
	if (!regName.test(empName)) {
		show_validate_msg(name, "error", "请输入2-5位中文或者6-16位英文");
		return false;
	} else {
		//status为前端效验的的数据
		if(checkResult.stateCode=="SUCCESS"){
			show_validate_msg(name, "success", "");
		}else{
			show_validate_msg(name, "error", checkResult.mp.msg);
		}				
	}
	return true;
}
// 验证邮箱
function validate_email(email) {
	var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	var empEmail = $(email).val();
	if (!regEmail.test(empEmail)) {
		show_validate_msg(email, "error", "邮箱格式不正确");
		return false;
	} else {
		show_validate_msg(email, "success", "");
	}
	return true;
}

function show_validate_msg(ele, status, msg) {
	$(ele).parent().removeClass("has-success has-error");
	$(ele).parent().children(".glyphicon").removeClass(
			"glyphicon-remove glyphicon-ok");
	$(ele).parent().children(".help-block").text("");
	if ("success" == status) {
		$(ele).parent().addClass("has-success");
		$(ele).parent().children(".glyphicon").addClass("glyphicon-ok");
		$(ele).parent().children(".help-block").text(msg);
		
	} else {
		$(ele).parent().addClass("has-error");
		$(ele).parent().children(".glyphicon").addClass("glyphicon-remove");
		$(ele).parent().children(".help-block").text(msg);
		
	}
}
