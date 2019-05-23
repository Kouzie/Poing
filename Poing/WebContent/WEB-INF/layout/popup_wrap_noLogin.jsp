<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="popup_wrap">
	<div id="popup" style="display: none; opacity: 1;">
		<div class="shadow"></div>


		<div class="guide">
			<div id="sign">
				<i class="icon popup_close" data-close=""></i>
				<div class="body" style="height: 590px;">
					<div class="login active" height="590">
						<p class="title">로그인</p>

						<form novalidate="">
							<input type="email" name="email" placeholder="이메일" required="">
							<input type="password" name="password" placeholder="비밀번호" required="">

							<button class="login">로그인</button>
						</form>
						<p class="forgot">비밀번호가 기억나지 않으세요? <a>재설정하기</a></p>

						<!-- <div id="naverIdLogin"><a id="naverIdLogin_loginButton" href="#"><img
									src="https://static.nid.naver.com/oauth/big_g.PNG?version=js-2.0.0" height="48"></a></div>
						<button type="button" class="facebook">페이스북 로그인</button> -->
						<hr>
						<button type="button" class="change">회원가입</button>
					</div>
					<div class="join " height="470">
						<p class="title">회원가입</p>
						<p class="subtitle">가입 유형을 선택해주세요.</p>
						<hr>

						<!-- <button type="button" class="naver">네이버로 간편하게 가입하기</button>
						<button type="button" class="facebook">페이스북로 간편하게 가입하기</button> -->
						<button type="button" class="email">이메일로 가입하기</button>
						<hr>
						<p class="already">이미 회원이신가요?</p>
						<button type="button" class="change">로그인</button>
					</div>
				</div>
			</div>
			<script>
				$("#popup").one("loaded", function () {
					$("#sign>.body").css('height', $("#sign>.body>div.active").attr('height'));
				});
				// 비밀번호 찾기
				$("#sign .login>.forgot>a").click(function () {
					$.popup("forgot_password");
				});
				// 이메일 로그인
				$("#sign .login>form").submit(function () {
					if (!this.email.checkValidity()) {
						noticePopupInit({
							message: "이메일을 확인해주세요."
						});
						return false;
					}
					if (!this.password.checkValidity()) {
						noticePopupInit({
							message: "비밀번호를 입력해주세요."
						});
						return false;
					}
					$.ajax({
						url: '/Poing/user/login.do',
						type: 'POST',
						data: {
							login_id: this.email.value,
							password: this.password.value,
							login_type: 'email',
							login_email: this.email.value
						},
						success: function (res) {
							res = $.parseJSON(res);
							if (res.status == true)
								location.reload();
							else
								noticePopupInit({
									message: res.error.message
								});
						}
					});

					return false;
				});
				// 이메일 회원가입
				$("#sign .join>.email").click(function () {
					/* post_to_url('/Poing/user/join.do', {
						type: 'email'
					}); */
					location.href = "/Poing/user/join.do";
				});
				/* $("#sign .join>.naver").click(function () {
					$("#naverIdLogin img").click();
				});
				// 페이스북 로그인/회원가입
				$("#sign .facebook").click(function () {
					FB.login(
						function (fbauth) {
							var fields = ['third_party_id', 'email', 'birthday', 'name', 'gender'];
							var access_token = FB.getAuthResponse()['accessToken'];
							FB.api('/me?fields=' + fields.join(','), function (user) {
								$.ajax({
									url: "/user/login",
									method: "POST",
									data: {
										login_id: user.id,
										password: access_token,
										fb_access_token: access_token,
										login_type: 'facebook',
										login_email: user.email
									},
									success: function (res) {
										res = $.parseJSON(res);
										if (res.status == true) {
											location.reload(true);
										} else if (res.error.classname == 'Validate_params') {
											location.reload(true);
										} else if (res.error.code == 514) {
											alert(res.error.message);
											location.href = "/";
										} else {
											var params = {
												type: 'facebook',
												third_party_id: access_token,
												fb_access_token: access_token,
												id: user.id,
												name: user.name,
												birthday: user.birthday,
												email: user.email,
												gender: user.gender,
												friends: []
											};
											FB.api(
												"/" + params.id + "/picture", {
													width: 200
												},
												function (profile) {
													if (profile && !profile.is_silhouette) {}

													params.friends = params.friends.join(',');
													post_to_url('/user/join', params);
												}
											);
											return;

											// 포잉 앱을 쓰는 페이스북 친구들 찾기
											FB.api('/me/friends?fields=id', function (data) {
												function addFriends(response) {
													if (response.data.length > 0)
														params['friends'].push.apply(params['friends'], $(response.data).map(
															function () {
																return this.id
															}));

													if (response.paging && response.paging.next) {
														$.ajax({
															url: response.paging.next,
															type: 'GET',
															success: function (res) {
																addFriends(res);
															}
														});
													} else {
														// 프로필 이미지 가져오기
														FB.api(
															"/" + params.id + "/picture", {
																width: 200
															},
															function (profile) {
																if (profile && !profile.is_silhouette) {}
																params.friends = params.friends.join(',');
																post_to_url('/user/join', params);
															}
														);
													}
												}
												addFriends(data);
											});
										}
									}
								});
							});
						}, {
							//scope: 'public_profile, email, user_birthday, user_friends'
							scope: 'public_profile, email, user_birthday'
						}
					);
				}); */

				// 탭 전환
				$("#sign div>.change").click(function () {
					var $target = $("#sign div.active").removeClass('active').siblings("div").addClass('active');

					$("#sign>.body").css('height', $target.attr('height'));
				});
			</script>
			<!-- <script>
				var naverLogin = new naver.LoginWithNaverId({
					clientId: "WqrKgZxyoy5yJvHux6qe",
					//callbackUrl: "http://poing.sanghyeok.mypoing.com/sign/naver",
					callbackUrl: "https://www.poing.co.kr/sign/naver",
					isPopup: false,
					loginButton: {
						color: "green",
						type: 3,
						height: 48
					}
				});
				naverLogin.init();
			</script> -->
		</div>
	</div>

	<script>
		var lastSearchRequest = 0;
		var loadingTimeout = null;

		function startLoading() {
			if (loadingTimeout == null) {
				loadingTimeout = setTimeout(function () {
					$("#loadingBox").show();
				}, 100);
			}
		}

		function endLoading() {
			clearTimeout(loadingTimeout);
			loadingTimeout = null;
			$("#loadingBox").hide();
		}
		window.onbeforeunload = function (e) {
			// check condition
			$("#loadingBox").show();
		};
		$(document).ajaxStart(function () {
			startLoading();
		});
		$(document).ajaxStop(function () {
			if ($.active == 0) {
				endLoading();
			}
		});
	</script>

	<i id="loadingBox" class="image"
		style="display: none; z-index: 10000; position: fixed; top: 0px; left: 0px; width: 100%; height: 100%; background: url(http://c1.poing.co.kr/original/images/spiffygif_52x52.gif) no-repeat center center black; opacity: 0.6; filter: alpha(opacity = 60);"></i>

	<div id="" class="noticePopup">
		<div class="noticeMessage"></div>
	</div>

	<script>
		// Default settings
		var noticePopupTimer = setTimeout(function () {}, 1);
		var noticePopupDefaultOption = {
			id: 'default',
			message: '기본 메시지 입니다.',
			padding: '20px 40px',
			fade: 500,
			duration: 1500,
			beforeShow: function () {}
		};

		function noticePopupInit(options) {
			// Set Options
			var settings = $.extend({}, noticePopupDefaultOption, options);
			$("div.noticePopup").attr("id", settings.id);

			var element = "div#" + settings.id + ".noticePopup";
			// Set Style
			$(element).css("padding", settings.padding);
			// Set Message
			$(element + ">div.noticeMessage").html(settings.message);

			// Set Position
			var width = $(element).outerWidth();
			var height = $(element).outerHeight();
			$(element).css("margin-left", String(-width / 2) + "px");
			$(element).css("margin-top", String(-height / 2) + "px");

			// Clear Animation
			$(element).stop();
			clearTimeout(noticePopupTimer);
			$(element).css("display", "none");

			// Start Animation
			$(element).fadeIn(settings.fade, function () {
				noticePopupTimer = setTimeout(function () {
					$(element).fadeOut(settings.fade);
				}, settings.duration);
			});
		}
	</script>

	<div class="confirmBackground"></div>
	<div id="" class="confirmPopup">
		<div class="confirmMessage"></div>
	</div>
	<div class="confirmNo">아니오</div>
	<div class="confirmOk">예</div>

	<script>
		// Default settings
		var confirmPopupTimer = setTimeout(function () {}, 1);
		var confirmPopupDefaultOption = {
			id: 'default',
			message: '기본 메시지 입니다.',
			padding: '20px 40px',
			fade: 500,
			duration: 1500,
			beforeShow: function () {},
			ok: function () {},
			no: function () {},
			end: function () {}
		};

		function hideConfirmPopup() {
			setTimeout(function () {
				$("div.confirmBackground").hide();
				$("div.confirmOk").stop();
				$("div.confirmNo").stop();
				$("div.confirmPopup").stop();
				$("div.confirmOk").hide();
				$("div.confirmNo").hide();
				$("div.confirmPopup").hide();

				if ($("div.confirmPopup").is(":visible") ||
					$("div.confirmPopup").is(":visible") ||
					$("div.confirmPopup").is(":visible")) {
					hideConfirmPopup();
				}
			}, 50);
		}

		function confirmPopupInit(options) {
			// Set Options
			var settings = $.extend({}, confirmPopupDefaultOption, options);
			$("div.confirmPopup").attr("id", settings.id);

			var element = "div#" + settings.id + ".confirmPopup";
			// Set Style
			$(element).css("padding", settings.padding);
			// Set Message
			$(element + ">div.confirmMessage").html(settings.message);

			// Set Position
			var width = $(element).outerWidth();
			var height = $(element).outerHeight();
			$(element).css("margin-left", String(-width / 2) + "px");
			$(element).css("margin-top", String(-height / 2) + "px");

			$("div.confirmNo").css('margin-left', String(-width / 2) + "px");
			$("div.confirmNo").css('margin-top', String(height / 2 + 2) + "px");
			$("div.confirmNo").css('width', String(width / 2 - 2) + "px");
			$("div.confirmOk").css('margin-left', String(1) + "px");
			$("div.confirmOk").css('margin-top', String(height / 2 + 2) + "px");
			$("div.confirmOk").css('width', String(width / 2 - 2) + "px");

			// Set Trigger
			$("div.confirmOk").on('click', function () {
				$("div.confirmOk").unbind('click');
				$("div.confirmNo").unbind('click');
				hideConfirmPopup();
				settings.ok();
				settings.end();
			});
			$("div.confirmNo").on('click', function () {
				$("div.confirmOk").unbind('click');
				$("div.confirmNo").unbind('click');
				hideConfirmPopup();
				settings.no();
				settings.end();
			});
			$(document).on('keyup', function (e) {
				if (e.keyCode === 13) {
					$("div.confirmOk").click();
				} else if (e.keyCode === 27) {
					$("div.confirmNo").click();
				}
			});

			// Clear Animation
			$("div.confirmOk").stop();
			$("div.confirmNo").stop();
			$(element).stop();
			clearTimeout(confirmPopupTimer);
			$("div.confirmOk").css("display", "none");
			$("div.confirmNo").css("display", "none");
			$(element).css("display", "none");

			// Start Animation
			$("div.confirmBackground").show();
			$("div.confirmOk").fadeIn(settings.fade);
			$("div.confirmNo").fadeIn(settings.fade);
			$(element).fadeIn(settings.fade);
		}
	</script>
</div>









