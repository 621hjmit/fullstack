<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/style.css' />
<link rel='stylesheet' href='/static/css/contact.css' />


<!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->
<main id="main" class="margin-bottom-60 mobile-margin-rl-15 contact">
   <div class="main-container">
      <div class="back-button-area">
            <button class="back-button" role="link" onclick="location.href='/'">
            <div class="back-button-left">
               <svg xmlns="http://www.w3.org/2000/svg" width="27" height="16" focusable="false" aria-hidden="true">
                  <g fill="none" fill-rule="evenodd" stroke="#333" stroke-linecap="round" stroke-width="2">
                     <path _ngcontent-fullstack-c203198840="" d="M10 1L2 8l8 7M4 8h21.1874547"></path>
                  </g>
               </svg>
            </div>
            <div class="back-button-right"><a href="/" class=" back-text hide-in-mobile">홈으로 돌아가기</a></div>
         </button>
      </div>
      <div class="bright-back-color">
     <div class="title">
        <h1 class="boxed-title">고객센터</h1>
     </div><!-- title -->
     <div class="body">
        <p>
           <span class="fw-bold">고객센터</span><br>
           전화 : <span class="text-decoration-underline">(02)123-1234</span><br>
           <span>월요일-일요일 오전 : 9:30 - 오후 8:00 (공휴일 제외)</span>
        </p>
        <p class="fs-4">
           질문이 있으신가요? <span class="fw-bold text-decoration-underline">자주묻는 질문</span>에서 답을 찾으실 수 있습니다.<br>
           필요 시 풀스택 고객센터로 문의 주십시오.</p>
        <p class="fc-gray ta-right fs-5 margin-bottom-0">*필수 항목</p>
           <div class="row gap20">
              <div class="col-md-5 generic-input-box">
                 <input type="text" id="uiLastName" name="userLastName" class="generic-input required-input" required>
                 <label class="generic-label" for="userLastName">성 <span aria-hidden="true"> *</span></label>
                 <div class="warning-required"><span>필수항목</span></div>
              </div>
              <div class="col-md-5 generic-input-box">
                 <input type="text" id="uiFirstName" name="userFirstName" class="generic-input required-input" required>
                 <label class="generic-label" for="userFirstName">이름 <span aria-hidden="true"> *</span></label>
                 <div class="warning-required"><span>필수항목</span></div>
              </div>
           </div>
           <div class="generic-input-box">
              <input type="text" id="uiEmail" name="userEmail" class="generic-input required-input" required>
              <label class="generic-label" for="userEmail">이메일 <span aria-hidden="true"> *</span></label>
              <div class="warning-required"><span>필수항목</span></div>
           </div>
           <div class="row m-row">
              <div class="col generic-input-box width90">
                 <input type="text" id="uiCountryCode" name="userFirstName" class="generic-input required-input" required value="+82" maxlength="5">
                 <label class="generic-label" for="userFirstName">국가 코드 <span aria-hidden="true"> *</span></label>
                 <div class="warning-required"><span>필수항목</span></div>
              </div>
              <div class="col generic-input-box">
                 <input type="text" id="uiPhone" name="userPhone" class="generic-input required-input" required>
                 <label class="generic-label" for="userPhone">전화 <span aria-hidden="true"> *</span></label>
                 <div class="warning-required"><span>필수항목</span></div>
              </div>
           </div>
           <div class="generic-input-box custom-select">
              <select id="csSubject" name="csSubject" class="generic-select required-select">
                 <option value="0" disabled selected value class="hidden"></option>
                 <option value="1">제품 정보</option>
                 <option value="2">매장 정보</option>
                 <option value="3">고객 정보 (고객 계정, 개인 정보 변동 사항 등)</option>
                 <option value="4">매장 구매 제품 반품 및 교환</option>
                 <option value="5">온라인 구매 제품 반품 및 교환</option>
                 <option value="6">결제 관련 문의</option>
                 <option value="7">고객 경험</option>
                 <option value="8">애프터 서비스</option1>
                 <option value="9">웹사이트 정보</option>
                 <option value="10">보도 자료</option>
                 <option value="11">가구 전문가</option>
                 <option value="12">안장 전문가</option>
                 <option value="13">동의 철회 &amp; 계정 삭제하기</option>
                 <option value="14">기타</option>
             </select>
             <label for="csSubject" class="generic-label">주제를 선택해주세요. *</label>
             <div class="warning-required"><span>필수항목</span></div>
           </div>
           
           <div class="generic-input-box custom-select">
              <input id="ubTitle" name="ubTitle" class="generic-input required-input" required/>
             <label for="ubTitle" class="generic-label">제목 *</label>
             <div class="warning-required"><span>필수항목</span></div>
           </div>
           <div class="generic-input-box textarea">
              <textarea type="text" id="ubMessage" name="userMessage" class="required-input generic-textarea" requiredrows="5" cols="200"></textarea>
              <label class="generic-label" for="userMessage">메시지 <span aria-hidden="true"> *</span></label>
              <div class="warning-required"><span>필수항목</span></div>
           </div>
           
           <div class="row gap20 flex-space-between">
              <div class="col-md-5">
                 <p>메시지를 발송함으로써 <a href="/views/pages/legal_terms" class="text-decoration-underline">이용약관</a>에 동의하게 되고. 개인정보는 풀스택의 <a href="/views/pages/legal-privacy" class="text-decoration-underline">개인정보처리방침</a>에 따라 처리됩니다.</p>
              </div>
              <div class="col-md-5 text-right m-text-center">
                 <input type="button" class="button-base button-primary height-normal size-200" value="저장" onclick="save()">
              </div>
           </div>
         </div><!-- body -->
      </div><!-- .bright-back-color -->
   </div><!-- .main-container -->
</main>
<script>let user = '<c:out value="${user}"/>'</script>
<!-- 로컬 js -->
<script src='/static/js/script.js' defer></script>
<script src='/static/js/pages/contact.js' defer></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>