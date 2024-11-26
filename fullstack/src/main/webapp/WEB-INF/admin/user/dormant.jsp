<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
<!-- [Page specific CSS] end -->
<script src="/static/assets/js/plugins/bootstrap-datepicker.min.js"></script>
<script src="/static/js/admin/user/dormant.js"></script>
<!-- [ Main Content ] start -->
<div class="pc-container">
  
  <div class="pc-content">
    <!-- [ page title ] start -->
    <div class="page-header">
      <div class="page-block">
        <div class="row align-items-center">
          <div class="col-md-12">
            <div class="page-header-title">
              <h2 class="mb-0">휴면 회원 관리
						<button type="button"
							class="btn btn-icon btn-link-primary avtar-xs"
							data-bs-toggle="popover" data-bs-title="휴면 회원 관리"
							data-bs-placement="bottom" data-bs-html="true"
							data-bs-content='
              <ul class="mList"><li><span class="text-danger">개인정보 유효기간제는 2023년 9월 15일 폐지되었어요. 이에 따라 아래 내용은 법률 폐지 이전 안내된 내용이며, 현재는 쇼핑몰 이용 의사에 따라 휴면 기능을 사용 또는 미사용할 수 있어요.</span></li></ul>
						<ul class="mList"><li>개인정보유효기간제는 쇼핑몰에 로그인한지 1년 이상 경과된 고객들을 자동으로 휴면회원 처리되고, 개인정보가 분리 보관하는 법률이에요.</li>
						<li>[쇼핑몰 설정 &gt; 기본 설정 &gt; 약관 · 정보 설정 &gt; 휴면 회원 기능 설정]에서 사용함을 설정하면 휴면 회원 관리 이용이 가능합니다.</li></ul>
						<strong class="title">(구) 개인정보 유효기간제란?</strong>
						<ul class="mList">
						<li>1년 이상 서비스 이용 기록이 없는 고객의 개인정보를 삭제 또는 별도로 분리하여 저장해야 하는 제도입니다.</li>
						<li>관련 법률 : 폐지 전 개인정보 보호법 제39조의6 시행령 제48조의5</li>
						<li>휴면회원에게 메일과 SMS를 발송할 경우 법적인 불이익을 받으실 수 있습니다.</li></ul>'>
							<i class="ti ti-info-circle"></i>
						</button>
					</h2>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    
    <div class="row">
      
      <!-- [ block1 : 회원 검색 ] start -->
      <div class="col-lg-3">
        <div class="card table-card">
          <div class="card-body p-5 text-center">
           	<h4 class="mb-3">휴면 → 일반회원 전환하기</h4>
           	<p>잠들어 있던 쇼핑몰 휴면 회원을 깨워보세요! 일반회원으로 전환된 고객에게 안내 메시지도 보낼 수 있어요.</p>
           	<a href="/admin/user/change" class="btn btn-primary">회원 전환 하기</a>
          </div>
        </div>
      	<div class="card table-card">
          <div class="card-body p-4 ">
            <div class="mb-4">
              <label class="form-label">회원 정보:</label>
              <select class="form-select form-select-sm mb-2 " id="searchType">
               <option value="1">성</option>
               <option value="2">이름</option>
               <option value="3">이메일</option>
               <option value="4">휴대폰번호</option>
              </select>
              <input type="text" class="form-control form-control-sm" id="searchText">
            </div>
            <div class="mb-4">
              <label class="form-label">휴면 처리일 :</label><br/>
              <div class="btn-group mb-3" role="group">
							<input type="radio" class="btn-check" id="all" name="period" value="999">
							<label class="btn btn-outline-info" for="all">전체</label>
							<input type="radio" class="btn-check" id="today" name="period" value="0">
							<label class="btn btn-outline-info" for="today">오늘</label>
							<input type="radio" class="btn-check" id="three" name="period" value="2">
							<label class="btn btn-outline-info" for="three">3일</label>
							<input type="radio" class="btn-check" id="seven" name="period" value="6">
							<label class="btn btn-outline-info" for="seven">7일</label>
							<input type="radio" class="btn-check" id="month" name="period" value="29">
							<label class="btn btn-outline-info" for="month">30일</label>
							<input type="radio" class="btn-check" id="year" name="period" value="364">
							<label class="btn btn-outline-info" for="year">1년</label>
						</div>
						<div class="input-daterange input-group " id="datepicker_range">
                <input type="text" class="form-control text-left" placeholder="시작일" name="range-start" >
                <input type="text" class="form-control text-end" placeholder="종료일" name="range-end" >
              </div>                
            </div>
            <div class="mb-3 text-center">
              <button type="button" class="btn btn-primary" onclick="search()">검색</button>
					</div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 검색 ] end -->
      
      <!-- [ block2 : 회원 목록 ] start -->
      <div class="col-lg-9">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-2 pt-2 ">휴면 회원 목록</h4>
            <div class="mb-2 d-flex justify-content-between align-items-center">
              <div class="flex-grow-1">
              	[총 휴면회원 <span class="totalResults"></span>명] 검색결과 <span class="totalResults"></span>건
              </div>
             <select class="form-select form-select-sm width-120px" id="countPerPage" onchange="setCount(this)">
               <option value="10">10개씩 보기</option>
               <option value="20">20개씩 보기</option>
               <option value="30">30개씩 보기</option>
               <option value="40">40개씩 보기</option>
               <option value="50">50개씩 보기</option>
               <option value="100">100개씩 보기</option>
               <option value="200">200개씩 보기</option>
               <option value="500">500개씩 보기</option>
               <option value="1000">1000개씩 보기</option>
             </select>
            </div>
            <div class="table-responsive">
              <table class="table  table-bordered align-middle">
               <thead class="text-center">
                 <tr>
                   <th scope="col">휴면 처리일</th>
                   <th scope="col">이름</th>
                   <th scope="col">이메일</th>
                   <th scope="col">휴대폰 번호</th>
                   <th scope="col">성별</th>
                 </tr>
               </thead>
               <tbody class="text-center " id="userList">
               </tbody>
             </table>
             <!-- [ Pagination ] start -->        
             <nav id="pagination" aria-label="Page navigation example"></nav>
             <!-- [ Pagination ] end -->
            </div>
            <div class="no-result text-center mt-5 mb-5 visually-hidden">
              검색된 회원 내역이 없습니다.
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
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>