/**
 * 
 */

function build_page_nav(result) {
	$("#page_area").empty();
	var page = result.mp.page;
	var nav = $("<nav></nav>").addClass("Page navigation");
	var ul = $("<ul></ul>").addClass("pagination");
	//首页
	var firstpage = $("<li></li>").append($("<a></a>").append("首页"));
	//上一页
	var prevpage = $("<li></li>").append(
			$("<a></a>").attr("href", "#").attr("aria-label", "Previous")
					.append(
							$("<span></span>").attr("aria-hidden", "true")
									.append("&laquo;")));
	//尾页
	var lastpage = $("<li></li>").append(
			$("<a></a>").attr("href", "#").append("尾页"));
	//下一页
	var nextpage = $("<li></li>").append(
			$("<a></a>").attr("href", "#").attr("aria-label", "Next").append(
					$("<span></span>").attr("aria-hidden", "true").append(
							"&raquo;")));
	//首页无法跳转上一页
	if (page.hasPreviousPage == false) {
		firstpage.addClass("disabled");
		prevpage.addClass("disabled");
	} else {
		firstpage.click(function() {
			to_page(1);
		});

		//上一页的跳转
		prevpage.click(function() {
			to_page(page.pageNum - 1);
		});
	}

	//首页的跳转

	//添加首页和上一页
	ul.append(firstpage).append(prevpage);
	//页码
	$.each(page.navigatepageNums, function(i, item) {
		var numli = $("<li></li>").append($("<a></a>").append(item));
		//当前页无法跳转
		if (page.pageNum == item) {
			numli.addClass("active");
		} else {
			numli.click(function() {
				to_page(item);
			});
		}
		ul.append(numli);

	});
	//尾页无法跳转下一页
	if (page.hasNextPage == false) {
		lastpage.addClass("disabled");
		nextpage.addClass("disabled");
	} else {

		//尾页的跳转
		lastpage.click(function() {
			to_page(page.pages);
		});

		//下一页的跳转
		nextpage.click(function() {
			to_page(page.pageNum + 1);
		});
	}
	//添加尾页和下一页
	ul.append(nextpage).append(lastpage);
	nav.append(ul).appendTo("#page_area");
}