<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang = "ko">
<head>
<link rel="stylesheet" type='text/css' htef='<%=request.getContextPath()%>/css/poing.slider.css'>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
		/* include file = 경로가 자바파일에 삽입되어 컴파일 */
		<%@include file="/css/style.css" %>
		<%@include file="/css/poing.slider.css" %>
	</style>
	<script type="text/javascript" 
        src="<%= request.getContextPath() %>/js/jquery-3.4.1.js"></script>
	<script type="text/javascript"
		src="<%= request.getContextPath() %>/js/main.js"></script>
	<script type="text/javascript"
		src="<%= request.getContextPath() %>/js/slider.js"></script>
	<meta charset="UTF-8">
</head>
<title>
	        포잉		
	</title>
</head>

<body class="vsc-initialized">
<!-- body wrap -->
<div id="wrap" class="">
	<!-- header -->
	<jsp:include page="/WEB-INF/layout/header.jsp"></jsp:include>

	<div id="container" class>
			<!-- 상단에 배너가 있는 레이아웃 -->


			<div id="banner_wrap">
				<div id="banner" class="image "
					style="background-image: url(&quot;/Poing/upload/uploadfoodimage/food.png&quot;)">
					<div class="title_wrap">
						<div class="title">음식 종류별</div>
					</div>
					<div class="subtitle"></div>
				</div>
			</div>
			<div id="content_wrap">
				<div class="section">
					<div class="title">음식 종류별</div>

					<div></div>
					<div class="body">


						<c:forEach items="${list}" var="dto" varStatus="status">
							<c:if test="${status.index % 3 eq 0}">
								<div class="element  large past_image first ">
							</c:if>
							<c:if test="${status.index % 3 ne 0 }">
								<div class="element  large past_image  ">
							</c:if>


							<a
								href="/Poing/rest/list.do?food_type=${ dto.f_seq }"
								class="image"
								style="display: block; background-image:url(&quot;/Poing/${dto.f_img}&quot;);">
								<div class="shading"></div>

								<div class="center">
									<div class="middle">
										<div class="title" align="center">
											<li class="aaa"
												style="list-style: none; width: 200px; word-break: normal">
												${dto.f_engname}</li>
										</div>
										<!-- title -->
										<div class="subtitle" align="center">
											<li class="aaa"
												style="list-style: none; width: 200px; height: 50px; word-break: keep-all">${dto.f_name}</li>
										</div>
									</div>
									<!-- middle -->
								</div>
								<!-- center -->
							</a>
					</div>
					<!-- element~ -->
					</c:forEach>

				</div>
				<!-- body -->

			</div>

		</div>

	<jsp:include page="/WEB-INF/layout/footer.jsp"></jsp:include>
	
	<jsp:include page="/WEB-INF/layout/popup_wrap.jsp"></jsp:include>
</div> <!-- wrap end -->

<jsp:include page="/WEB-INF/layout/javascript/default.jsp"></jsp:include>
</body>
</html>