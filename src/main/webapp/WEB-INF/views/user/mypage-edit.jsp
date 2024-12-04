<%@page import="com.shop.fullstack.user.voUserInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/user/mypage-edit.css' />
<link rel='stylesheet' href='/static/css/terms.css' />

<!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->

<main id="main" class="margin-top-60 margin-bottom-60 mobile-margin-rl-15 user">
    <div class="main-container">
      <div class="flex flex-center">
        <div class=" w-20p">
          <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        </div>
        <div class="bright-back-color   w-80p">
          <div class="title flex space-between">
            <h1 class="boxed-title">프로필 정보</h1>
          </div>
          <div class="flex j-c">
            <div class="body bright-back-color row gap20">
              <div class="col-md-6">
                <h2 class="fs-33   mb-40">로그인 정보</h2>
                <div class="generic-input-box">
                  <input type="text" id="uiEmail" name="userEmail"
                    class="generic-input required-input" required '>
                  <label
                    class="generic-label" for="userEmail">이메일 <span
                    aria-hidden="true"> *</span></label>
                  <div class="warning-required">
                    <span>필수항목</span>
                  </div>
                </div>
                <div class="row m-row">
                  <div class="col generic-input-box width90">
                    <input type="text" id="uiCountryCode" name="userCountryCode" class="generic-input required-input" required value="+82" maxlength="5"'>
										<label class="generic-label" for="userCountryCode">국가 코드 <span aria-hidden="true">*</span></label>
                    <div class="warning-required"><span>필수항목</span></div>
                  </div>
                  <div class="col generic-input-box">
                    <input type="text" id="uiPhone" name="userPhone" class="generic-input required-input" required  value=''>
										<label class="generic-label" for="userPhone">휴대전화 <span aria-hidden="true"> *</span></label>
                    <div class="warning-required"><span>필수항목</span></div>
                  </div>
                </div>
                <div class="generic-input-box">
                  <input type="password" id="uiPwd" name="userPassword" class="generic-input required-input" required>
                  <label class="generic-label" for="userPassword">비밀번호 <span aria-hidden="true"> *</span></label>
                </div>
                <div class="generic-input-box margin-bottom-37">
                  <input type="password" id="userPassword2" name="userPassword" class="generic-input required-input" required>
                  <label class="generic-label" for="userPassword2">비밀번호 재입력<span aria-hidden="true"> *</span></label>
                  <div class="warning-required " id="pwdWarning"><span>두 개의 비밀번호가 서로 다릅니다. 다시 입력해주세요.</span></div>
                </div>
                <h2 class="fs-33    mb-40">개인 정보</h2>
                <div class="generic-input-box custom-select">
                  <select id="uiGender" name="gender" class="generic-select required-select">
                    <option value="0" disabled selected value class="hidden"></option>
                    <option value="2">여성</option>
                    <option value="1">남성</option>
                  </select>
                  <label for="gender" class="generic-label selected" id="genderLable">성별  *</label>
                  <div class="warning-required">
                    <span>필수항목</span>
                  </div>
                </div>
                <div class="row gap20 m-row">
                  <div class="col-md-5 generic-input-box">
                    <input type="text" id="uiLastName" name="userLastName" value=''
                      class="generic-input required-input" required> <label
                      class="generic-label" for="userLastName">성 <span
                      aria-hidden="true"> *</span></label>
                    <div class="warning-required">
                      <span>필수항목</span>
                    </div>
                  </div>
                  <div class="col-md-5 generic-input-box">
                    <input type="text" id="uiFirstName" name="userFirstName" value=''
                      class="generic-input required-input" required> <label
                      class="generic-label" for="userFirstName">이름 <span
                      aria-hidden="true"> *</span></label>
                    <div class="warning-required">
                      <span>필수항목</span>
                    </div>
                  </div>
                </div>
    
                <div class="generic-input-box">
                  <p class="fs-4   mb-40">생년월일</p>
                  <input type="date" class="generic-input" id="uiBirth">
                </div>
              </div>
              <div class="col-md-6">
	              <h2 class="fs-33 mb-40">청구지 주소</h2>
                <div class="row gap20	m-row">
		              <div class="col-md-5 generic-input-box">
		                <input type="text" id="aiZipcode" name="aiZipcode" class="generic-input required-input disabled" required  disabled>
		                <label class="generic-label selected" for="aiZipcode">우편번호 <span aria-hidden="true"> *</span></label>
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
		              <label class="generic-label selected" for="aiAddress1">주소 1 <span aria-hidden="true">*</span></label>
		            </div>
		            <div class="generic-input-box">
		              <input type="text" id="aiAddress2" name="aiAddress2" class="generic-input required-input" required value="">
		              <label class="generic-label" for="aiAddress2">주소 2 <span aria-hidden="true">*</span></label>
		            </div>
              </div>
            </div>
            <!-- body -->
          </div>
          <hr class='light-color'/>
          <div class="body">
             <div class="row w-80p m-auto">
               <input type="checkbox" id="uiNews" name="newsletter">
               <label for="newsletter" class="lp">
                 <p>개인정보처리방침에 따라 에르메스와 에르메스 그룹 산하의 회사에서 제공하는 추천, 서비스, 제품안내 또는 이벤트에 관한 정보를 이메일로 수신하는 것에 동의합니다.</p>
                 <p>고객님의 온라인 계정 또는 에르메스가 발송하는 각 뉴스레터 하단에 있는 '구독해지' 링크를 통해 언제든 구독을 해지하실 수 있습니다.</p>
               </label>
             </div>
             <div class="mt-40 mb-25">
               <input type="button" class="button-base button-primary height-normal size-200" value="저장" onclick="save()">
               <input type="button" class="button-base button-outline-primary height-normal size-200 margin-top-10" value="취소" onclick="cancel()">
               <div class="ta-center mt-20"><button type="button" onclick="out()" class=" text-underline">계정 삭제를 원하시나요?</button></div>
             </div>
           </div>
        </div>
      </div>
    </div><!-- .main-container -->
</main>

<!-- 로컬 js -->
<script>
const user = '<c:out value="${user}"/>';
</script>
<script src='/static/js/script.js' defer></script>
<script src='/static/js/user/mypage-edit.js' defer></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 로컬 js end -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>