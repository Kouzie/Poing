<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>리뷰</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="">
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/main.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/slider.js"></script>
	<style>
			<%@include file="/css/style.css" %>
	</style>
</head>
<%
	
%>
<body>
	<div id="wrap" class="">
		
		<jsp:include page="/WEB-INF/layout/header.jsp"/>
		
		<!-- container -->
		<div id="container" class="">
			<!-- 상단에 배너가 있는 레이아웃 -->
			<div id="banner_wrap"></div>
			<div id="content_wrap">
				<div id="content" class="review_feed">
					<div class="section write">
						<div class="title">리뷰 쓰기</div>
						<div class="body">
							<div class="search">
								<div class="title">레스토랑 검색</div>
								<div class="detail">
									<input id="review_search" type="text"
										class="border_radius soft" placeholder="리뷰를 작성할 매장을 검색하세요.">
									<i class="icon glass"></i>
									<ul id="review_auto_complete" class="border_radius soft">
										<li>
											<div class="name">검색 결과가 없습니다.</div>
										</li>
									</ul>
								</div>
							</div>
							<div class="grade">
								<div class="title">별점</div>
								<div class="detail">
									<i class="icon star medium odd " data-id="review_grade"
										data-index="0" style="cursor: pointer"></i><i
										class="icon star medium even " data-id="review_grade"
										data-index="1" style="cursor: pointer"></i><i
										class="icon star medium odd " data-id="review_grade"
										data-index="2" style="cursor: pointer"></i><i
										class="icon star medium even " data-id="review_grade"
										data-index="3" style="cursor: pointer"></i><i
										class="icon star medium odd " data-id="review_grade"
										data-index="4" style="cursor: pointer"></i><i
										class="icon star medium even " data-id="review_grade"
										data-index="5" style="cursor: pointer"></i><i
										class="icon star medium odd " data-id="review_grade"
										data-index="6" style="cursor: pointer"></i><i
										class="icon star medium even " data-id="review_grade"
										data-index="7" style="cursor: pointer"></i><i
										class="icon star medium odd " data-id="review_grade"
										data-index="8" style="cursor: pointer"></i><i
										class="icon star medium even " data-id="review_grade"
										data-index="9" style="cursor: pointer"></i><span
										style="display: inline-block; vertical-align: super;"
										data-id="review_grade" data-grade="0"></span>
								</div>
							</div>
							<div class="text">
								<div class="title">리뷰</div>
								<div class="detail">
									<textarea id="review_text" class="border_radius soft"
										placeholder="매장에 대한 리뷰를 30자 이상 작성해주세요.
									매장과 관계없는 글, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 삭제됩니다."></textarea>
									<div id="review_text_state" class="border_radius soft">평점을
										매겨주세요!</div>
									<i class="icon save"></i><span>저장됨</span>
								</div>
							</div>
							<div class="photo">
								<div class="title">사진 등록</div>
								<div class="detail">
									<button type="button" class="addPhoto"
										data-target="#reviewPhotoUpload" tabindex="-1">사진
										등록하기</button>
									<input id="reviewPhotoUpload" type="file" multiple="" hidden="">
									<span>사진 등록은 최대 20장까지 가능합니다.</span>

									<ul class="list ui-sortable"></ul>
								</div>
							</div>
							<button id="upload_review" class="border_radius soft"
								data-type="poing.reviews.upload"
								data-grade="$('span[data-id=review_grade]')" data-id=""
								data-text="$('#review_text')"
								data-photo="$('.section.write .photo ul.list>li')" tabindex="-1">리뷰
								올리기</button>
						</div>
					</div>

					<div class="section realtime">
						<div class="filter">
							<a href="?type=all" class="all" >모든 사용자</a> 
							<a href="?type=follower" class="follower ">팔로잉</a>
							<script type="text/javascript">
							<%
								System.out.println("type = " + request.getAttribute("type"));
							%>
								$("div.filter > a.${ type eq null ? all : type}").addClass("selected")
							</script>
						</div>
						<div class="title">실시간 리뷰</div>
						<div class="body review_wrap">
							<c:forEach var = "dto" items = "${list }" varStatus = "status">
							<div class="review" data-id="${dto.rev_seq }" data-place="${dto.rest_seq }"
								data-place-name="${dto.rest_name }">
								<a class="author" href="/Poing/timeline.do?id=${dto.rev_m_seq }"> <span
									class="thumbnail"
									style="display: inline-block; background-image: url(&quot;${ dto.m_img ? authUser.m_img : "http://c1.poing.co.kr/original/images/common/default_profile_162.png" }&quot;);"></span>
									<div class="info">
										<p class="name">${dto.m_name }</p>
										<p class="stat">${ dto.m_revcnt } 리뷰, ${ dto.m_ercnt } 팔로워</p>
									</div>
									<c:if test="${ authUser.m_no ne dto.rev_m_seq }">
										<button class="follow " type="button"
											data-type="poing.user.follow" data-id="${ dto.rev_m_seq }" tabindex="-1">
											<i class="icon follow "></i>팔로우
										</button>
									</c:if>
								</a> <a class="place" href="/Poing/rest/detail.do?rest_seq=${ dto.rest_seq }">
									<button class="favorite " type="button"
										data-type="poing.restaurants.favorite" data-id="${ dto.rest_seq }"
										tabindex="-1">
										<i class="icon heart small "></i>매장찜
									</button>
									<p class="name">${dto.rest_name}</p>
									<p class="info">${dto.rest_loc}</p>
								</a>
								<div class="body">
									<div class="time  loaded" style="display: block;">${dto.rev_wtime}</div>
									<div class="grade">
									
										
										
										<c:forEach varStatus = "status" var = "i" begin = "1" end = "10" step = "1">
										<c:if test = "${i%2 ne 0 }">
											<i class="icon star medium odd active" data-id="${dto.rev_seq }"
												data-index="${status.count }" style=""></i>
										</c:if>
										
										<c:if test = "${i%2 eq 0 }">
											<i class="icon star medium even active" data-id="${dto.rev_seq }"
												data-index="${status.count }" style=""></i>
										</c:if>	
										</c:forEach>
										
										<c:if test = "${status.count eq 10 }">
											<span
											style="display: inline-block; vertical-align: super;"
											data-id="${dto.rev_seq }" data-grade="50">${dto.rev_starpoint } / 한줄평가</span>
										</c:if>
									</div>
									<div class="text" data-truncated="">${dto.rev_content }</div>
									<button class="like_list"
										data-type="poing.reviews.actions.user.showLikers"
										data-id="193284" tabindex="-1">
										김수한님, jwjwjw님 외 12명이 좋아합니다.
									</button>
									<div class="action">
										<button class="like " type="button"
											data-type="poing.reviews.actions.user.like" data-id="193284"
											tabindex="-1">
											<i class="icon like "></i>
											<p>
												좋아요 <span>좋아요개수</span>
											</p>
										</button>
										<button class="favorite " type="button"
											data-type="poing.reviews.actions.user.favorite"
											data-id="193284" tabindex="-1">
											<i class="icon heart small "></i>
											<p>
												찜하기 <span>찜개수</span>
											</p>
										</button>
										<button class="comment" type="button"
											data-type="poing.reviews.actions.user.loadComments"
											data-id="193284" tabindex="-1">
											<i class="icon balloon"></i>
											<p>
												댓글 <span>댓글개수</span>
											</p>
										</button>
										<button class="share" type="button"
											data-type="poing.reviews.actions.share.dropdown"
											data-id="193284" tabindex="-1">
											<i class="icon share"></i>
											<!-- <p>공유</p>
											<ul class="list">
												<li data-type="poing.reviews.actions.share.facebook">페이스북
													공유</li>
												<li data-type="poing.reviews.actions.share.twitter">트위터
													공유</li>
											</ul> -->
										</button>
									</div>
								</div>
								<div class="comment_list"></div>
								<div class="write">
									<span class="thumbnail"
										style="background-image: url('${ authUser.m_img ? authUser.m_img : "http://c1.poing.co.kr/original/images/common/default_profile_162.png" }')"></span>
									<textarea data-id="${ dto.rev_seq }" placeholder="댓글을 입력해주세요"></textarea>
								</div>
							</div>
							</c:forEach>
					</div>

						<div id="review_pagination">
							<div class="page-list">
								<ul class="pagination" onselectstart="return false;">
									<li class="prevAll">&lt;&lt;</li>
									<li class="prev">&lt;</li>
									<li class="page active" data-page="1">1</li>
									<li class="page" data-page="2">2</li>
									<li class="page" data-page="3">3</li>
									<li class="page" data-page="4">4</li>
									<li class="page" data-page="5">5</li>
									<li class="page" data-page="6">6</li>
									<li class="page" data-page="7">7</li>
									<li class="page" data-page="8">8</li>
									<li class="page" data-page="9">9</li>
									<li class="page" data-page="10">10</li>
									<li class="next">&gt;</li>
									<li class="nextAll">&gt;&gt;</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
	<jsp:include page="/WEB-INF/view/slideBar/Slidebar_BestReview.jsp"></jsp:include>
<script>
	$(document).ready(function(){
	    new Pagination({'selector':'#review_pagination', 
	                    'current_page':1, 
	                    'per_page':10, 
	                    'total_page':7924, 
	                    'event':function(page) {
	                        var sep = {};
	                        if(location.search.substr(1).length > 0)
	                            $.each(location.search.substr(1).split("&"), function(key, value) {sep[value.split("=")[0]] = value.split("=")[1] });
	
	                        sep['pg'] = page;
	
	                        location.search = $.param(sep);
	                    } });
	
	    // 임시저장
	    poing.reviews.actions.temp.save($(".section.write"), 'seoul');
	    
	    // review focus / unfocus
	    var $photos = $(".section.write .photo ul.list");
	    $("#review_text")
	        .focus(function(){
	            $(".section.write").addClass('focus');
	        })
	        .blur(function(){
	            if(	$(this).val().length === 0 && // 리뷰 0자
	                $("#upload_review").data('id').length === 0 && // 선택된 레스토랑 없음
	                $photos.children().length == 0 ) // 업로드한 이미지 없음
	                   $(".section.write").removeClass('focus');
	    });
	
	    // review photo upload
	    $(".section.write .photo .addPhoto").mousedown(function() {
	        poing.reviews.addImage.call(this);
	    });
	    $photos
	        .sortable({
	            tolerance: 'pointer',
	            containment: $photos,
	            revert: true,
	            scroll: false,
	        })
	        .on("click", " .remove", function() {
	            $(this).parent().remove();
	        });
	    $("#reviewPhotoUpload").change(function() {
	        $(".section.write").addClass('focus');
	    });
	
	    // auto complete
	    $("#review_search").on("keyup", function(){
	        if( $(this).val().length > 0) {
	            $.ajax({'url': "/Poing/restaurant/search.do?searchWord="+encodeURIComponent($(this).val()),
	                    'type': "GET",
	                    'success': function(res) {
	                        res = $.parseJSON(res).data.ac_keywords;
	
	                        var list = $("#review_auto_complete");
	                        list.empty();
	
	                        if(res.length > 0) {
	                            for(var i=0; i<res.length && i<5; ++i) {
	                                var e = res[i];
	                                var li = $("<li>", {'data-id':e.id});
	                                li.append( $("<div>", {	'class':'name',
	                                                        'text':e.name }) );
	                                li.append( $("<div>", {	'class':'desc',
	                                                        'text':e.description }) );
	                                list.append(li);
	                            }
	                        } else {
	                            var li = $("<li>");
	                            li.append( $("<div>", {'text':'검색 결과가 없습니다.' }) );
	                            list.append(li);
	                        }
	                    }
	            });
	        } else {
	            var list = $("#review_auto_complete").empty();
	
	            var li = $("<li>");
	            li.append( $("<div>", {'text':'검색 결과가 없습니다.' }) );
	            list.append(li);
	        }
	    });
		$(".filter>a.follower").click(function(){
			return poing.account.checkLoginState();
		});
		// select restaurant
		$("#review_search").focus(function() {
			$("#review_auto_complete").show();
		});
		$("#review_search").blur(function(e) {
			$("#review_auto_complete").hide();
		});
		$("#review_auto_complete").on("mousedown", "li", function(e) {
			var id = $(this).data('id');
			id = id? id:'';
	
			$("#upload_review").data('id', id);
	
			$("#review_search").val($(this).find(".name").text());
			$("#review_text").focus();
		});
	
		// review grade
		var reviewGrade = -1;
		$("i.star[data-id=review_grade]").on("click", function()
		{
			if(!poing.account.checkLoginState())
			{
				$(this).blur();
				return;
			}
	
			var index = $(this).data("index");
			for(var i = 0; i <= index; i++)
				$("i.star[data-id=review_grade][data-index="+i+"]").addClass("active");
			for(var i = index+1; i <= 9; i++)
				$("i.star[data-id=review_grade][data-index="+i+"]").removeClass("active");
	
			reviewGrade = (index+1)*10;
			$("span[data-id=review_grade]").data("grade", reviewGrade);
			$("span[data-id=review_grade]").html(((index+1)/2).toFixed(1) + " / " + ratingText[index]);
	
			var text_length = $("#review_text").val().length;
			if(text_length < 30 && $photos.children().length == 0)
			{
				$("#review_text_state").css("background", "rgb(68,68,68)");
				$("#review_text_state").html(String(text_length)+"자를 쓰셨어요! 30자 이상을 쓰거나, 사진을 올려주세요!");
			}
			else
			{
				$("#review_text_state").css("background", "rgb(60,191,54)");
				$("#review_text_state").html("이제 리뷰를 올리실 수 있어요!");
			}
		});
		$("i.star[data-id=review_grade]").on("mouseover", function()
		{
			if(reviewGrade >= 0)
				return;
	
			var index = $(this).data("index");
			for(var i = 0; i <= index; i++)
				$("i.star[data-id=review_grade][data-index="+i+"]").addClass("active");
			for(var i = index+1; i <= 9; i++)
				$("i.star[data-id=review_grade][data-index="+i+"]").removeClass("active");
	
			$("span[data-id=review_grade]").html(((index+1)/2).toFixed(1) + " / " + ratingText[index]);
		});
		$("i.star[data-id=review_grade]").on("mouseout", function()
		{
			if(reviewGrade >= 0)
				return;
	
			for(var i = 0; i <= 9; i++)
				$("i.star[data-id=review_grade][data-index="+i+"]").removeClass("active");
	
			$("span[data-id=review_grade]").html("");
		});
		// review text
		$("#review_text").on("focus", function()
		{
			if(!poing.account.checkLoginState())
				$(this).blur();
		});
		$("#review_text").on("keydown keyup", function()
		{
			if(reviewGrade < 0)
				return;
	
			var text_length = $(this).val().length;
			if(text_length < 30 && $photos.children().length == 0)
			{
				$("#review_text_state").css("background", "rgb(68,68,68)");
				$("#review_text_state").html(String(text_length)+"자를 쓰셨어요! 30자 이상을 쓰거나, 사진을 올려주세요!");
			}
			else
			{
				$("#review_text_state").css("background", "rgb(60,191,54)");
				$("#review_text_state").html("이제 리뷰를 올리실 수 있어요!");
			}
		});
	});
</script>
			</div><!-- content_wrap end -->
		</div><!-- container end -->
		
		<!-- header -->
		<jsp:include page="/WEB-INF/layout/popup_wrap.jsp"/>
	</div>
		<!-- wrap end -->
	<jsp:include page="/WEB-INF/layout/footer.jsp"/>
	
	<jsp:include page="/WEB-INF/layout/javascript/default.jsp"/>
</body>
</html>
