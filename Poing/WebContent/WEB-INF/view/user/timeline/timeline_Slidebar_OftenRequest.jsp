<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="sidebar_wrap" class="mypage">
	<div id="common_qna" class="sidebar">
		<div class="title">자주 묻는 질문</div>
		<ul class="list">
			<li class="item">포잉에 등재된 레스토랑의 선정 기준은 무엇인가요?</li>
			<li class="item">예약 후에 레스토랑을 방문하지 않을 경우 어떻게 되나요?</li>
			<li class="item">‘포잉 티켓과 프로모션’은 무엇인가요?</li>
			<li class="item">친구를 찾아 팔로우하고 싶어요.</li>
			<li class="item">다이닝 티켓의 영수증이 필요해요.</li>
		</ul>
		<a href="#">자주 묻는 질문 더보기</a>
	</div>
	<script>
		$(document).ready(function() {
			$("#common_qna>ul>li, #common_qna>a").click(function() {
				$.popup("/Poing/popup/qna.do");
			});
		});
	</script>
</div>
<div id="popup" style="display: none; opacity: 1;">
	<div class="shadow"></div>
	<div class="guide">
		<div id="qna">
			<i class="icon popup_close" data-close=""></i>
			<div class="body">
				<div class="title">자주 묻는 질문</div>

				<ul class="list">
					<li><span class="question">포잉에 등재된 레스토랑의 선정 기준은 무엇인가요?</span>
						<span class="answer">포잉은 전문 에디터 집단이 엄선한 레스토랑을 소개하고 있습니다.
							신뢰도 있는 레스토랑 컨텐츠를 제공하기 위해 에디터가 직접 방문하고 맛을 보며 레스토랑을 평가합니다. 더욱 더 정확한
							정보를 전달하기 위해 직접 발로 뛰며 꾸준히 레스토랑들을 검수해 나가고 있으니 지켜봐주시면 감사하겠습니다 :) </span></li>
					<li><span class="question">포잉의 예전 예약 데이터가 사라지면 어떻게 해야
							하나요?</span> <span class="answer">걱정하지 마세요! 예약을 할 때 번호 인증을 하면 포잉의
							예전 예약 데이터 (ex. 예약 내역, 찜한 매장)가 완벽하게 복구됩니다. 지금 바로 예약해보세요 :) </span></li>
					<li><span class="question">예약 후에 레스토랑을 방문하지 않을 경우 어떻게
							되나요?</span> <span class="answer">예약 취소 또는 기타 통보 없이 레스토랑을 방문하지 않는
							‘No-Show(노쇼)’ 행위는 예약에 맞춰 식재료를 준비하는 레스토랑에 금전적 손실을 입힐 수 있습니다. 또한 다른
							손님에게도 피해를 줄 수 있으므로 포잉은 이에 대하여 강력하게 대응하고 있습니다. <br>
						<br>한 달간 일정 횟수 이상의 노쇼를 하는 유저는 포잉의 블랙 리스트에 등재되고 계정이 정지되어 포잉의
							예약 서비스를 이용하실 수 없게 됩니다. 불가피하게 예약을 지키기 어려울 때는 꼭 예약취소를 해주시기 바랍니다.
							예약은 레스토랑과의 소중한 약속입니다. 이것을 지키는 것이 기본적인 에티켓이자 외식 문화의 발전을 위한 첫걸음입니다.
					</span></li>
					<li><span class="question">‘포잉 티켓과 프로모션’은 무엇인가요?</span> <span
						class="answer">포잉이 단독으로 진행하는 최고의 레스토랑 할인 및 다양한 혜택을 제공하는
							프로모션입니다. 새로운 쿠폰 및 프로모션 정보를 받고 싶다면 앱 설정의 ‘알림 설정’ 버튼을 ON으로 바꿔주세요 :)</span>
					</li>
					<li><span class="question">레드 포인트가 무엇인가요?</span> <span
						class="answer">레드 포인트는 포잉 서비스 내에서 결제 시, 현금처럼 사용할 수 있는
							사이버머니입니다. 결제 시 단독으로, 또는 다른 결제 수단을 함께 나누어 결제할 수 있습니다. </span></li>
					<li><span class="question">티켓 결제시, 예약일 선택 후 결제 완료 전이라면
							다른 사람이 먼저 예약할 수도 있나요? </span> <span class="answer">일부 티켓의 경우, 예약
							선택 중복 건이 발생할 수 있습니다.<br> 그와 같은 경우에는 결제를 먼저 완료하신 고객님께서 자리를
							확보하실 수 있습니다.
					</span></li>
					<li><span class="question">티켓 예약 내역 확인은 어디에서 하나요?</span> <span
						class="answer">티켓 예약 내역은 ‘마이페이지 &gt; 예약’ 또는 ‘마이페이지 &gt;
							티켓’에서 확인하실 수 있습니다. </span></li>
					<li><span class="question">구매한 티켓의 예약일 변경 및 구매취소를 하는
							방법과 관련 규정에 대해 자세히 알고 싶어요. </span> <span class="answer">‘마이페이지
							&gt; 티켓 &gt; 각 티켓의 상세 페이지’와 ‘마이페이지 &gt; 설정 및 관리 &gt; 구매내역 &gt; 각
							구매건의 상세 페이지’에서 예약일 변경과 구매취소를 진행하실 수 있습니다. <br>
						<br>
						<br> <br> 예약 변경 및 취소 시에는 기본적으로 아래의 환불 규정을 따르나, 티켓에 따라 티켓
							상세 정보에 별도의 환불 규정이 안내될 수 있습니다. 이러한 경우에는 티켓 상세 정보에 명시된 환불 규정이 우선하여
							적용됩니다.<br>
						<br>
						<br> <br> 티켓 사용일(예약일자) 기준 하루 전 예약 취소 시 : 취소 수수료 10% 발생<br>
						<br> 티켓 사용일(예약일자) 당일 예약 취소 시 : 취소 수수료 20%발생<br>
						<br> 티켓 사용일(예약일자) 당일 예약 시간 3시간 이내 취소 시 : 취소 수수료 30% 발생<br>
						<br> 티켓 사용일(예약일자) 당일 예약 시간 30분 이내 취소 시 : 취소 수수료 50% 발생<br>
						<br> 예약 취소 또는 변경 없이 미 방문한 경우 : 전액 환불 불가<br>
						<br>
						<br> <br> 예약 날짜 변경은 예약시간 3시간 전까지만 가능합니다. 이후에는 예약 날짜는 변경이
							불가능하며, 예약 시간 30분전까지는 당일 내 예약시간만 변경하실 수 있습니다. 단, 매장의 상황에 따라 당일 예약
							변경의 가능여부 확인에 시간이 소요되거나, 불가능할 수 있습니다. 변경된 예약을 취소하는 경우에는 예약 변경이 최초로
							접수된 시점을 기준으로 취소 수수료가 부과됩니다.
					</span></li>
					<li><span class="question">한 매장에서 다수의 티켓을 구매했는데, 부분 취소를
							하고 싶어요.</span> <span class="answer">구매하신 티켓의 옵션이나 수량의 부분취소를 원하실
							경우, 포잉 고객센터로 문의하시기 바랍니다. <br>
						<br>
						<br> 포잉 고객센터: 02-564-1155 <br>(운영시간: 평일 오전 10시 ~ 오후 7시)
							<br>
					</span></li>
					<li><span class="question">친구를 찾아 팔로우하고 싶어요.</span> <span
						class="answer">더 많은 친구들과 포잉을 사용하고 싶으시다구요? <br> 포잉에 이미
							가입한 친구들을 찾고 싶으시다면 ‘메인화면의 검색창 → 사용자 검색 → 페이스북 친구 찾기'를 해보세요.
					</span></li>
					<li><span class="question">레스토랑 정보가 올바르지 않아요.</span> <span
						class="answer">영업 정보, 메뉴 정보, 없어진 매장 정보 등이 사실과 다를 경우, 각 매장의
							상세 페이지에 위치한 “정보를 수정하세요!” 버튼을 눌러 정확한 정보를 알려주세요. 사실 확인 후 관련 정보를
							업데이트하겠습니다.</span></li>
					<li><span class="question">포잉페이에 대해 설명해주세요.</span> <span
						class="answer">포잉페이는 카드를 등록하고 간편하게 결제하는 시스템입니다. 모든 카드정보는
							암호화가 적용되어 NICE 정보통신의 결제모듈로 안전하게 처리되오니, 안심하고 사용하세요.<br>
					</span></li>
					<li><span class="question">포잉페이에 카드를 등록하다가 비밀번호 오류가
							났습니다.</span> <span class="answer">비밀번호를 3회 이상 잘못 입력한 경우 ‘비밀번호 입력
							횟수 초과’로 인해 등록이 제한될 수 있습니다. 해당 신용카드 고객센터를 통해 비밀번호를 재설정하신 후, 포잉페이
							등록을 해주시기 바랍니다. <br>
					</span></li>
					<li><span class="question">포잉페이 카드 등록은 어디에서 하나요?</span> <span
						class="answer">‘마이페이지 &gt; 설정 및 관리 &gt; 포잉페이 관리 &gt; 새로운 카드
							등록하기’에서 카드를 등록하실 수 있습니다. <br>
					</span></li>
					<li><span class="question">포잉페이에 등록된 카드 삭제는 어디에서 하나요? </span>
						<span class="answer">‘마이페이지 &gt; 설정 및 관리 &gt; 포잉페이 관리’에서
							카드를 삭제하실 수 있습니다. </span></li>
					<li><span class="question">포잉페이 결제비밀번호를 잊어버렸어요. </span> <span
						class="answer">결제비밀번호를 잊어버리신 경우, 카드 삭제 후 재등록하여 사용이 가능합니다.</span></li>
					<li><span class="question">포잉페이에 등록한 카드를 분실했어요.</span> <span
						class="answer">해당 카드의 카드사로 분실신고를 접수하신 후, ‘마이페이지 &gt; 설정 및
							관리 &gt; 포잉페이 관리’ 페이지에서 카드 삭제를 해주세요. 분실신고가 접수된 카드는 결제수단에 등록이
							되어있더라도, 실제 결제시 사용이 불가한 점 참고 부탁드립니다. </span></li>
					<li><span class="question">다이닝 티켓의 영수증이 필요해요.</span> <span
						class="answer">구매하신 다이닝 티켓의 영수증은 포잉웹사이트(www.poing.co.kr)에서
							확인하실 수 있습니다. '마이페이지 &gt; 결제 &gt; 영수증 출력'에서 매출 전표 미리보기 및 출력이
							가능합니다.</span></li>
					<li><span class="question">포잉 가입 시 사용한 페이스북 계정을 분실/탈퇴
							하였는데 로그인할 방법은 없나요?</span> <span class="answer">페이스북 로그인 시 사용한 이메일
							주소를 사용하신다면 이메일 계정으로 변경 후 서비스 이용이 가능합니다.<br> 페이스북으로 가입한 계정을
							이메일 계정으로 변경하기 위해서는 포잉 고객센터로 문의주시기 바랍니다. <br> 포잉 고객센터:
							contact@poing.io 02-564-1155 (평일 오전 10시 ~ 오후 7시)
					</span></li>
					<li><span class="question">가입한 이메일주소가 생각나지 않아요.</span> <span
						class="answer">포잉 고객센터로 문의 주시면 가입 이메일 주소 찾기를 도와드립니다.<br>
							포잉 고객센터: contact@poing.io 02-564-1155 (평일 오전 10시 ~ 오후 7시)
					</span></li>
				</ul>
			</div>
		</div>

	</div>
</div>