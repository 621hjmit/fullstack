<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

   <!-- 로컬 CSS -->
   <link rel='stylesheet' href='/static/css/user/user.css' />

   <!-- 로컬 js -->
   <script src='/static/js/script.js' defer></script>
   <script src='/static/js/user/login.js' defer></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous" defer></script>
   
	<main id="main" class="margin-bottom-60 mobile-margin-rl-15 contact">
		<div class="main-container">
			<div class="">
				<div class="title">
					<h1 class="boxed-title">계정 만들기</h1>
				</div>
				<!-- title -->
				<div class="body bright-back-color row gap20">
					<div class="col-md-6">
						<h2 class="fs-33 fw-bold mb-40">로그인 정보</h2>
						<div class="generic-input-box">
							<input type="text" id="userEmail" name="userEmail"
								class="generic-input required-input disabled" required value="" disabled>
							<label
								class="generic-label selected" for="userEmail">이메일 <span
								aria-hidden="true"> *</span></label>
							<div class="warning-required">
								<span>필수항목</span>
							</div>
						</div>
						<div class="info hide" id="emailInfo">
							<p class="text-xxsmall">johndoe@email.com 형식으로 작성해 주십시오.</p>
						</div>
						<div class="row m-row">
							<div class="col generic-input-box width90">
								<input type="tel" id="uiCountryCode" name="uiCountryCode" class="generic-input required-input" required value="+82" maxlength="5">
								<label class="generic-label" for="uiCountryCode">국가 코드 <span aria-hidden="true">*</span></label>
								<div class="warning-required"><span>필수항목</span></div>
							</div>
							<div class="col generic-input-box">
								<input type="tel" id="userPhone" name="userPhone"
									class="generic-input required-input" required> <label
									class="generic-label" for="userPhone">휴대전화 <span
									aria-hidden="true"> *</span></label>
								<div class="warning-required"><span>필수항목</span></div>
							</div>
						</div>
						<div class="info hide" id="phoneInfo">
							<p class="text-xxsmall">휴대폰번호의 첫 자리 0을 제외하고 1부터 작성해 주십시오.</p>
						</div>
						<!-- 
						<div class="row m-row gap20">
              <div class="col-md-5 generic-input-box">
                <input type="tel" id="userPhone" name="userPhone" class="generic-input required-input" required>
                  <label class="generic-label" for="userPhone"><span aria-hidden="true">확인 코드 *</span></label>
                <div class="warning-required"><span>필수항목</span></div>
              </div>
              <div class="col generic-input-box width90">
                <input type="button" id="smsCode" class="btn btn-border-black" value="코드 보내기" onclick="sendCode()">
              </div>
            </div>
             -->
						<div class="generic-input-box">
							<input type="password" id="userPassword" name="userPassword" class="generic-input required-input" required>
							<label class="generic-label" for="userPassword">비밀번호 <span aria-hidden="true"> *</span></label>
						</div>
						<div class="generic-input-box margin-bottom-37">
							<input type="password" id="userPassword2" name="userPassword" class="generic-input required-input" required>
							<label class="generic-label" for="userPassword2">비밀번호 재입력<span aria-hidden="true"> *</span></label>
							<div class="warning-required " id="pwdWarning"><span>두 개의 비밀번호가 서로 다릅니다. 다시 입력해주세요.</span></div>
						</div>
						<h2 class="fs-33 fw-bold  margin-bottom-20">개인 정보</h2>
						<div class="generic-input-box custom-select">
							<select id="gender" name="gender" class="generic-select required-select">
								<option value="0" disabled selected value class="hidden"></option>
								<option value="2">여성</option>
								<option value="1">남성</option>
							</select>
              <label for="gender" class="generic-label" id="genderLable">성별	 *</label>
							<div class="warning-required">
								<span>필수항목</span>
							</div>
						</div>
						<div class="row gap20">
						  <div class="col-md-5 generic-input-box">
                <input type="text" id="userLastName" name="userLastName"
                  class="generic-input required-input" required> <label
                  class="generic-label" for="userLastName">성 <span
                  aria-hidden="true"> *</span></label>
                <div class="warning-required">
                  <span>필수항목</span>
                </div>
              </div>
							<div class="col-md-5 generic-input-box">
								<input type="text" id="userFirstName" name="userFirstName"
									class="generic-input required-input" required> <label
									class="generic-label" for="userFirstName">이름 <span
									aria-hidden="true"> *</span></label>
								<div class="warning-required">
									<span>필수항목</span>
								</div>
							</div>
						</div>

						<div class="generic-input-box">
							<p class="fs-4 fw-bold">생년월일</p>
							<input type="date" class="generic-input" id="userBirth" value="1990-01-01">
						</div>
					</div>
					<div class="col-md-6">
            <div class="row gap20 mt-40">
              <div class="col-md-5 generic-input-box">
                <input type="text" id="aiZipcode" name="aiZipcode" class="generic-input required-input disabled" required disabled>
                <label class="generic-label" for="aiZipcode">우편번호 <span aria-hidden="true"> *</span></label>
                <div class="warning-required">
                  <span>필수항목</span>
                </div>
              </div>
              <div class="col-md-5 generic-input-box">
                <input type="button" id="search" name="search" class="btn btn-border-black" value="우편번호 검색" onclick="getAddress()">
              </div>
            </div>
            <div class="generic-input-box">
              <input type="text" id="aiAddress1" name="aiAddress1" class="generic-input required-input disabled" required value="" disabled>
              <label class="generic-label" for="aiAddress1">주소 1 <span aria-hidden="true">*</span></label>
            </div>
            <div class="generic-input-box">
              <input type="text" id="aiAddress2" name="aiAddress2" class="generic-input required-input" required value="">
              <label class="generic-label" for="aiAddress2">주소 2 <span aria-hidden="true">*</span></label>
            </div>

						<div class="gap20">
							<div class="">
							  <div>
								  <input type="checkbox" id="news" name="news" onclick="updateNewsValue()" value="0">
								  <label for="news">
										<p>개인정보처리방침에 따라 에르메스와 에르메스 그룹 산하의 회사에서 제공하는 추천, 서비스, 제품안내 또는 이벤트에 관한 정보를 이메일로 수신하는 것에 동의합니다.</p>
										<p class="mt-20">고객님의 온라인 계정 또는 에르메스가 발송하는 각 뉴스레터 하단에 있는 '구독 해지'링크를 통해 언제든 구독을 해지하실 수 있습니다.</p>
									</label>
								</div>
								<p class="mt-20">
								  <input type="checkbox" id="agreeAll">
								  <label class="" for="agreeAll" id="">모두 동의합니다.</label>
							  </p>
                <p class="mt-20">
									<input type="checkbox" id="agree1">
									<label class="" for="agree1" id="">Hermes가 계정생성을 위하여 정보를 수집 및 이용하는 것에 동의합니다. 상세보기 (필수)</label>
                </p>
                <p>
									<input type="checkbox" id="agree2">
									<label class="" for="agree2" id="">개인정보의 제3자 제공에 동의합니다. 상세보기 (필수)</label>
                </p>
                <p>
									<input type="checkbox" id="agree3">
									<label class="" for="agree3" id="">개인정보의 국외 이전에 동의합니다. 상세보기 (필수)</label>
								</p>
							</div>
							<div class="mt-40">
								<input type="button"
									class="button-base button-primary height-normal size-200"
									value="발송"
									onclick="checkCheckbox()">
							</div>
						</div>
					</div>
				</div>
				<!-- body -->
			</div>
			<!-- .bright-back-color -->
		</div>
		<!-- .main-container -->
	</main>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/static/js/user/create-account.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>