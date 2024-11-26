<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
<!-- Bootstrap DatePicker -->
<link rel="stylesheet" href="/static/assets/css/plugins/datepicker-bs5.min.css">
<link rel="stylesheet" href="/static/assets/css/user.css">
<!-- [Page specific CSS] end -->

<!-- [ Main Content ] start -->
<div class="pc-container">
  
  <div class="pc-content">
    <!-- [ page title ] start -->
    <div class="page-header">
      <div class="page-block">
        <div class="row align-items-center">
          <div class="col-md-12">
            <div class="page-header-title">
              <h2 class="mb-0">휴면 회원 전환 대상자 조회</h2>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    
    <div class="row">
      <!-- [ block1 : 회원 검색 ] start -->
      <div class="col-lg-12">
      	<div class="card table-card">
          <div class="card-body p-4 ">
            <h4>전환 대상자 검색</h4>
            <div class="mb-4">
              <label class="form-label">휴면 회원 전환 대상 :</label>
              <div class="btn-group" role="group">
                <input type="radio" class="btn-check" id="memberDormantTypeAll" name="memberDormantType">
                <label class="btn btn-outline-info" for="memberDormantTypeAll">전체 휴면 회원</label>
                <input type="radio" class="btn-check" id="memberDormantTypeSpecific" name="memberDormantType">
                <label class="btn btn-outline-info" for="memberDormantTypeSpecific">특정 조건 휴면 회원</label>
              </div>
            </div>
            <div class="mb-4">
              <label class="form-label">특정 휴면 회원 검색 조건   :</label>
						<div class="btn-group" role="group">
							<input type="checkbox" class="btn-check" id="btncheck1">
							<label class="btn btn-outline-secondary" for="btncheck1">1년 이내 휴면 전환된 회원</label>
							<input type="checkbox" class="btn-check" id="btncheck2">
							<label class="btn btn-outline-secondary" for="btncheck2">쇼핑정보 SMS 수신 동의한 회원</label>
							<input type="checkbox" class="btn-check" id="btncheck3">
							<label class="btn btn-outline-secondary" for="btncheck3">쇼핑정보 이메일 수신 동의한 회원</label>
						</div>
            </div>
            <div class="mb-4">
              <label class="form-label">전환 대상 사전 안내 :</label>
              <p>사전 안내 발송 예정</p>
            </div>
            <div class="mb-4">
              <label class="form-label">전환 대상 사후 추가 안내 :</label>
              <div class="btn-group" role="group">
                <input type="radio" class="btn-check" id="use" name="useornot">
                <label class="btn btn-outline-info" for="use">사용함</label>
                <input type="radio" class="btn-check" id="not" name="useornot">
                <label class="btn btn-outline-info" for="not">사용안함</label>
              </div>
            </div>
            <div class="text-center">
              <button type="button" class="btn btn-primary">검색</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 검색 ] end -->
      
      <!-- [ block2 : 회원 목록 ] start -->
      <div class="col-lg-12">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-4 pt-2 ">검색 결과</h4>
            <div class="mb-4">
              <dt>전환 대상 회원 수 :</dt>
              <dd class="fw-bold">약 0명</dd>
            </div>
            <div class="mb-4">
              <label class="form-label">전환 회원 안내 방법  :</label>
              <p>
                 개인정보보호 위원회 권고사항에 따라 휴면 회원을 일반 회원으로 전환할 때는 전환 대상 회원에게 안내해야 해요.
                 사전 안내는 전환 대상 회원에게 카카오알림톡(실패 시 SMS 대체발송)으로 전환 7일전에 발송될거예요.</p>
            </div>
            <div class="mb-4">
              <label class="form-label">전환 예정 일정 :</label>
              <div class="d-flex flex-row justify-content-center">
                <div class="text-center p-3">
                  <p class="btn btn-icon btn-primary avtar-xl mb-4">1</p>
                  <p class="fw-bold text-primary">사전 안내 메시지 발송</p>
                  <p class="text-body-tertiary">2024-10-17 이후 순차 발송 예정</p>
                </div>
                <div class="text-center p-3">
                  <p class="btn btn-icon btn-primary avtar-xl mb-4">2</p>
                  <p class="fw-bold text-primary">휴면 회원 전환</p>
                  <p class="text-body-tertiary">2024-10-24 이후 순차 전환 예정</p>
                </div>
                <div class="text-center p-3">
                  <p class="btn btn-icon btn-primary avtar-xl mb-4">3</p>
                  <p class="fw-bold text-primary">사후 추가 안내 메시지</p>
                  <p class="text-body-tertiary">2024-10-24 이후 순차 전환 예정</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block2 : 회원 목록 ] end -->
      <!-- [ block3 : 추가 설정 ] start -->
      <div class="col-lg-12">
        
      </div>
      <!-- [ block3 : 추가 설정 ] end -->
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->

<!-- [Page Specific JS] start -->
<script src="/static/assets/js/plugins/simple-datatables.js"></script>
<!-- DatePicker js -->
 <script src="/static/assets/js/plugins/datepicker-full.min.js"></script>
<script>
document.title = "주문회원 조회 | Hermes Admin";

(function () {
  const datepicker_range = new DateRangePicker(document.querySelector('#datepicker_range'), {
    buttonClass: 'btn'
  });
})();

</script>
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>