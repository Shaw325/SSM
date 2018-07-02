/**
 * 
 */

function build_depts(result,ele) {
	var depts = result.mp.list;
	$.each(depts, function(index, item) {
		var option = $("<option></option>").append(item.deptName).attr("value",
				item.deptId);
		option.appendTo($(ele));
	});
}