// 滚动加载更多文章
$(window).scroll(function () {
	if($(".more p").html()=='没有更多文章啦！'){
		return;
	}
	var body_hight = $(document).height();// document总高度
	// console.log("document高度:"+body_hight);
	var nScrollHight = $(window).height();
	// console.log('当前画面高度：'+nScrollHight);// 当前画面高度
	var nScrollTop = $(window).scrollTop();// 滚动条顶部位置
	// console.log("当前滚动位置："+nScrollTop);
	if (nScrollTop + nScrollHight >= body_hight)
		// alert("滚动条到底部了");
		loadMoreArticle();// 动态加载更多文章
});