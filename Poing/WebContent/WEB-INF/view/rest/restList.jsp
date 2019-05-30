<%@page import="poing.rest.RestListDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="poing.rest.RestListDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css'
	href='<%=request.getContextPath()%>/css/app.css?v=1557742885314'>
<style>
<%@include file="/css/style.css"%> 
</style> 
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/main.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/slider.js"></script>
<meta charset="UTF-8">
<title>Poing 레스토랑 리스트 테스트</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="">
<style>
 #map {
        height: 100%;
      }
</style>
<script>
	$(document).ready(function() {
	});
</script>
</head>
<% 
	ArrayList<RestListDTO> list = (ArrayList<RestListDTO>)request.getAttribute("list");
	System.out.println("restList.jsp list : " + list);
	int size = list.size();
	
	StringBuffer sb = new StringBuffer();
	float rlat, rlong;
	String info;
	String url;
	sb.append("[");
	for (int i=0; i<list.size(); i++){
		if(i==0) {
			rlat = list.get(i).getRest_lat();
			rlong = list.get(i).getRest_long();
			info = "<div><div class=\"inner\"><img src=\"http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg\" style=\"display: inline-block; width: 50px; height: 50px;\"><div style=\"vertical-align: top; width: 134px; display: inline-block; margin-left:10px\">" 
					+ list.get(i).getRest_name()
					+"<br><span>" +list.get(i).getRest_loc()
					+"</span></div></div></div>";
			url = "/Poing/rest/detail.do?rest_seq=" + list.get(i).getRest_seq();
			sb.append("{ lat: ");
			sb.append(rlat);
			sb.append(", lng: ");
			sb.append(rlong);
			sb.append(", info: '");
			sb.append(info);
			sb.append("', url: '");
			sb.append(url);
			sb.append("' } ");
		} else {
			rlat = list.get(i).getRest_lat();
			rlong = list.get(i).getRest_long();
			info = "<div><div class=\"inner\"><img src=\"http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg\" style=\"display: inline-block; width: 50px; height: 50px;\"><div style=\"vertical-align: top; width: 134px; display: inline-block; margin-left:10px\">" 
					+ list.get(i).getRest_name()
					+"<br><span>" +list.get(i).getRest_loc()
					+"</span></div></div></div>";
			url = "/Poing/rest/detail.do?rest_seq=" + list.get(i).getRest_seq();
			sb.append(",{ lat: ");
			sb.append(rlat);
			sb.append(", lng: ");
			sb.append(rlong);
			sb.append(", info: '");
			sb.append(info);
			sb.append("', url: '");
			sb.append(url);
			sb.append("' } ");
		}	
	}
	sb.append("] ");
	System.out.println(sb.toString());
	
%>
<body>

<div id="wrap" class="">
	<jsp:include page="/WEB-INF/layout/header.jsp"></jsp:include>
	
	<div id="container" class>
		<div id="banner" class="map" style="position: relative; overflow: hidden;"><div id="map"></div></div>
		<div id="content_wrap">
			<div id="content" class="search">
				<div class="result">
					총 <span class="highlight"></span><%=size%>개가 검색되었습니다.
				</div>
`
				<ul class="sort_order_spread">
					<li class="selected" data-order="">에디터 추천순</li>
					<li class="" data-order="average_grade">별점순</li>
					<li class="" data-order="reservation">예약순</li>
					<li class="" data-order="view">조회순</li>
				</ul>
				
				<div class="list">
					<c:forEach items="${list1}" var="dto" varStatus="status">
						<c:if test="${status.index % 3 ne 0 }">
							<div class="element  medium ">
						</c:if>
						<c:if test="${status.index % 3 eq 0 }">
							<div class="element  medium first">
						</c:if>
						<a href="/Poing/rest/detail.do?rest_seq=${dto.rest_seq}"
							class="image"
							data-src="http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg"
							style="display: block; background-color: gray">
							<div class="shading"></div>

							<div class="top">
								예약 ${dto.rest_reservation_cnt}&nbsp; 리뷰
								${dto.rest_review_cnt}&nbsp; 조회수 ${dto.rest_view_cnt} <br>
								<button class="" data-type="poing.restaurants.favorite"
									data-id="35740" onclick='return false;'>
									<i class="icon favorite "></i>
								</button>
							</div>
							<div class="bottom">
								<p class="coupon">티켓</p>
								<span class="name">${dto.rest_name}</span> <span class="area">${dto.rest_loc}</span>
							</div>
						</a>

						<div class="desc">
							<div class="place_info">
								<div class="rating">
									<div class="stars">


										<span class='star odd active'></span><span
											class='star even active'></span><span
											class='star odd active'></span><span
											class='star even active'></span><span
											class='star odd active'></span><span
											class='star even active'></span><span
											class='star odd active'></span><span
											class='star even active'></span><span class='star odd '></span><span
											class='star even '></span>
									</div>
									<div class="grade">${dto.rest_starpoint}점</div>
								</div>
								<div class="budget">${dto.rest_budget_type}</div>
								<div class="comment">${dto.rest_line_exp}</div>
								<ul class="detail">
									<li><a href="/restaurant/detail/35740?menu">메뉴있음</a></li>
									<li><a href="/restaurant/detail/35740?photo">사진 74장</a></li>
								</ul>
							</div>
						</div>

						<div class="btn">
							<button type="button" class="reserve"
								data-type="poing.reservation.add" data-id="35740">예약하기</button>
							<a href="/restaurant/detail/35740?review" class="review ">리뷰
								쓰기</a>
						</div>
					</div>
				</c:forEach>
			</div>

				<div id="pager">
				<div class="page-list">
				<ul class="pagination" onselectstart="return false;">
				
				<li class="prevAll">
					<a href="list.do?pg=${paging.doubleprevPageNo }">&lt;&lt;</a>
				</li>
				
				<li class="prev">
					<a href="list.do?pg=${paging.prevPageNo}">&lt;</a>
				</li>
				
				<c:forEach begin="${paging.firstPageNo }" end="${paging.finalPageNo}" step="1" var="cpage">	
					<c:if test="${cpage ne paging.cpage }"><li class="page" data-page="${cpage }"><a href="list.do?pg=${cpage}">${cpage}</a></li></c:if>
					<c:if test="${cpage eq paging.cpage }"><li class="page active" data-page="${cpage }"><a href="list.do?pg=${cpage}">${cpage}</a></li></c:if>
				</c:forEach>

				<li class="next">
					<a href="list.do?pg=${paging.nextPageno}">&gt;</a>
				</li>
				
				<li class="nextAll">
					<a href="list.do?pg=${paging.doublenextPageNo }">&gt;&gt;</a>
				</li>
				
				</ul>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="/WEB-INF/layout/footer.jsp"></jsp:include>
	
	<jsp:include page="/WEB-INF/layout/popup_wrap.jsp"></jsp:include>
	
	<jsp:include page="/WEB-INF/layout/javascript/default.jsp"></jsp:include>

</div>

<script>
function initMap() {

	  var map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 13,
	    center: {
	      lat: 37.524315,
	      lng: 127.01394
	    }
	  });
	  var infoWin = new google.maps.InfoWindow();
	  // Add some markers to the map.
	  // Note: The code uses the JavaScript Array.prototype.map() method to
	  // create an array of markers based on a given "locations" array.
	  // The map() method here has nothing to do with the Google Maps API.
	  var markers = locations.map(function(location, i) {
	    var marker = new google.maps.Marker({
	      position: location
	    });
	    google.maps.event.addListener(marker, 'click', function(evt) {
	      infoWin.setContent(location.info);
	      infoWin.open(map, marker);
	    })
	    google.maps.event.addListener(marker, 'dblclick', function() {
   		window.location.href = location.url;
		});
	    return marker;
	  });

	  // Add a marker clusterer to manage the markers.
	  var markerCluster = new MarkerClusterer(map, markers, {
	    imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
	  });

	}
	var locations = <%=sb%>;
		
		/* {
	  lat: -19.9286,
	  lng: -43.93888,
	  info: '<div><div class="inner"><img src="http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg" style="display: inline-block; width: 50px; height: 50px;"><div style="vertical-align: top; width: 134px; display: inline-block; margin-left:10px">${dto.rest_name}<br><span>${dto.rest_loc}</span></div></div></div>',
	  url: 'www.google.com'
	}, {
	  lat: -19.85758,
	  lng: -43.9668,
	  info: '<div><div class="inner"><img src="http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg" style="display: inline-block; width: 50px; height: 50px;"><div style="vertical-align: top; width: 134px; display: inline-block; margin-left:10px">${dto.rest_name}<br><span>${dto.rest_loc}</span></div></div></div>',
	  url: 'www.google.com'
	}, {
	  lat: -18.24587,
	  lng: -43.59613,
	  info: '<div><div class="inner"><img src="http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg" style="display: inline-block; width: 50px; height: 50px;"><div style="vertical-align: top; width: 134px; display: inline-block; margin-left:10px">${dto.rest_name}<br><span>${dto.rest_loc}</span></div></div></div>',
	  url: 'www.google.com'
	}, {
	  lat: -20.46427,
	  lng: -45.42629,
	  info: '<div><div class="inner"><img src="http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg" style="display: inline-block; width: 50px; height: 50px;"><div style="vertical-align: top; width: 134px; display: inline-block; margin-left:10px">${dto.rest_name}<br><span>${dto.rest_loc}</span></div></div></div>',
		  url: 'www.google.com'
	}, {
	  lat: -20.37817,
	  lng: -43.41641,
	  info: '<div><div class="inner"><img src="http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg" style="display: inline-block; width: 50px; height: 50px;"><div style="vertical-align: top; width: 134px; display: inline-block; margin-left:10px">${dto.rest_name}<br><span>${dto.rest_loc}</span></div></div></div>',
		  url: 'www.google.com'
	}, {
	  lat: -20.09749,
	  lng: -43.48831,
	  info: '<div><div class="inner"><img src="http://c2.poing.co.kr/PIMAGE-original/MjAxNzEw/150839398359e843ff78add.jpeg" style="display: inline-block; width: 50px; height: 50px;"><div style="vertical-align: top; width: 134px; display: inline-block; margin-left:10px">${dto.rest_name}<br><span>${dto.rest_loc}</span></div></div></div>',
		  url: 'www.google.com'
	}, {
	  lat: -21.13594,
	  lng: -44.26132,
	  info: "marker 7",
	  url: 'www.google.com'
	}, ]; */
</script>
 <script>
<%-- 
 function initMap() {
     body = document.getElementById("map");
     
     var positionMap = {lat: 37.498095, lng: 127.0761};
     var map = new google.maps.Map(document.getElementById('map'), {
       zoom: 12,
       center: positionMap
     });

     var places = [강남구, 역삼동];

     var markers=[];
     var markerCluster = new MarkerClusterer(map, markers, 
             {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
 

     geocoder = new google.maps.Geocoder();
     for (var i = 0; i<places.length; i++) {
       geocoder.geocode({"address":places[i]}, function(results, status){
         if (status === google.maps.GeocoderStatus.OK) {
           position = results [0].geometry.location;
           var marker = new google.maps.Marker({
             map: map,
             position: position
           });
           markers.push(marker);
           markerCluster.addMarker(marker);
         }
       });

     }
   }
  --%>

    </script>
   <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBd3AEpRuYNo5NnomHPAXXRCyXxgtYzz3g&callback=initMap"></script>
</body>
</html>