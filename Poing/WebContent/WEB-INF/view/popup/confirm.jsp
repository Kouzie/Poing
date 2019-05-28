<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="confirm" class=" alert">
		<div class="body">
		구매하실 옵션을 선택해주세요.	</div>

	<div class="buttons">
		<button type="button" class="accept" data-close>확인</button>
		<button type="button" class="deny" data-close>취소</button>
	</div>
</div>

<script>
			$.popup.interval = setTimeout(function(){ 
			$("#popup").animate({'opacity':0}, 500, function() {
				$(this).css('opacity', '').find(".accept").click();
			});
		}, 2000);
	</script>